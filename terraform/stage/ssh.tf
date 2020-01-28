resource "google_compute_project_metadata" "ssh-keys" {
  metadata = {
    ssh-keys = "vlad:${file(var.public_key_path)}"
  }
}
