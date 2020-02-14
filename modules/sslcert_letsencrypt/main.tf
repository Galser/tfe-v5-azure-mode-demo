resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = "andrii@${var.domain}"
}

resource "acme_certificate" "certificate" {
  account_key_pem          = acme_registration.reg.account_key_pem
  common_name              = "${var.host}.${var.domain}"
  certificate_p12_password = var.certificate_p12_password

  dns_challenge {
    provider = var.dns_provider
    config  = var.dns_challenge_config
  }
}

locals {
  cert_bundle = <<EOT
${acme_certificate.certificate.certificate_pem}

${acme_certificate.certificate.issuer_pem}
    EOT
}

# to make life easier when installing
resource "local_file" "ssl_private_key_file" {
  sensitive_content = acme_certificate.certificate.private_key_pem
  filename          = "./site_ssl_private_key.pem"
}

resource "local_file" "ssl_cert_file" {
  sensitive_content = acme_certificate.certificate.certificate_pem
  filename          = "./site_ssl_cert.pem"
}

resource "local_file" "ssl_cert_bundle_file" {
  sensitive_content = local.cert_bundle
  filename          = "./site_ssl_cert_bundle.pem"
}


/* resource "local_file" "ssl_pfx_cert_file" {
  sensitive_content = acme_certificate.certificate.certificate_p12
  filename          = var.pfx_cert_path
} */

resource "null_resource" "pfx_generate" {
  # Changes to key require regeneration 
  triggers = {
    cert_contents = acme_certificate.certificate.certificate_pem
  }
  
  provisioner "local-exec" {
    command = "openssl pkcs12 -export -inkey ./site_ssl_private_key.pem -in ./site_ssl_cert.pem -out ${var.pfx_cert_path} -password pass:${var.certificate_p12_password}"
  }
}