# parameters for the sslcert_letsencrypt module
variable "domain" {
  description = "The DOMAIN part of the record"
}

variable "host" {
  description = "The HOST part of the record"
}

variable "dns_provider" {
  description = "Short name of the DSN provider for our site"
  # "godaddy", "cloudflare" , etc...
}

variable "certificate_p12_password" {
  description = "(Optional) Password to be used when generating the PFX file stored in certificate_p12. Defaults to an empty string."
  default     = ""
}

variable "pfx_cert_path" {
  default = "./site_ssl_cert.pfx"
}

variable "dns_challenge_config" {
  default  = {}
}