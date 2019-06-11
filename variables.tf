variable "name" {
  type        = string
  default     = ""
  description = "The name of the Cloud NAT gateway. Defaults to `nat-$$${var.region}`."
}

variable "region" {
  type        = string
  description = "The region for which this Cloud NAT gateway is for"
}

variable "address_links" {
  type        = list(string)
  default     = []
  description = "The self link of addresses managed outside this module to use for the NAT gateway."
}

variable "reserve_addresses" {
  type        = string
  default     = true
  description = "Boolean value to indicate whether this module should reserve addresses for use with the NAT gateway."
}

variable "reserved_address_count" {
  type        = string
  default     = 1
  description = "When reserving addresses, the number of addresses to reserve."
}

variable "reserved_address_name" {
  type        = string
  default     = "nat-{region}-{0count}"
  description = "The name format to use when reserving addresses. String replacements: {region}, {count} (1-based count index), and {0count} (1-based count index, zero padded)."
}

variable "reserved_address_description" {
  type        = string
  default     = "Cloud NAT gateway in {region}."
  description = "Description to use for managed addresses. String replacements: {region}, {count} (1-based count index), and {0count} (1-based count index, zero padded)."
}

variable "network" {
  type        = string
  default     = "default"
  description = "The network to which this Cloud NAT gateway applies."
}

variable "min_ports_per_vm" {
  type        = string
  default     = 128
  description = "Minimum number of ports allocated to a VM."
}

variable "udp_idle_timeout_sec" {
  type        = string
  default     = 30
  description = "Timeout (in seconds) for UDP connections."
}

variable "tcp_established_idle_timeout_sec" {
  type        = string
  default     = 1200
  description = "Timeout (in seconds) for established TCP connections."
}

variable "tcp_transitory_idle_timeout_sec" {
  type        = string
  default     = 30
  description = "Timeout (in seconds) for transitory TCP connections."
}

variable "icmp_idle_timeout_sec" {
  type        = string
  default     = 30
  description = "Timeout (in seconds) for ICMP connections."
}

variable "logging_filter" {
  type        = string
  default     = "ERRORS_ONLY"
  description = "Indicates whether logging is enabled. `null` to disable logging, and https://www.terraform.io/docs/providers/google/r/compute_router_nat.html#filter for possible values."
}

locals {
  address_links = concat(
    var.address_links,
    google_compute_address.nat_address.*.self_link,
  )
}

