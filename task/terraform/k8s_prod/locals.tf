resource "yandex_resourcemanager_folder" "new_folder" {
  cloud_id    = var.YANDEX_CLOUD_ID
  name        = "deeeplom-prod"
  description = "Deeeplom work"
}

locals {
  default_zone    = "local.networks.0.zone_name"
  folder_id = "${yandex_resourcemanager_folder.new_folder.id}"
  cluster_name    = "prod-k8s-regional-cluster"

  ingress_values = {
    fullnameOverride = "ingress-nginx"
  }

  networks = [
    {
      zone_name = "ru-central1-a"
      subnet    = ["10.0.10.0/24"]
    },
    {
      zone_name = "ru-central1-b"
      subnet    = ["10.0.11.0/24"]
    },
    {
      zone_name = "ru-central1-c"
      subnet    = ["10.0.12.0/24"]
    }
  ]

  k8s_cluster_resources = {
      prod = {
      workers = {
        scale              = 3
        cpu                = 2
        core_fraction      = 20
        memory             = 5
        disk_size          = 64
        disk_type          = "network-ssd"
        platform_id        = "standard-v1"
        serial-port-enable = 1
      }
    }
  }
}
