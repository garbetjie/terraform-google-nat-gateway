resource "google_compute_router" "router" {
  name        = var.name == "" ? "nat-${var.region}" : var.name
  network     = var.network
  description = "Cloud router used for the NAT gateway in the ${var.region} region."
  region      = var.region
}

resource "google_compute_router_nat" "nat" {
  name                               = format("nat-%s", var.region)
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "MANUAL_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ips                          = local.address_links
  min_ports_per_vm                 = var.min_ports_per_vm
  udp_idle_timeout_sec             = var.udp_idle_timeout_sec
  tcp_established_idle_timeout_sec = var.tcp_established_idle_timeout_sec
  tcp_transitory_idle_timeout_sec  = var.tcp_transitory_idle_timeout_sec
  icmp_idle_timeout_sec            = var.icmp_idle_timeout_sec

  log_config {
    enable = var.logging_filter != null
    filter = var.logging_filter
  }
}

data "google_compute_address" "existing_addresses" {
  count  = length(var.address_links)
  name   = basename(var.address_links[count.index])
  region = var.region
}

resource "google_compute_address" "nat_address" {
  count       = var.reserve_addresses ? var.reserved_address_count : 0
  name        = replace(
      replace(
        replace(var.reserved_address_name, "{region}", var.region),
        "{count}",
        count.index + 1
      ),
      "{0count}",
      format("%02d", count.index + 1)
    )
  region      = var.region
  description = (var.reserved_address_description != null ?
    replace(
      replace(
        replace(var.reserved_address_description, "{region}", var.region),
        "{count}",
        count.index + 1
      ),
      "{0count}",
      format("%02d", count.index + 1)
    ): null)
}
