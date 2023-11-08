resource "yandex_compute_instance" "app" {
  name = "reddit-app-${var.env}"

  labels = {
    tags = "reddit-app-${var.env}"
  }
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  allow_stopping_for_update = true

}

resource "null_resource" "app" {
  count = (var.need_provisioning) ? 1 : 0

  triggers = {
    app_id = yandex_compute_instance.app.id
  }

  connection {
    type        = "ssh"
    host        = yandex_compute_instance.app.network_interface.0.nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
  }


  provisioner "remote-exec" {
    inline = [
      "echo \"DATABASE_URL=${var.db_ip_address}\" | sudo tee /etc/puma.conf"
    ]
  }

  provisioner "file" {
    source      = "${path.module}/files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }
}
