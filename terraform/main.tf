terraform {
  # Версия terraform
  required_version = "~> 0.12.8"
}

provider "google" {
  # Версия провайдера
  version = "2.15"

  # ID проекта
  project = var.project
  region  = var.region
}

resource "google_compute_instance" "ui" {
  name         = "search-engine-ui"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["ui-server"]

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    ssh-keys               = "vlad:${file(var.public_key_path)}"
    block-project-ssh-keys = false
  }

  connection {
    type        = "ssh"
    host        = self.network_interface[0].access_config[0].nat_ip
    user        = "vlad"
    agent       = false
    private_key = file(var.private_key_path)
  }
}

resource "google_compute_firewall" "firewall_ui" {
  name = "default-ui-server"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["8000"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["ui-server"]
}

resource "google_compute_project_metadata" "ssh-keys" {
  metadata = {
    ssh-keys = "vlad:${file(var.public_key_path)}"
  }
}
