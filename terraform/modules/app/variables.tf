variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}

variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable "subnet_id" {
  description = "Subnets for modules"
}

variable "env" {
  type = string
  description = "Environment"
}

variable "db_ip_address" {
  type = string
  description = "db_ip_address"
}

variable "private_key_path" {
  description = "Path to the public key used for ssh access"
}

variable "need_provisioning" {
  type = bool
  description = "need_provisioning"
  default = true
}
