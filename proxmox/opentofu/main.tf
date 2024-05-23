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

provider "proxmox" {
  pm_api_url        = "${var.px_url}/api2/json"
  pm_user           = var.px_user
  pm_password       = var.px_password
}

resource "proxmox_lxc" "LXC" {
  count             = length(var.lxc_hostnames)
  target_node       = var.lxc_target_node
  hostname          = var.lxc_hostnames[count.index]
  password          = var.lxc_password
  ostemplate        = "local:vztmpl/${var.lxc_template}"
  memory            = var.lxc_memory
  cores             = var.lxc_cores
  unprivileged      = false
  start             = true
  swap              = 1024
  

  rootfs {
    storage         = "local-lvm"
    size            = var.lxc_rootfs_size
  }
  
  network {
    name            = var.lxc_network_name
    bridge          = var.lxc_network_bridge
    ip              = "${var.lxc_network_ips[count.index]}/${var.lxc_network_mask}"
    gw              = var.lxc_network_gw
  }
  # Habilitar anidamiento en el contenedor LXC
  features {
    nesting = true
  }

   # Añade la clave pública SSH al metadata del contenedor LXC (el simbolo del dolar es para de)
  ssh_public_keys   = "${file("${var.vm_ssh_key_path}")}"
}
resource "null_resource" "run_ansible_playbook" {
  # This resource depends on the Proxmox LXC containers being created
    depends_on = [proxmox_lxc.LXC]

  # Use a trigger to force the resource to be recreated whenever the Ansible playbook or its dependencies change
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "ansible-playbook playbooks/instalar-docker.yaml"
    working_dir = "../ansible"
  }
}
