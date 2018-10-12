provider "azurerm" {
  subscription_id = "${var.azure_info["subscription_id"]}"
  client_id       = "${var.azure_info["client_id"]}"
  client_secret   = "${var.azure_info["client_secret"]}"
  tenant_id       = "${var.azure_info["tenant_id"]}"
}

resource "azurerm_resource_group" "AzureRG" {
  name     = "${var.rg_name}"
  location = "${var.rg_region}"
}

resource "azurerm_virtual_network" "AzureVNet" {
  name                = "${var.vnet_name}"
  address_space       = "${var.vnet_cidr}"
  location            = "${azurerm_resource_group.AzureRG.location}"
  resource_group_name = "${azurerm_resource_group.AzureRG.name}"
}

resource "azurerm_subnet" "AzureSubnet" {
  name                 = "${var.subnet_name}"
  resource_group_name  = "${azurerm_resource_group.AzureRG.name}"
  virtual_network_name = "${azurerm_virtual_network.AzureVNet.name}"
  address_prefix       = "${var.subnet_prefix}"
}

module "NomadServerTier" {
  source = "./scaleset_tier"

  loadbal_name               = "nomadserverloadbal"
  rg_location                = "${azurerm_resource_group.AzureRG.location}"
  rg_name                    = "${azurerm_resource_group.AzureRG.name}"
  loadbal_fr_conf_name       = "${var.loadbal_fr_conf_name}"
  scaleset_sku_map           = "${var.scaleset_nomad_server_sku}"
  lodbal_be_name             = "nomadserverbepool"
  cloud_config_template      = "templates/cloud_config.tpl"
  scaleset_name              = "nomadserver"
  scaleset_server_prefix     = "nomadserver"
  admin_user                 = "${var.admin_user}"
  admin_password             = "${var.admin_password}"
  scaleset_ssh_key_data_path = "${var.scaleset_ssh_key_data_path}"
  subnet_id                  = "${azurerm_subnet.AzureSubnet.id}"
  pubip_name                 = "nomadserverpubip"
  consul_service_config      = "templates/consul_client.sh"
  azure_info                 = "${var.azure_info}"
  consul_pubip               = "${module.ConsulTier.public_ip}"
  nomad_service_config       = "templates/nomad_server.sh"
}

module "NomadClientTier" {
  source = "./scaleset_tier"

  loadbal_name               = "nomadclientloadbal"
  rg_location                = "${azurerm_resource_group.AzureRG.location}"
  rg_name                    = "${azurerm_resource_group.AzureRG.name}"
  loadbal_fr_conf_name       = "${var.loadbal_fr_conf_name}"
  scaleset_sku_map           = "${var.scaleset_nomad_client_sku}"
  lodbal_be_name             = "nomadclientbepool"
  cloud_config_template      = "templates/cloud_config.tpl"
  scaleset_name              = "nomadclient"
  scaleset_server_prefix     = "nomadclient"
  admin_user                 = "${var.admin_user}"
  admin_password             = "${var.admin_password}"
  scaleset_ssh_key_data_path = "${var.scaleset_ssh_key_data_path}"
  subnet_id                  = "${azurerm_subnet.AzureSubnet.id}"
  pubip_name                 = "nomadclientpubip"
  consul_service_config      = "templates/consul_client.sh"
  azure_info                 = "${var.azure_info}"
  consul_pubip               = "${module.ConsulTier.public_ip}"
  nomad_service_config       = "templates/nomad_client.sh"
}

module "ConsulTier" {
  source = "./scaleset_tier"

  loadbal_name               = "consulserverloadbal"
  rg_location                = "${azurerm_resource_group.AzureRG.location}"
  rg_name                    = "${azurerm_resource_group.AzureRG.name}"
  loadbal_fr_conf_name       = "${var.loadbal_fr_conf_name}"
  scaleset_sku_map           = "${var.scaleset_consul_sku}"
  lodbal_be_name             = "consulserverbepool"
  cloud_config_template      = "templates/cloud_config.tpl"
  scaleset_name              = "consulserver"
  scaleset_server_prefix     = "consulserver"
  admin_user                 = "${var.admin_user}"
  admin_password             = "${var.admin_password}"
  scaleset_ssh_key_data_path = "${var.scaleset_ssh_key_data_path}"
  subnet_id                  = "${azurerm_subnet.AzureSubnet.id}"
  pubip_name                 = "consulserverpubip"
  consul_service_config      = "templates/consul_server.sh"
  azure_info                 = "${var.azure_info}"
  consul_pubip               = ""
  nomad_service_config       = "templates/nomad_server.sh"
}
