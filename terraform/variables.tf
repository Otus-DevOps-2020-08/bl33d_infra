variable cloud_id {
    description = "Cloud"
}

variable folder_id {
    description = "Folder"
}

variable zone {
    description = "Zone"
    # Значение по умолчанию
    default = "ru-central1-a"
}

variable public_key_path {
    description = "Path to public key used for ssh access"
}

variable subnet_id {
    description = "Subnet"
}

variable service_account_key_file {
    description = "Path to service account key file"
}

variable image_id {
    description = "VM image"
}

variable private_key {
    description = "Path to private key, used for connect via ssh"
}

variable yandex_compute_instance_zone {
    description =  "Zone for compute instance"
    default = "ru-central1-a"
}
