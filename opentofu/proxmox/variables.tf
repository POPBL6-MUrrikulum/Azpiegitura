variable "px_url" {}

variable "px_user" {
  description = "user para entrar en proxmox"
  type        = string
}

variable "px_password" {
  description = "password para entrar en proxmox"
  type        = string
}


variable "lxc_hostnames" {
  description = "nombres de los lxc"
  type        = list(string)
}

variable "lxc_target_node" {
  description = "nodo de proxmox"
  type        = string
}

variable "lxc_password" {
  description = "password de root dentro de lxc"
  type        = string
}

variable "lxc_template" {
  description = "iso que esta dentro de  /var/lib/vz/template/iso"
  type        = string
}

variable "lxc_memory" {
  description = "memoria ram en MB"
  type        = string
}

variable "lxc_cores" {
  description = "numero de cpu"
  type        = string
}

variable "lxc_rootfs_size" {
  description = "espacio para root? nose..."
  type        = string
}

variable "lxc_network_name" {
  description = "nose..."
  type        = string
}

variable "lxc_network_bridge" {
  description = "nose..."
  type        = string
}

variable "lxc_network_ips" {
  description = "ips de cada LXC"
  type        = list(string)
}

variable "lxc_network_mask" {
  description = "mask de cada LXC"
  type        = string
}

variable "lxc_network_gw" {
  description = "gateway"
  type        = string
}

variable "vm_ssh_key_path" {}