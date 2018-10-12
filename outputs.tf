output "NomadServerPubIP" {
  value = "${module.NomadServerTier.public_ip}"
}

output "NomadClientPubIP" {
  value = "${module.NomadClientTier.public_ip}"
}

output "ConsulPubIP" {
  value = "${module.ConsulTier.public_ip}"
}

output "NomadServerPubFQDN" {
  value = "${module.NomadServerTier.public_fqdn}"
}

output "NomadClientPubFQDN" {
  value = "${module.NomadClientTier.public_fqdn}"
}

output "ConsulPubFQDN" {
  value = "${module.ConsulTier.public_fqdn}"
}
