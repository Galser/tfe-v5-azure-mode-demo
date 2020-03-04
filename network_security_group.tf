resource "azurerm_network_security_group" "tfe-new" {
  name                = "${var.res_prefix}-nsg"
  resource_group_name = local.res_group
  location            = var.location
  tags                = local.rtags
}

resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = "${var.res_prefix}-ssh"
  resource_group_name         = local.res_group
  network_security_group_name = azurerm_network_security_group.tfe-new.name
  description                 = "Allow ssh access for debugging."
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = var.address_space_allowlist
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_range      = "22"
  priority                    = 100
}

resource "azurerm_network_security_rule" "allow_http" {
  name                        = "${var.res_prefix}-http"
  resource_group_name         = local.res_group
  network_security_group_name = azurerm_network_security_group.tfe-new.name
  description                 = "Allow http traffic for health checks."
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = var.address_space_allowlist
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_range      = "80"
  priority                    = 110
}

resource "azurerm_network_security_rule" "allow_https" {
  name                        = "${var.res_prefix}-https"
  resource_group_name         = local.res_group
  network_security_group_name = azurerm_network_security_group.tfe-new.name
  description                 = "Allow https traffic"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = var.address_space_allowlist
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_range      = "443"
  priority                    = 120
}

resource "azurerm_network_security_rule" "allow_installer_dashboard" {
  name                        = "${var.res_prefix}-dash"
  resource_group_name         = local.res_group
  network_security_group_name = azurerm_network_security_group.tfe-new.name
  description                 = "Allow access to the installer dashboard."
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = var.address_space_allowlist
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_range      = "8800"
  priority                    = 130
}

resource "azurerm_network_security_rule" "allow_cluster" {
  name                        = "${var.res_prefix}-cluster"
  resource_group_name         = local.res_group
  network_security_group_name = azurerm_network_security_group.tfe-new.name
  description                 = "Allow cluster traffic to the load balancer"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = var.address_space_allowlist
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_range      = "6443"
  priority                    = 140
}

resource "azurerm_network_security_rule" "allow_assistant" {
  name                        = "${var.res_prefix}-assist"
  resource_group_name         = local.res_group
  network_security_group_name = azurerm_network_security_group.tfe-new.name
  description                 = "Allow traffic to the assistant application"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = var.address_space_allowlist
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_range      = "23010"
  priority                    = 150
}

resource "azurerm_subnet_network_security_group_association" "test" {
  subnet_id                 = azurerm_subnet.ag_subnet.id
  network_security_group_id = azurerm_network_security_group.tfe-new.id
}