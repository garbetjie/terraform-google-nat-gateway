output "address_links_managed" {
  value       = google_compute_address.nat_address.*.self_link
  description = "Self links of addresses managed by this module."
}

output "addresses_managed" {
  value       = google_compute_address.nat_address.*.address
  description = "IPs of addresses managed by this module."
}

output "address_links" {
  value = concat(google_compute_address.nat_address.*.self_link, data.google_compute_address.existing_addresses.*.self_link)
  description = "Self links of all addresses in this module (both managed and unmanaged)."
}

output "addresses" {
  value = concat(google_compute_address.nat_address.*.address, data.google_compute_address.existing_addresses.*.address)
  description = "IPs of all addresses in this module (both managed and unmanaged)."
}
