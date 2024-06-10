#############################
# Google provider variables #
#############################
gcp_credentials_file                 = "kredentzialak/gcp/PBL6.json"
gcp_project                          = "murrikulum-popbl6-2024"
gcp_region                           = "us-central1"
gcp_zone                             = "a"

#######################################
# Proxmox connection related variable #
#######################################
pm_master_ip = "10.0.2.5"
pm_api_url  = "https://10.0.2.5:8006/api2/json"
pm_password = "rootroot"
pm_user     = "root@pam"

###################################
# ovpn compute instance variables #
###################################
gcp_ovpnci_name                    = "ovpnserver"
gcp_ovpnci_machine_type            = "e2-small"
gcp_ovpnci_boot_image              = "projects/debian-cloud/global/images/debian-12-bookworm-v20240110"
gcp_ovpnci_boot_image_size_gb      = 10
gcp_ovpnci_boot_image_type         = "pd-balanced"
gcp_ovpnci_account_email           = "794378955314-compute@developer.gserviceaccount.com"
gcp_ovpnci_account_scopes          = [ "https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append" ]
gcp_ovpnci_ssh_key                 = "user:ssh-ed25519 AAAAC3NzaC1lZDI1NTE7AAAAIEDb1YbkEvfZEubEYikZS5CUZwXLdIMGe1jOVaDdtuGU user"
gcp_ovpnci_ssh_private_key_file    = "gcp"

###################################
# ovpn system container variables #
###################################
pm_ovpnsc_target_node    = "AritzNode"
pm_ovpnsc_ostemplate     = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.zst"
pm_ovpnsc_cores          = "1"
pm_ovpnsc_memory_mb      = "1024"
pm_ovpnsc_hostname       = "ovpnclient"
pm_ovpnsc_password       = "rootroot"
pm_ovpnsc_rootfs_size_gb = "8G"
pm_ovpnsc_network_name   = "eth0"
pm_ovpnsc_network_bridge = "vmbr0"
pm_ovpnsc_network_ip     = "10.0.2.100"
pm_ovpnsc_network_mask   = "24"
pm_ovpnsc_network_gw     = "10.0.2.2"
