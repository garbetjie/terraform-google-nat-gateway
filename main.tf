resource "google_compute_router" "nat_router" {
  name = var.name == null ? "nat-${var.region}" : var.name
  network = var.network
  description = "Cloud router used for the NAT gateway in the ${var.region} region."
  region = var.region
}

resource "google_compute_router_nat" "nat" {
  name = var.name == null ? "nat-${var.region}" : var.name
  router = google_compute_router.nat_router.name
  region = var.region
  nat_ip_allocate_option = "MANUAL_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ips = var.addresses
  min_ports_per_vm = var.min_ports_per_vm
  udp_idle_timeout_sec = var.udp_idle_timeout_sec
  tcp_established_idle_timeout_sec = var.tcp_established_idle_timeout_sec
  tcp_transitory_idle_timeout_sec = var.tcp_transitory_idle_timeout_sec
  icmp_idle_timeout_sec = var.icmp_idle_timeout_sec

  log_config {
    enable = var.logging_enabled
    filter = var.logging_filter
  }
}
