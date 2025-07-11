variable "project" {
  description = "The GCP project ID where the resources will be created."
  type        = string
  default     = "test-ntr-465513"

}

variable "region" {
  description = "The GCP region where the resources will be created."
  type        = string
  default     = "europe-west1"
}

variable "zone" {
  description = "The GCP zone where the resources will be created."
  type        = string
  default     = "eu-central2-a"
}

variable "vpc_name" {
  description = "The name of the VPC network to be created."
  type        = string
  default     = "vpc1"
}

variable "vpc_routing_mode" {
  description = "The routing mode for the VPC network."
  type        = string
  default     = "REGIONAL"

}
variable "public_subnet_name" {
  description = "The name of the public subnet to be created."
  type        = string
  default     = "public-subnet"
}

variable "public_subnet_cidr" {
  description = "The CIDR range for the public subnet."
  type        = string
  default     = "10.2.1.0/28"
}

variable "private_subnet_name" {
  description = "The name of the private subnet to be created."
  type        = string
  default     = "private-subnet"
}

variable "private_subnet_cidr" {
  description = "The CIDR range for the public subnet."
  type        = string
  default     = "10.2.2.0/28"
}

variable "public_allowed_ports_tcp" {
  description = "List of allowed ports for the public firewall rule."
  type        = list(string)
  default     = ["22", "8080"]
}

variable "public_allowed_ports_udp" {
  description = "List of allowed ports for the public firewall rule."
  type        = list(string)
  default     = [""]
}

variable "public_firewall_icmp" {
  description = "Enable ICMP protocol in the public firewall rule."
  type        = bool
  default     = true
}

variable "private_allowed_ports_tcp" {
  description = "List of allowed ports for the public firewall rule."
  type        = list(string)
  default     = ["22"]

}

variable "private_allowed_ports_udp" {
  description = "List of allowed ports for the public firewall rule."
  type        = list(string)
  default     = [""]

}

variable "private_firewall_icmp" {
  description = "Enable ICMP protocol in the private firewall rule."
  type        = bool
  default     = true
}

variable "private_nat_enabled" {
  description = "Enable NAT for private subnet."
  type        = bool
  default     = true
}
