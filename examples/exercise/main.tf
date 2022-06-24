# Configure the DNS Provider
locals {
  dns_config  = yamldecode(file("./dns.yaml"))
  dns_entries = local.dns_config.bind

}

terraform {
  # This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
  # This module is now only being tested with Terraform 0.13.x. However, to make upgrading easier, we are setting
  # 0.12.26 as the minimum version, as that version added support for required_providers with source URLs, making it
  # forwards compatible with 0.13.x code.
  required_version = ">= 0.13.5"
  required_providers {
    dns = {
      source  = "hashicorp/dns"
      version = ">= 3.2.0"
    }
  }
}

provider "dns" {
  update {
    server   = var.dns_server
    retries  = 100
  }
}

module "dns_updater" {

  source = "./module"
  dns_configuration   = local.dns_entries
  cname_configuration = local.dns_config.cname
  create_cnames       = true
  
 
# ----------------------------------------
# Write your Terraform module inputs here
# ----------------------------------------


}
