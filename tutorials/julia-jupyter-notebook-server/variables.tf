variable "acme_registration_email" {}
variable "managed_zone" {}
variable "project" {}
variable "servername" {}

variable "acme_server_url" {
  default = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

variable "disk_size" {
  default = "16"
} 

variable "jupyter_server_port" {
  default = "8089"
}

variable "machine_type" {
  default = "n1-standard-2"
}

variable "network" {
  default = "default"
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-b"
}

