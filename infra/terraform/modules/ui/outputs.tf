output "ui_external_ip" {
  value = google_compute_instance.ui.network_interface.0.access_config.0.nat_ip
}
