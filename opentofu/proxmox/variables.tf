variable "px_url" {
  type = string
}

variable "px_user" {
  type = string
}

variable "px_password" {
  type = string
}

variable "lxc_hostnames" {
  type = list(string)
}

variable "lxc_target_nodes" {
  type = list(string)
}

variable "lxc_password" {
  type = string
}

variable "lxc_template" {
  type = string
}

variable "lxc_memory" {
  type = string
}

variable "lxc_cores" {
  type = string
}

variable "lxc_rootfs_size" {
  type = string
}

variable "lxc_network_name" {
  type = string
}

variable "lxc_network_bridge" {
  type = string
}

variable "lxc_network_ips" {
  type = map(list(string))
}

variable "lxc_network_mask" {
  type = number
}

variable "lxc_network_gw" {
  type = string
}

variable "vm_ssh_key_path" {
  type = string
}
