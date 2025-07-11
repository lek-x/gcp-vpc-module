# GCP VPC Module

This module creates a Virtual Private Cloud (VPC) network in Google Cloud Platform (GCP).

## Features

- Creates a VPC network.
- Creates 2 subnets(private and public) within the VPC network.
- Optionally creates a NAT gateway for private subnet instances to access the internet.
- Creates Firewall rules for subnets


## Usage

To use this module, include it in your Terraform configuration:

```terraform
module "gcp-vpc" {
  source  = "git::https://github.com/lek-x/gcp-vpc-module.git
  project   = "your-gcp-project-id"
  region = "your-gcp-region"
  zone = "your-gcp-zone"
  vpc_name = "your-vpc-name"
  vpc_routing_mode = "REGIONAL or GLOBAL"

  # subnets
  public_subnet_name = "your-public-subnet-name"
  private_subnet_name = "your-private-subnet-name"

  public_subnet_cidr = "public subnet cird (e.g. 10.2.1.0/28)"
  private_subnet_cidr = "private subnet cird (e.g. 10.2.2.0/28)"

  # subnets firewall
  public_allowed_ports_tcp = "list of allowed tcp ports for public subnet e.g. ["22", "8080"]"
  public_allowed_ports_udp = "list of allowed udp ports for public subnet e.g. ["53", "1766"]"

  public_firewall_icmp = "allow or deny icmp to public e.g. true or false"

  private_allowed_ports_tcp = "list of allowed tcp ports for private subnet e.g. ["22", "8080"]"

  private_allowed_ports_udp = "list of allowed udp ports for private subnet e.g. ["53", "1766"]"

  private_firewall_icmp = "allow or deny icmp to private e.g. true or false"

  # Private subnet NAT
  private_nat_enabled = "true or false"
}

```

## License
GPL v3
