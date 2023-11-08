provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  service_account_key_file = var.service_account_key_file
  zone                     = var.zone
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = var.service_account_id
  description        = "Terraform S3 state backend key"
}

resource "yandex_ydb_database_serverless" "ydb-serverless-for-backend-lock" {
  name = "reddit-app-ydb-serverless-for-backend"

  serverless_database {
    enable_throttling_rcu_limit = false
    provisioned_rcu_limit       = 10
    storage_size_limit          = 1
    throttling_rcu_limit        = 0
  }
}

resource "terraform_data" "create_lock_table_for_stage" {
  provisioner "local-exec" {
    command    = "curl -H 'X-Amz-Target: DynamoDB_20120810.CreateTable' -H \"Authorization: Bearer ${var.iam_token}\" -H \"Content-Type: application.json\" -d @files/stage/create_lock_table.json ${yandex_ydb_database_serverless.ydb-serverless-for-backend-lock.document_api_endpoint}"
    on_failure = continue
  }
}

resource "terraform_data" "create_lock_table_for_prod" {
  provisioner "local-exec" {
    command    = "curl -H 'X-Amz-Target: DynamoDB_20120810.CreateTable' -H \"Authorization: Bearer ${var.iam_token}\" -H \"Content-Type: application.json\" -d @files/prod/create_lock_table.json ${yandex_ydb_database_serverless.ydb-serverless-for-backend-lock.document_api_endpoint}"
    on_failure = continue
  }
}

resource "local_file" "stage_backend_tfvars" {
  content = templatefile("files/backend.tfvars.tpl", {
    access_key       = yandex_iam_service_account_static_access_key.sa-static-key.access_key,
    secret_key       = yandex_iam_service_account_static_access_key.sa-static-key.secret_key,
    ydb_api_endpoint = yandex_ydb_database_serverless.ydb-serverless-for-backend-lock.document_api_endpoint,
    ydb_table        = "stage/lock"
  })
  filename = "../stage/backend.tfvars"

  provisioner "local-exec" {
    when       = destroy
    command    = "rm ../stage/backend.tfvars"
    on_failure = continue
  }
}

resource "local_file" "prod_backend_tfvars" {
  content = templatefile("files/backend.tfvars.tpl", {
    access_key       = yandex_iam_service_account_static_access_key.sa-static-key.access_key,
    secret_key       = yandex_iam_service_account_static_access_key.sa-static-key.secret_key,
    ydb_api_endpoint = yandex_ydb_database_serverless.ydb-serverless-for-backend-lock.document_api_endpoint,
    ydb_table        = "prod/lock"
  })
  filename = "../prod/backend.tfvars"

  provisioner "local-exec" {
    when       = destroy
    command    = "rm ../prod/backend.tfvars"
    on_failure = continue
  }
}

resource "yandex_storage_bucket" "reddit-app-backend" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "reddit-app-backend"
  max_size   = 10485760
}
