variable "cloud_id" {
  description = "Cloud"
}

variable "folder_id" {
  description = "Folder"
}

variable "zone" {
  description = "Zone"
  default     = "ru-central1-a"
}

variable "service_account_key_file" {
  type        = string
  description = "Path to YC service account key"
}

variable "service_account_id" {
  type        = string
  description = "service_account_id"
}

variable "iam_token" {
  type        = string
  description = "iam_token"
}
