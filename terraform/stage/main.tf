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

module "db" {
  source           = "../modules/db"
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  zone             = var.zone
  db_disk_image    = var.db_disk_image
}

module "ui" {
  source           = "../modules/ui"
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  zone             = var.zone
  ui_disk_image    = var.ui_disk_image 
}
