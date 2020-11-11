variable region {
  type = string
  description = "Region for which this Cloud NAT gateway is for."
}

variable addresses {
  type = list(string)
  description = "Links or names of addresses to assign to the NAT gateway."
}

variable name {
  type = string
  default = null
  description = "Name of the Cloud NAT gateway. Defaults to `nat-$$${var.region}`."
}

variable network {
  type = string
  default = "default"
  description = "The network to which this Cloud NAT gateway applies."
}

variable min_ports_per_vm {
  type = number
  default = 256
  description = "Minimum number of ports allocated to a VM."
}

variable udp_idle_timeout_sec {
  type = number
  default = 30
  description = "Timeout (in seconds) for UDP connections."
}

variable tcp_established_idle_timeout_sec {
  type = number
  default = 1200
  description = "Timeout (in seconds) for established TCP connections."
}

variable tcp_transitory_idle_timeout_sec {
  type = number
  default = 30
  description = "Timeout (in seconds) for transitory TCP connections."
}

variable icmp_idle_timeout_sec {
  type = number
  default = 30
  description = "Timeout (in seconds) for ICMP connections."
}

variable logging_enabled {
  type = bool
  default = true
  description = "Enable/disable logging on the NAT gateway."
}

variable logging_filter {
  type = string
  default = "ERRORS_ONLY"
  description = "Filter to apply to NAT gateway logs."
}
