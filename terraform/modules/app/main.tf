resource "google_compute_instance" "app" {
  name         = "search-engine-app"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["search-engine-app"]
  boot_disk {
    initialize_params {
      image = var.app_disk_image
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
