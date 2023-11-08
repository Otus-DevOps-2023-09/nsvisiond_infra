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

variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}

variable "private_key_path" {
  description = "Path to the public key used for ssh access"
}

variable "image_id" {
  description = "Disk image"
}

variable "subnet_id" {
  type        = string
  description = "Subnet"
}

variable "network_id" {
  type        = string
  description = "network_id"
}

variable "region_id" {
  type        = string
  default     = "ru-central1"
  description = "region_id"
}

variable "service_account_key_file" {
  type        = string
  description = "Path to YC service account key"
}

variable "app_instances_count" {
  type        = number
  description = "app_instances_count"
  default     = 1
}

variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable "db_disk_image" {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}

variable "need_provisioning" {
  type        = bool
  description = "need_provisioning"
  default     = true
}
