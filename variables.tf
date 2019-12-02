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
  default     = "nat-%s-%02d"
  description = "The name format to use when reserving addresses. Interpolated with the region and count.index + 1."
}

variable "reserved_address_description" {
  type        = string
  default     = "Cloud NAT gateway in %s."
  description = "Description to use for managed addresses. Interpolated with the region."
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

locals {
  address_links = concat(
    var.address_links,
    google_compute_address.nat_address.*.self_link,
  )
}

