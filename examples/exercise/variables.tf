# ----------------------------------------
# Write your Terraform module inputs here
# ----------------------------------------

variable "dns_server" {
  type        = string
  description = "(Required) IP or FQDN of the DNS server"
  default     = "localhost"
}