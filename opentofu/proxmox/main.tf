terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc1"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.2"
    }
  }
}

# First Proxmox provider for AritzNode
provider "proxmox" {
  pm_api_url   = "${var.px_url}/api2/json"
  pm_user      = var.px_user
  pm_password  = var.px_password
}

resource "proxmox_lxc" "LXC" {
  count = length(var.lxc_target_nodes) * length(var.lxc_hostnames)

  vmid         = count.index + 100
  target_node  = element(var.lxc_target_nodes, floor(count.index / length(var.lxc_hostnames)))
  hostname     = element(var.lxc_hostnames, count.index % length(var.lxc_hostnames))
  password     = var.lxc_password
  ostemplate   = "local:vztmpl/${var.lxc_template}"
  memory       = var.lxc_memory
  cores        = var.lxc_cores
  unprivileged = false
  start        = true
  swap         = 2048

  rootfs {
    storage = "local-lvm"
    size    = var.lxc_rootfs_size
  }

  network {
    name    = var.lxc_network_name
    bridge  = var.lxc_network_bridge
    ip      = "${element(var.lxc_network_ips[element(var.lxc_target_nodes, floor(count.index / length(var.lxc_hostnames)))], count.index % length(var.lxc_hostnames))}/${var.lxc_network_mask}"
    gw      = var.lxc_network_gw
  }

  features {
    nesting = true
  }

  ssh_public_keys = "${file("${var.vm_ssh_key_path}")}"
}


resource "null_resource" "install_docker" {
  # This resource depends on the Proxmox LXC containers being created
    depends_on = [proxmox_lxc.LXC]

  provisioner "local-exec" {
    command = "ansible-playbook playbooks/docker.yaml"
    working_dir = "/home/user/data-engineering/ansible"
  }
}

#resource "null_resource" "install_hadoop" {
#  # This resource depends on the Proxmox LXC containers being created
#    depends_on = [null_resource.install_docker]
#
#  provisioner "local-exec" {
#    command = "ansible-playbook playbooks/hadoop.yaml"
#    working_dir = "/home/user/data-engineering/ansible"
#  }
#}
