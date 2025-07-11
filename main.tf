# Create a VPC
resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  routing_mode            = var.vpc_routing_mode
}

resource "google_compute_subnetwork" "public_subnet" {
  name                     = var.public_subnet_name
  ip_cidr_range            = var.public_subnet_cidr
  region                   = var.region
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "private_subnet" {
  name                     = var.private_subnet_name
  ip_cidr_range            = var.private_subnet_cidr
  region                   = var.region
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
}

resource "google_compute_firewall" "public_firewall" {
  name               = "public-firewall"
  network            = google_compute_network.vpc.name
  project            = var.project
  direction          = "INGRESS"
  source_ranges      = ["0.0.0.0/0"]
  destination_ranges = [var.public_subnet_cidr]

  description = "Creates firewall for public subnet"

  # allow icmp
  dynamic "allow" {
    for_each = var.public_firewall_icmp != null ? [1] : []
    content {
      protocol = "icmp"
    }
  }
  # allow tcp
  allow {
    protocol = "tcp"
    ports    = var.public_allowed_ports_tcp

  }

  # allow udp
  dynamic "allow" {
    for_each = var.public_allowed_ports_udp != null ? [1] : []
    content {
      protocol = "udp"
      ports    = var.public_allowed_ports_udp
    }
  }
}

resource "google_compute_firewall" "private_firewall" {
  name               = "private-firewall"
  network            = google_compute_network.vpc.name
  project            = var.project
  direction          = "INGRESS"
  source_ranges      = ["0.0.0.0/0"]
  destination_ranges = [var.private_subnet_cidr]

  description = "Creates firewall for private subnet"

  # allow icmp
  dynamic "allow" {
    for_each = var.private_firewall_icmp ? [1] : []
    content {
      protocol = "icmp"
    }
  }

  # allow tcp
  allow {
    protocol = "tcp"
    ports    = var.private_allowed_ports_tcp

  }

  # allow udp
  dynamic "allow" {
    for_each = var.private_allowed_ports_udp != null ? [1] : []
    content {
      protocol = "udp"
      ports    = var.private_allowed_ports_udp
    }
  }
}

resource "google_compute_router" "private_router" {
  name    = "private-router"
  network = google_compute_network.vpc.name
  region  = var.region
}

resource "google_compute_router_nat" "nat_config" {
  count                              = var.private_nat_enabled ? 1 : 0
  name                               = "private-nat"
  router                             = google_compute_router.private_router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.private_subnet.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
