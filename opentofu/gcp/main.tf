terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.0"
    }
  }
}

provider "google" {
  credentials = file(var.gcp_credential)
  project     = var.gcp_project
  region      = "us-central1"
}

resource "google_compute_instance" "debian" {
  count             = length(var.vm_name)
  name         = var.vm_name[count.index]
  machine_type = var.vm_machine_type
  tags         = ["http-server", "https-server"]
  zone         = "us-central1-a"
  boot_disk {
    auto_delete = true
    device_name = "debian"
    initialize_params {
      image = "projects/debian-cloud/global/images/debian-12-bookworm-v20240110"
      size  = 30
      type  = "pd-ssd"
    }
    mode = "READ_WRITE"
  }
  scheduling {
    automatic_restart   = false
    on_host_maintenance = "MIGRATE"
    preemptible         = false
  }
  metadata = {
    # Add SSH key to the instance's metadata
    ssh-keys = "${var.vm_ssh_user}:${file("${var.vm_ssh_key_path}")}"
  }
  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }
    stack_type  = "IPV4_ONLY"
    subnetwork  = "projects/${var.gcp_project}/regions/us-central1/subnetworks/default"
  }
  #metadata_startup_script = <<-EOF
  #  #!/bin/bash
  #  sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
  #  sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
  #  systemctl restart sshd
  #EOF
  metadata_startup_script = <<-EOF
    sudo dpkg --configure -a
  EOF
}