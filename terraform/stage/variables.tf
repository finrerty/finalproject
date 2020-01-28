variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default = "europe-west1"
}

variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}

variable db_disk_image {
  description = "Disk image for db"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable zone {
  description = "Zone"
  default = "europe-west1-b"
}
