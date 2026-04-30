provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

resource "yandex_vpc_network" "caliman_network" {
  name = "caliman-network"
}

resource "yandex_vpc_subnet" "caliman_subnet" {
  name           = "caliman-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.caliman_network.id
  v4_cidr_blocks = ["10.10.0.0/24"]
}

resource "yandex_compute_instance" "caliman_vm" {
  name = "caliman-vm"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.caliman_subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}