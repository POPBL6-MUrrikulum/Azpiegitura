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
  name         = var.vm_name
  machine_type = var.vm_machine_type
  tags         = ["http-server", "https-server"]
  zone         = "us-central1-a"
  boot_disk {
    auto_delete = true
    device_name = "debian"
    initialize_params {
      image = "projects/debian-cloud/global/images/debian-12-bookworm-v20240110"
      size  = 10
      type  = "pd-standard"
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
}

#resource "null_resource" "run_ansible_playbook" {
#  # This resource depends on the Proxmox LXC containers being created
#  depends_on = [google_compute_instance.debian]

#  # Use a trigger to force the resource to be recreated whenever the Ansible playbook or its dependencies change
#  triggers = {
#    always_run = "${timestamp()}"
#  }

#  provisioner "local-exec" {
#    command = "ansible-playbook playbooks/instalar-docker.yaml"

    # Specify the working directory where the Ansible playbook is located
#    working_dir = "/home/user/data-engineering/gcp/ansible"

    # Optionally, provide environment variables if needed
#    environment = {
      # Add environment variables here if your Ansible playbook relies on them
#    }
#  }
#}
