# ----------------------------------------
# Write your Terraform module outputs here
# ----------------------------------------


output "zones" {
  value       = resource.dns_a_record_set.example.zone
  description = "List of zones corresponding to each individual dns record."
}

output "dns_record_type" {
  value       = resource.dns_a_record_set.example.name
  description = "The name of the dns record."
}

output "addresses" {
  value       = resource.dns_a_record_set.example.addresses
  description = "List of addresses corresponidng to each individual dns record."
}

output "ttl" {
  value       = resource.dns_a_record_set.example.ttl
  description = "TTL corresponding to each individual dns record."
}

output "jsonfile" {
  value       = resource.local_file.newfile
  description = "The content of the new created json file."
  sensitive   = true
}

