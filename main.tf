# TFE Itself
module "tfe_cluster" {
  source  = "hashicorp/terraform-enterprise/azurerm"
  version = "0.1.1"

  license_file = var.license_path
  # 
  resource_group_name          = local.res_group
  virtual_network_name         = local.vnet_name
  subnet                       = local.subnet_name
  key_vault_name               = local.key_vault_name
  domain                       = local.dns_domain
 /*  tls_pfx_certificate          = var.certificate_path
  tls_pfx_certificate_password = var.certificate_pass */
}

# Locals are for convinience her
locals {
  rtags = {
    environment = var.env,
    usertag     = var.usertag
  }

  res_group   = azurerm_resource_group.ag_rs_group.name
  vnet_name   = azurerm_virtual_network.ag_network.name
  subnet_name = azurerm_subnet.ag_subnet.name
  key_vault_name = azurerm_key_vault.ag_key_vault.name
  dns_domain = var.dns_domain
}

# REQUREMENTS : GENERAL : Resource Group 
resource "azurerm_resource_group" "ag_rs_group" {
  name     = "${var.res_prefix}-rsg"
  location = var.location

  tags = local.rtags
}

# REQUREMENT : NETWORK : Virtual Network
resource "azurerm_virtual_network" "ag_network" {
  name                = "${var.res_prefix}-vnet"
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = local.res_group

  tags = local.rtags
}

# REQUREMENT : NETWORK : Subnet for TFE
resource "azurerm_subnet" "ag_subnet" {
  name                 = "${var.res_prefix}-subnet"
  resource_group_name  = local.res_group
  virtual_network_name = local.vnet_name
  address_prefix       = var.address_prefix
  # ????
  #tags                 = local.rtags 
}

# REQUREMENT : SECURITY : KeyVault
resource "azurerm_key_vault" "ag_key_vault" {
  name                        = "${var.res_prefix}-keyvault"
  location                    = var.location
  resource_group_name         = local.res_group
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id

  sku_name = "standard"
  tags     = local.rtags

  /* access_policy {
    tenant_id = "d6e396d0-5584-41dc-9fc0-268df99bc610"
    object_id = "d746815a-0433-4a21-b95d-fc437d2d475b"

    key_permissions = [
      "get",
    ]

    secret_permissions = [
      "get",
    ]

    storage_permissions = [
      "get",
    ]
  }

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  } */

}

# REQUREMENT : NETWORK :  DNS
resource "azurerm_dns_zone" "ag_dns" {
  name                = var.dns_domain
  resource_group_name = local.res_group
  zone_type           = "Public"
}

