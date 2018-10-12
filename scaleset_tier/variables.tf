variable "loadbal_name" {
  type = "string"
}

variable "rg_location" {
  type = "string"
}

variable "rg_name" {
  type = "string"
}

variable "loadbal_fr_conf_name" {
  type = "string"
}

variable "pubip_name" {
  type = "string"
}

variable "pubip_alloc" {
  type    = "string"
  default = "static"
}

variable "scaleset_sku_map" {
  type = "map"
}

variable "lodbal_be_name" {
  type = "string"
}

variable "cloud_config_template" {
  type = "string"
}

variable "scaleset_name" {
  type = "string"
}

variable "scaleset_server_prefix" {
  type = "string"
}

variable "admin_user" {
  type = "string"
}

variable "admin_password" {
  type = "string"
}

variable "scaleset_ssh_key_data_path" {
  type = "string"
}

variable "subnet_id" {
  type = "string"
}

variable "consul_service_config" {
  type = "string"
}

variable "azure_info" {
  type = "map"
}

variable "consul_pubip" {
  type = "string"
}

variable "nomad_service_config" {
  type = "string"
}
