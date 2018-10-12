resource "azurerm_public_ip" "AzurePubIP" {
  name                         = "${var.pubip_name}"
  location                     = "${var.rg_location}"
  resource_group_name          = "${var.rg_name}"
  public_ip_address_allocation = "${var.pubip_alloc}"
  domain_name_label            = "${random_string.fqdn.result}"

  tags {
    environment = "staging"
  }
}

resource "random_string" "fqdn" {
  length  = 6
  special = false
  upper   = false
  number  = false
}

resource "azurerm_lb" "AzureLB" {
  name                = "${var.loadbal_name}"
  location            = "${var.rg_location}"
  resource_group_name = "${var.rg_name}"

  frontend_ip_configuration {
    name                 = "${var.loadbal_fr_conf_name}"
    public_ip_address_id = "${azurerm_public_ip.AzurePubIP.id}"
  }
}

module "AzureLBRules" {
  source = "../lb_rules"

  loadbalancer_id         = "${azurerm_lb.AzureLB.id}"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.AzureBEPool.id}"
  rg_name                 = "${var.rg_name}"
  loadbal_fr_conf_name    = "${var.loadbal_fr_conf_name}"
}

resource "azurerm_lb_backend_address_pool" "AzureBEPool" {
  resource_group_name = "${var.rg_name}"
  loadbalancer_id     = "${azurerm_lb.AzureLB.id}"
  name                = "${var.lodbal_be_name}"
}

data "template_file" "cloud_config_template" {
  template = "${file(var.cloud_config_template)}"
}

data "template_file" "consul_service_config" {
  template = "${file(var.consul_service_config)}"

  vars {
    public_ip       = "${azurerm_public_ip.AzurePubIP.ip_address}"
    subscription_id = "${var.azure_info["subscription_id"]}"
    client_id       = "${var.azure_info["client_id"]}"
    client_secret   = "${var.azure_info["client_secret"]}"
    tenant_id       = "${var.azure_info["tenant_id"]}"
    rg_name         = "${var.rg_name}"
  }
}

data "template_file" "nomad_service_config" {
  template = "${file(var.nomad_service_config)}"
}

data "template_cloudinit_config" "cloud_config" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = "${data.template_file.cloud_config_template.rendered}"
  }

  part {
    content_type = "text/x-shellscript"
    content      = "${file("templates/basic.sh")}"
  }

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.consul_service_config.rendered}"
  }

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.nomad_service_config.rendered}"
  }
}

resource "azurerm_virtual_machine_scale_set" "AzureScaleSet" {
  name                = "${var.scaleset_name}"
  location            = "${var.rg_location}"
  resource_group_name = "${var.rg_name}"
  upgrade_policy_mode = "Manual"

  sku {
    name     = "${var.scaleset_sku_map["name"]}"
    tier     = "${var.scaleset_sku_map["tier"]}"
    capacity = "${var.scaleset_sku_map["capacity"]}"
  }

  storage_profile_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_profile_data_disk {
    lun           = 0
    caching       = "ReadWrite"
    create_option = "Empty"
    disk_size_gb  = 10
  }

  os_profile {
    computer_name_prefix = "${var.scaleset_server_prefix}"
    admin_username       = "${var.admin_user}"
    admin_password       = "${var.admin_password}"
    custom_data          = "${data.template_cloudinit_config.cloud_config.rendered}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.admin_user}/.ssh/authorized_keys"
      key_data = "${file(var.scaleset_ssh_key_data_path)}"
    }
  }

  network_profile {
    name    = "PrimaryNIC"
    primary = true

    ip_configuration {
      name                                   = "PrimaryNICConfig"
      primary                                = true
      subnet_id                              = "${var.subnet_id}"
      load_balancer_backend_address_pool_ids = ["${azurerm_lb_backend_address_pool.AzureBEPool.id}"]
    }
  }

  tags {
    role = "${var.scaleset_name}"
  }
}
