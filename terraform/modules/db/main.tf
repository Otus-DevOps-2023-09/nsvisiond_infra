resource "yandex_compute_instance" "db" {
  name = "reddit-db-${var.env}"
  labels = {
    tags = "reddit-db-${var.env}"
  }

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.db_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  connection {
    type        = "ssh"
    host        = self.network_interface.0.nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  allow_stopping_for_update = true
}

resource "null_resource" "db" {
  count = (var.need_provisioning) ? 1 : 0

  triggers = {
    app_id = yandex_compute_instance.db.id
  }
  provisioner "remote-exec" {
    inline = [
      "sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongodb.conf",
      "sudo systemctl restart mongodb"
    ]
  }
}
