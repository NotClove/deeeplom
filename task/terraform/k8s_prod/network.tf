resource "yandex_vpc_network" "net" {
  name = "prod-net"
  folder_id = "${yandex_resourcemanager_folder.new_folder.id}"
}

resource "yandex_vpc_subnet" "public" {
  count          = length(local.networks)
  folder_id = "${yandex_resourcemanager_folder.new_folder.id}"
  v4_cidr_blocks = local.networks[count.index].subnet
  zone           = local.networks[count.index].zone_name
  network_id     = yandex_vpc_network.net.id
  name           = "prod-${local.networks[count.index].zone_name}"
}
