# Cloud NAT Gateway Terraform Module

A Terraform module that manages [Cloud NAT](https://cloud.google.com/nat/docs/overview) Gateways, and can manage the
addresses used by the Cloud NAT gateway too.


## Usage

### Default usage

The following example will create the Cloud NAT gateway, and reserve a single static address for use with it.

```hcl
module cloud_nat {
  source = "garbetjie/nat-gateway/google"
  region = "europe-west3"
}
``` 

Optionally, the number of addresses can be changed.

```hcl
module cloud_nat {
  source = "garbetjie/nat-gateway/google"
  region = "europe-west3"
  reserved_address_count = 2
}
``` 

### Externally managed addresses

If you want to manage the reservation of addresses yourself, the automatic reservation of addresses can be disabled. If
this is the case, then you'll need to supply the self links of your reserved addresses.

```hcl
resource google_compute_address address {
  name = "my-reserved-address"
  region = "europe-west3"
}

module cloud_nat {
  source = "garbetjie/nat-gateway/google"
  region = "europe-west3"
  reserve_addresses = false
  address_links = ["${google_compute_address.address.self_link}"]
}
```


## Inputs

| Name                             | Description                                                                     | Type   | Default               | Required |
|----------------------------------|---------------------------------------------------------------------------------|--------|-----------------------|----------|
| name                             | The name of the Cloud NAT router & gateway.                                     | string | `"nat-${var.region}"` | No       |
| region                           | The region for which this Cloud NAT gateway applies.                            | string |                       | Yes      |
| address_links                    | The self links of addresses that are reserved outside of the module.            | list   | `[]`                  | No       |
| reserve_addresses                | Whether or not to reserve addresses with this module. One of `true` or `false`. | string | `true`                | No       |
| reserved_address_count           | The number of addresses to reserve when reserving addresses in this module.     | string | `1`                   | No       |
| network                          | The network to which this Cloud NAT gateway applies.                            | string | `"default"`           | No       |
| min_ports_per_vm                 | Minimum number of ports allocated to each VM for this Cloud NAT gateway.        | string | `128`                 | No       |
| udp_idle_timeout_sec             | Timeout (in seconds) for UDP connections.                                       | string | `30`                  | No       |
| tcp_established_idle_timeout_sec | Timeout (in seconds) for established TCP connections.                           | string | `1200`                | No       |
| tcp_transitory_idle_timeout_sec  | Timeout (in seconds) for transitory TCP connections.                            | string | `30`                  | No       |
| icmp_idle_timeout_sec            | Timeout (in seconds) for ICMP connections.                                      | string | `30`                  | No       |


## Outputs

| Name          | Type | Description                                                  |
|---------------|------|--------------------------------------------------------------|
| address_links | list | The self links of addresses that are managed by this module. |
| addresses     | list | The IPs of addresses that are managed by this module.        |
