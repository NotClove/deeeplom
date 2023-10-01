### K8S-sa
resource "yandex_iam_service_account" "k8s_robot" {
  name        = "prod-k8s-robot"
  folder_id = "${yandex_resourcemanager_folder.new_folder.id}"
  description = "K8S regional service account for stage"
}

resource "yandex_resourcemanager_folder_iam_binding" "k8s_clusters_agent" {
  folder_id = "${yandex_resourcemanager_folder.new_folder.id}"
  role      = "k8s.clusters.agent"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s_robot.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "vpc_public_admin" {
  folder_id = "${yandex_resourcemanager_folder.new_folder.id}"
  role      = "vpc.publicAdmin"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s_robot.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "vpc_private_admin" {
  folder_id = "${yandex_resourcemanager_folder.new_folder.id}"
  role      = "load-balancer.admin"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s_robot.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "images_puller" {
  folder_id = "${yandex_resourcemanager_folder.new_folder.id}"
  role      = "container-registry.images.puller"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s_robot.id}"
  ]
}

resource "yandex_kms_symmetric_key_iam_binding" "viewer" {
  symmetric_key_id = yandex_kms_symmetric_key.kms_key.id
  role             = "viewer"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s_robot.id}",
  ]
}
