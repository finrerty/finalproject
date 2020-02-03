resource "google_compute_instance" "ui" {
  name         = "search-engine-ui"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["search-engine-ui"]
  boot_disk {
    initialize_params {
      image = var.ui_disk_image
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.ui_ip.address
    }
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
  name    = "allow-ui-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["8000"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["search-engine-ui"]
}

resource "google_compute_address" "ui_ip" {
  name = "search-engine-ui-ip"
}
