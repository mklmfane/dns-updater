/**
* # Terraform
*
* <Short TF module description>
*
*
* ## Usage
*
* ### Quick Example
*
* ```hcl
* module "dns_" {
*   source = ""
*   input1 = <>
*   input2 = <>
* } 
* ```
*
*/
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ---------------------------------------------------------------------------------------------------------------------
# SET TERRAFORM RUNTIME REQUIREMENTS
# ---------------------------------------------------------------------------------------------------------------------

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
  
    local = {
      source = "hashicorp/local"
      version = "2.2.3"
    }
  }
}




# ------------------------------------------
# Write your local resources here
# ------------------------------------------

locals {
  names          = fileset("${path.module}/examples/exercise/input-json","*.json")
  #names          = fileset("./examples/exercise/input-json","*.json")
  filename       = [ for i in local.names : 
    {
      content    = jsondecode(file("${path.module}/examples/exercise/input-json/${i}"))
      #content    = jsondecode(file("./examples/exercise/input-json/${i}"))
    }
  ]   
  jsonfile       = [ for i in local.names : jsondecode(file("${path.module}/examples/exercise/input-json/${i}")) ] 
  #jsonfile       = [ for i in local.names : jsondecode(file("./examples/exercise/input-json/${i}")) ]   
}


# ------------------------------------------
# Write your Terraform resources here
# ------------------------------------------


#resource "dns_a_record_set" "www" {
#  zone = "example.com."
#  name = "www"
#  addresses = [
#    "192.168.0.1",
#    "192.168.0.2",
#    "192.168.0.3",
#  ]
#  ttl = 300
#}


module "dns_updater" {

  source = "./examples/exercise/module"
  dns_configuration   = local.dns_entries
  cname_configuration = local.dns_config.cname
  create_cnames       = true
}


# Configure the DNS Provider
locals {
  dns_config  = yamldecode(file("./examples/exercise/dns.yaml"))
  dns_entries = local.dns_config.bind

}

resource "dns_a_record_set" "example" {
  zone      = local.filename[length(local.filename)-1].content.zone
  name      = local.filename[length(local.filename)-1].content.dns_record_type
  addresses = local.filename[length(local.filename)-1].content.addresses
  ttl       = local.filename[length(local.filename)-1].content.ttl
}


resource "local_file" "newfile" {
    content         = <<EOF
      "toset(local.jsonfile)"
    EOF
    filename             = "${path.module}/examples/exercise/input-json/newfile.json"
    file_permission      = "750"
    directory_permission = "750"
}