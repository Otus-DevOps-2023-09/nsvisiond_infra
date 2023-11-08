resource "yandex_vpc_network" "app-network" {
  name = "reddit-app-network-${var.env}"
}

resource "yandex_vpc_subnet" "app-subnet" {
  name           = "reddit-app-${var.env}-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.app-network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}
