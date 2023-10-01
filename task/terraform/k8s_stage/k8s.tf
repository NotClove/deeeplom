resource "yandex_kubernetes_cluster" "k8s_regional_cluster" {
  name               = local.cluster_name
  folder_id = "${yandex_resourcemanager_folder.new_folder.id}"
  network_id         = yandex_vpc_network.net.id
  cluster_ipv4_range = var.CLUSTER_IPV4_RANGE
  service_ipv4_range = var.SERVICE_IPV4_RANGE 
  release_channel    = "STABLE"
  master {
    version         = var.K8S_VERSION
    public_ip       = true
    regional {
      region = "ru-central1"
      
      dynamic "location" {
        for_each = yandex_vpc_subnet.public
        content {
          zone = yandex_vpc_subnet.public["${location.key}"].zone
          subnet_id = yandex_vpc_subnet.public["${location.key}"].id
        }
      }
    }
  }
  service_account_id      = yandex_iam_service_account.k8s_robot.id
  node_service_account_id = yandex_iam_service_account.k8s_robot.id
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms_key.id
  }

  depends_on = [
    yandex_vpc_network.net,
    yandex_vpc_subnet.public,
    yandex_resourcemanager_folder_iam_binding.k8s_clusters_agent,
    yandex_resourcemanager_folder_iam_binding.vpc_public_admin,
    yandex_resourcemanager_folder_iam_binding.images_puller
  ]
}


resource "yandex_kubernetes_node_group" "regional_node_group" {
  cluster_id  = yandex_kubernetes_cluster.k8s_regional_cluster.id
  name        = "stage-regional-node-group"
  version     = var.K8S_VERSION

  instance_template {

    platform_id = local.k8s_cluster_resources.stage.workers.platform_id

    resources {
      memory        = local.k8s_cluster_resources.stage.workers.memory
      cores         = local.k8s_cluster_resources.stage.workers.cpu
      core_fraction = local.k8s_cluster_resources.stage.workers.core_fraction
    }

    boot_disk {
      type = local.k8s_cluster_resources.stage.workers.disk_type
      size = local.k8s_cluster_resources.stage.workers.disk_size
    }

    container_runtime {
     type = "containerd"
    }

    network_interface {
      nat        = true
      subnet_ids = [ for subnet in yandex_vpc_subnet.public : subnet.id ]
    }

    metadata = {
      ssh-keys           = join("\n", [for user, key in var.SSH_KEYS : "${user}:${key}"])
      serial-port-enable = local.k8s_cluster_resources.stage.workers.serial-port-enable
    }
  }

  allocation_policy {

    dynamic "location" {
      for_each = yandex_vpc_subnet.public
      content {
        zone   = yandex_vpc_subnet.public["${location.key}"].zone
      }
    }
  } 

  scale_policy {
    fixed_scale {
      size = local.k8s_cluster_resources.stage.workers.scale
    }
  }

  depends_on = [
    yandex_kubernetes_cluster.k8s_regional_cluster
  ]
}
