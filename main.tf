# DATA 
data "azurerm_client_config" "current" {

}

# TFE Itself
module "tfe_cluster" {
  # source  = "hashicorp/terraform-enterprise/azurerm"
  source = "./modules/tfe_cluster"
  #  version = "0.1.1"

  license_file = var.license_path
  # 
  resource_group_name  = local.res_group
  virtual_network_name = local.vnet_name
  subnet               = local.subnet_name
  key_vault_name       = local.key_vault_name
  domain               = local.dns_domain
  hostname             = local.dns_host

  #	tls_pfx_certificate          = "try_cert.pfx"
  #	tls_pfx_certificate_password = ""
  tls_pfx_certificate          = local.pfx_cert_path
  tls_pfx_certificate_password = local.certificate_password

}


# Locals are for convinience her
locals {
  rtags = {
    environment = var.env,
    usertag     = var.usertag
  }

  res_group            = azurerm_resource_group.ag_rs_group.name
  vnet_name            = azurerm_virtual_network.ag_network.name
  subnet_name          = azurerm_subnet.ag_subnet.name
  key_vault_name       = azurerm_key_vault.ag_key_vault.name
  dns_domain           = var.dns_domain
  dns_host             = "${var.res_prefix}-main"
  pfx_cert_path        = module.sslcert_letsencrypt.pfx_cert_path
  certificate_password = module.sslcert_letsencrypt.pfc_cert_password
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
  service_endpoints = [
    "Microsoft.KeyVault",
  ]  
}

# REQUREMENT : SECURITY : KeyVault
resource "azurerm_key_vault" "ag_key_vault" {
  name                        = "${var.res_prefix}-keyvault"
  location                    = var.location
  resource_group_name         = local.res_group
  enabled_for_disk_encryption = true
  #tenant_id                   = var.tenant_id
  tenant_id = "${data.azurerm_client_config.current.tenant_id}"

  sku_name = "standard"

  # not set by default, not menitoned in docs
  enabled_for_deployment = true

  access_policy {
    tenant_id = "${data.azurerm_client_config.current.tenant_id}"
    object_id = "${data.azurerm_client_config.current.object_id}"

    certificate_permissions = [
      "create",
      "delete",
      "deleteissuers",
      "get",
      "getissuers",
      "import",
      "list",
      "listissuers",
      "managecontacts",
      "manageissuers",
      "setissuers",
      "update",
    ]

    key_permissions = [
      "backup",
      "create",
      "decrypt",
      "delete",
      "encrypt",
      "get",
      "import",
      "list",
      "purge",
      "recover",
      "restore",
      "sign",
      "unwrapKey",
      "update",
      "verify",
      "wrapKey",
    ]

    secret_permissions = [
      "backup",
      "delete",
      "get",
      "list",
      "purge",
      "recover",
      "restore",
      "set",
    ]
  }

  /*
  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  } */
  tags = local.rtags
}

# REQUREMENT : NETWORK : DNS
resource "azurerm_dns_zone" "ag_dns" {
  name                = var.dns_domain
  resource_group_name = local.res_group
  zone_type           = "Public"
}

# Network : DNS CloudFlare
module "dns_cloudflare" {
  source = "./modules/dns_cloudflare"

  host         = local.dns_host
  domain       = var.dns_domain
  cname_target = "ct-${local.dns_host}.${var.dns_domain}"
  record_ip    = module.tfe_cluster.lb_public_ip_address
  #record_ip    = "192.168.1.35"
}


# REQUREMENT : Certificate : SSL from Let'sEncrypt
module "sslcert_letsencrypt" {

  source = "./modules/sslcert_letsencrypt"

  host                     = local.dns_host
  domain                   = var.dns_domain
  dns_provider             = "cloudflare"
  certificate_p12_password = ""
  dns_challenge_config = {
    /*    AZURE_CLIENT_ID = data.azurerm_client_config.current.client_id
    AZURE_RESOURCE_GROUP = local.res_group
    AZURE_TENANT_ID = data.azurerm_client_config.current.tenant_id
    AZURE_SUBSCRIPTION_ID = data.azurerm_client_config.current.subscription_id */
  }
}

