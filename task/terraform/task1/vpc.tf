## vpc-stage

resource "yandex_compute_instance" "vpc" {
  count = var.vpc_count
  folder_id = "${yandex_resourcemanager_folder.folder1.id}"
  name = "${var.vpc}-${count.index+1}"
  zone = var.yc_region_a
  hostname = "${var.vpc}-${count.index+1}.ru-central1.internal"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8cqj9qiedndmmi3vq6"
      size = "10"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.stage-subnet-a.id}"
    nat = true
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

output "vpc_ips" {
  value = yandex_compute_instance.vpc[*].network_interface.0.nat_ip_address
}

output "vpc_int_ips" {
  value = yandex_compute_instance.vpc[*].network_interface.0.ip_address
}