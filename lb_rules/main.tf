resource "azurerm_lb_rule" "ssh" {
  resource_group_name            = "${var.rg_name}"
  loadbalancer_id                = "${var.loadbalancer_id}"
  name                           = "SSH"
  protocol                       = "Tcp"
  frontend_port                  = 50000
  backend_port                   = 22
  frontend_ip_configuration_name = "${var.loadbal_fr_conf_name}"
  backend_address_pool_id        = "${var.backend_address_pool_id}"
  probe_id                       = "${azurerm_lb_probe.ssh.id}"
}

resource "azurerm_lb_probe" "ssh" {
  resource_group_name = "${var.rg_name}"
  loadbalancer_id     = "${var.loadbalancer_id}"
  name                = "ssh-running-probe"
  port                = 22
}

resource "azurerm_lb_rule" "8300" {
  resource_group_name            = "${var.rg_name}"
  loadbalancer_id                = "${var.loadbalancer_id}"
  name                           = "8300"
  protocol                       = "Tcp"
  frontend_port                  = 8300
  backend_port                   = 8300
  frontend_ip_configuration_name = "${var.loadbal_fr_conf_name}"
  backend_address_pool_id        = "${var.backend_address_pool_id}"
  probe_id                       = "${azurerm_lb_probe.8300.id}"
}

resource "azurerm_lb_probe" "8300" {
  resource_group_name = "${var.rg_name}"
  loadbalancer_id     = "${var.loadbalancer_id}"
  name                = "8300-running-probe"
  port                = 8300
}

resource "azurerm_lb_rule" "8301" {
  resource_group_name            = "${var.rg_name}"
  loadbalancer_id                = "${var.loadbalancer_id}"
  name                           = "8301"
  protocol                       = "Tcp"
  frontend_port                  = 8301
  backend_port                   = 8301
  frontend_ip_configuration_name = "${var.loadbal_fr_conf_name}"
  backend_address_pool_id        = "${var.backend_address_pool_id}"
  probe_id                       = "${azurerm_lb_probe.8301.id}"
}

resource "azurerm_lb_probe" "8301" {
  resource_group_name = "${var.rg_name}"
  loadbalancer_id     = "${var.loadbalancer_id}"
  name                = "8301-running-probe"
  port                = 8301
}

resource "azurerm_lb_rule" "8400" {
  resource_group_name            = "${var.rg_name}"
  loadbalancer_id                = "${var.loadbalancer_id}"
  name                           = "8400"
  protocol                       = "Tcp"
  frontend_port                  = 8400
  backend_port                   = 8400
  frontend_ip_configuration_name = "${var.loadbal_fr_conf_name}"
  backend_address_pool_id        = "${var.backend_address_pool_id}"
  probe_id                       = "${azurerm_lb_probe.8400.id}"
}

resource "azurerm_lb_probe" "8400" {
  resource_group_name = "${var.rg_name}"
  loadbalancer_id     = "${var.loadbalancer_id}"
  name                = "8400-running-probe"
  port                = 8400
}

resource "azurerm_lb_rule" "8500" {
  resource_group_name            = "${var.rg_name}"
  loadbalancer_id                = "${var.loadbalancer_id}"
  name                           = "8500"
  protocol                       = "Tcp"
  frontend_port                  = 8500
  backend_port                   = 8500
  frontend_ip_configuration_name = "${var.loadbal_fr_conf_name}"
  backend_address_pool_id        = "${var.backend_address_pool_id}"
  probe_id                       = "${azurerm_lb_probe.8500.id}"
}

resource "azurerm_lb_probe" "8500" {
  resource_group_name = "${var.rg_name}"
  loadbalancer_id     = "${var.loadbalancer_id}"
  name                = "8500-running-probe"
  port                = 8500
}

resource "azurerm_lb_rule" "8600" {
  resource_group_name            = "${var.rg_name}"
  loadbalancer_id                = "${var.loadbalancer_id}"
  name                           = "8600"
  protocol                       = "Tcp"
  frontend_port                  = 8600
  backend_port                   = 8600
  frontend_ip_configuration_name = "${var.loadbal_fr_conf_name}"
  backend_address_pool_id        = "${var.backend_address_pool_id}"
  probe_id                       = "${azurerm_lb_probe.8600.id}"
}

resource "azurerm_lb_probe" "8600" {
  resource_group_name = "${var.rg_name}"
  loadbalancer_id     = "${var.loadbalancer_id}"
  name                = "8600-running-probe"
  port                = 8600
}

resource "azurerm_lb_rule" "4646" {
  resource_group_name            = "${var.rg_name}"
  loadbalancer_id                = "${var.loadbalancer_id}"
  name                           = "4646"
  protocol                       = "Tcp"
  frontend_port                  = 4646
  backend_port                   = 4646
  frontend_ip_configuration_name = "${var.loadbal_fr_conf_name}"
  backend_address_pool_id        = "${var.backend_address_pool_id}"
  probe_id                       = "${azurerm_lb_probe.4646.id}"
}

resource "azurerm_lb_probe" "4646" {
  resource_group_name = "${var.rg_name}"
  loadbalancer_id     = "${var.loadbalancer_id}"
  name                = "4646-running-probe"
  port                = 4646
}

resource "azurerm_lb_rule" "4647" {
  resource_group_name            = "${var.rg_name}"
  loadbalancer_id                = "${var.loadbalancer_id}"
  name                           = "4647"
  protocol                       = "Tcp"
  frontend_port                  = 4647
  backend_port                   = 4647
  frontend_ip_configuration_name = "${var.loadbal_fr_conf_name}"
  backend_address_pool_id        = "${var.backend_address_pool_id}"
  probe_id                       = "${azurerm_lb_probe.4647.id}"
}

resource "azurerm_lb_probe" "4647" {
  resource_group_name = "${var.rg_name}"
  loadbalancer_id     = "${var.loadbalancer_id}"
  name                = "4647-running-probe"
  port                = 4647
}
