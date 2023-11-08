provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  service_account_key_file = var.service_account_key_file
  zone                     = var.zone
}

module "db" {
  source           = "../modules/db"
  public_key_path  = var.public_key_path
  db_disk_image    = var.db_disk_image
  subnet_id        = var.subnet_id
  env              = "stage"
  private_key_path = var.private_key_path

}

module "app" {
  source            = "../modules/app"
  public_key_path   = var.public_key_path
  app_disk_image    = var.app_disk_image
  subnet_id         = var.subnet_id
  env               = "stage"
  private_key_path  = var.private_key_path
  db_ip_address     = module.db.external_ip_address_db
  need_provisioning = var.need_provisioning
}
