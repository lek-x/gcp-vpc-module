output "vpc" {
  value = "name: ${google_compute_network.vpc.name}, lnk: ${google_compute_network.vpc.self_link}"
}

output "subnet_public" {
  value = "id: ${google_compute_subnetwork.public_subnet.subnetwork_id}, lnk: ${google_compute_subnetwork.public_subnet.self_link}"
}

output "subnet_private" {
  value = "id: ${google_compute_subnetwork.private_subnet.subnetwork_id}, lnk: ${google_compute_subnetwork.private_subnet.self_link}"
}
