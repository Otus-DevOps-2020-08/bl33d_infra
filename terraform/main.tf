provider "yandex" {
    service_account_key_file = "terraform-bot-key.json.example"
    cloud_id = var.cloud_id
    folder_id = var.folder_id
    zone = var.zone
}

resource "yandex_compute_instance" "app" {
    count = 2 # create two reddit apps
    name = "reddit-app-0${count.index}" # https://www.terraform.io/docs/configuration/resources.html#the-count-object
    zone = var.yandex_compute_instance_zone

    resources {
    cores  = 2
    memory = 2
    }

    metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
    }

    boot_disk {
        initialize_params {
        image_id = var.image_id
        }
    }

    network_interface {
        subnet_id = var.subnet_id
        nat       = true
    }

    connection {
        type = "ssh"
        host = self.network_interface.0.nat_ip_address # https://www.terraform.io/docs/configuration/resources.html#referring-to-instances
        user = "ubuntu"
        agent = false
        # путь до приватного ключа
        private_key = file(var.private_key)
    }

    provisioner "file" {
        source = "files/puma.service"
        destination = "/tmp/puma.service"
    }

    provisioner "remote-exec" {
        script = "files/deploy.sh"
    }
}
