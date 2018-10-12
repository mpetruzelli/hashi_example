output "public_ip" {
  value = "${element(concat(azurerm_public_ip.AzurePubIP.*.ip_address, list("")), 0)}"
}

output "public_fqdn" {
  value = "${element(concat(azurerm_public_ip.AzurePubIP.*.fqdn, list("")), 0)}"
}
