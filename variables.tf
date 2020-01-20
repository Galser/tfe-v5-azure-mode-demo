# used later to delete all those instances
variable "usertag" {
  type    = string
  default = "ag-2020-ticket-test"
}

variable "location" {
  default = "eastus"
}

variable "env" {
  default = "Terrafrom V5 Demo"
}

variable "license_path" {
  description = "Path to the RLI lisence file for Terraform Enterprise."
  default     = "~/Licenses/tfe/andrii-hashicorp-emea.rli"
}

variable "res_prefix" {
  description = "Name of the Resource Group for TFE"
  default     = "tfev5-md"
}

variable "vnet_address_space" {
  description = "Virtual network address space"
  default     = ["10.0.0.0/16"]
}

variable "address_prefix" {
  description = "Subnetwork address prefix"
  default     = "10.0.1.0/24"
}

variable "tenant_id" {
  description = "Tenant ID for KeyVault auth"
  default     = "0e3e2e88-8caf-41ca-b4da-e3b33b6c52ec"
}

variable "dns_domain" {
  description = "Azure hosted DNS domain"
  default = "azure.guselietov.com"
}

/* variable "resource_group" {
  description = "Azure resource group the vnet, key vault, and dns domain exist in."
  default = ""
}

variable "vnet_name" {
  description = "Azure virtual network name to deploy in."
  default = ""
}

variable "subnet_name" {
  description = "Azure subnet within the virtual network to deploy in."
  default = ""
}

variable "dns_domain" {
  description = "Azure hosted DNS domain"
  default = ""
}

variable "key_vault_name" {
  description = "Azure hosted Key Vault resource."
  default = ""
}

variable "certificate_path" {
  description = "Path to a TLS wildcard certificate for the domain in PKCS12 format."
  default = ""
}

variable "certificate_pass" {
  description = "The Password for the PKCS12 Certificate."
  default = ""
}
 */
