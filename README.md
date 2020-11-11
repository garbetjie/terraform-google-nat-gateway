# Cloud NAT Gateway Terraform Module

A Terraform module that manages [Cloud NAT](https://cloud.google.com/nat/docs/overview) Gateways, and can manage the
addresses used by the Cloud NAT gateway too.


## Usage

```hcl
resource google_compute_address address {
  name = "my-reserved-address"
  region = "europe-west3"
}

module cloud_nat {
  source = "garbetjie/nat-gateway/google"
  region = "europe-west3"
  addresses = [google_compute_address.address.name /*, OR google_compute_address.address.self_link, OR google_compute_address.address.id */]
}
```


## Inputs

| Name                             | Description                                                              | Type         | Default               | Required |
|----------------------------------|--------------------------------------------------------------------------|--------------|-----------------------|----------|
| region                           | Region for which this Cloud NAT gateway is for.                          | string       |                       | Yes      |
| addresses                        | Links, names or IDs of addresses to assign to the NAT gateway.           | list(string) |                       | Yes      |
| name                             | Name of the Cloud NAT gateway.                                           | string       | `"nat-${var.region}"` | No       |
| network                          | Network to which this Cloud NAT gateway applies.                         | string       | `"default"`           | No       |
| min_ports_per_vm                 | Minimum number of ports allocated to each VM for this Cloud NAT gateway. | string       | `256`                 | No       |
| udp_idle_timeout_sec             | Timeout (in seconds) for UDP connections.                                | string       | `30`                  | No       |
| tcp_established_idle_timeout_sec | Timeout (in seconds) for established TCP connections.                    | string       | `1200`                | No       |
| tcp_transitory_idle_timeout_sec  | Timeout (in seconds) for transitory TCP connections.                     | string       | `30`                  | No       |
| icmp_idle_timeout_sec            | Timeout (in seconds) for ICMP connections.                               | string       | `30`                  | No       |
| logging_enabled                  | Enable/disable logging on the NAT gateway.                               | bool         | `true`                | No       |
| logging_filter                   | Filter to apply to NAT gateway logs.                                     | string       | `"ERRORS_ONLY"`       | No       |


## Outputs

| Name            | Type         | Description                                     |
|-----------------|--------------|-------------------------------------------------|
| addresses       | list(string) | IP addresses assigned to the NAT gateway.       |
| address_links   | list(string) | Links of addresses assigned to the NAT gateway. |
| address_names   | list(string) | Names of addresses assigned to the NAT gateway. |
| router_name     | string       | Name of the created router.                     |
| nat_router_name | string       | Name of the created NAT gateway.                |
