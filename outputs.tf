output "address_links" {
  value       = [google_compute_address.nat_address.*.self_link]
  description = "Self links of addresses managed by this module."
}

output "addresses" {
  value       = [google_compute_address.nat_address.*.address]
  description = "IPs of addresses managed by this module."
}

