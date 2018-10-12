variable "admin_user" {
  type = "string"
}

variable "admin_password" {
  type = "string"
}

variable "rg_name" {
  type    = "string"
  default = "HashiExample"
}

variable "rg_region" {
  type    = "string"
  default = "East US"
}

variable "vnet_name" {
  type    = "string"
  default = "acctvnet"
}

variable "vnet_cidr" {
  type    = "list"
  default = ["10.0.0.0/16"]
}

variable "subnet_name" {
  type    = "string"
  default = "acctsubnet"
}

variable "subnet_prefix" {
  type    = "string"
  default = "10.0.2.0/24"
}

variable "loadbal_fr_conf_name" {
  type    = "string"
  default = "PublicIPAddress"
}

variable "scaleset_nomad_server_sku" {
  type = "map"

  default = {
    name     = "Standard_B1ms"
    tier     = "Standard"
    capacity = 1
  }
}

variable "scaleset_nomad_client_sku" {
  type = "map"

  default = {
    name     = "Standard_B1ms"
    tier     = "Standard"
    capacity = 1
  }
}

variable "scaleset_consul_sku" {
  type = "map"

  default = {
    name     = "Standard_B1ms"
    tier     = "Standard"
    capacity = 1
  }
}

variable "scaleset_ssh_key_data_path" {
  type    = "string"
  default = "~/.ssh/azure.pub"
}
