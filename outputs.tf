output addresses {
  value = [
    for addr in data.google_compute_address.addresses:
      addr.address
  ]
  description = "IP addresses assigned to the NAT gateway."
}

output address_links {
  value = [
    for address in data.google_compute_address.addresses:
      address.self_link
  ]
  description = "Links of addresses assigned to the NAT gateway."
}

output address_names {
  value = [
    for address in data.google_compute_address.addresses:
      address.name
  ]
  description = "Names of addresses assigned to the NAT gateway."
}

output router_name {
  value = google_compute_router.nat_router.name
  description = "Name of the created router."
}

output nat_router_name {
  value = google_compute_router_nat.nat.name
  description = "Name of the created NAT gateway."
}
