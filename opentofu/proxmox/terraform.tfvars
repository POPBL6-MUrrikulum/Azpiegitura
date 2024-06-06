px_url              = "https://10.0.2.5:8006" 
px_user             = "root@pam"
px_password	        = "rootroot"

lxc_hostnames	    = ["fluxuak", "biltegiak"]
lxc_target_nodes    = ["AritzNode", "anderNode", "GorkaNode"]
lxc_password	    = "rootroot"
lxc_template	    = "debian-12-standard_12.2-1_amd64.tar.zst"
lxc_memory	        = "2048"
lxc_cores	        = "2"
lxc_rootfs_size	    = "40G"

lxc_network_name    = "my_network"
lxc_network_bridge  = "vmbr0"
lxc_network_ips	    = {
  AritzNode = ["10.0.2.10", "10.0.2.20"]
  anderNode = ["10.0.2.11", "10.0.2.21"]
  GorkaNode = ["10.0.2.12", "10.0.2.22"]
}
lxc_network_mask    = 24
lxc_network_gw	    = "10.0.2.2"
vm_ssh_key_path	    = "~/.ssh/gakoa.pub"