resource "yandex_lb_target_group" "reddit-target-group" {
  name      = "reddit-target-group"
  folder_id = var.folder_id
  region_id = var.region_id

  dynamic "target" {
    for_each = yandex_compute_instance.app.*.network_interface.0.ip_address
    content {
      address   = target.value
      subnet_id = var.subnet_id
    }
  }


}

resource "yandex_lb_network_load_balancer" "reddit-balancer" {
  name                = "reddit-balancer"
  listener {
    name        = "reddit-balancer-listener"
    port        = 80
    target_port = 9292
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.reddit-target-group.id
    healthcheck {
      name = "reddit-healthcheck"
      http_options {
        port = 9292
        path = "/"
      }
    }
  }
}
