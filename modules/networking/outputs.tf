
output "subnet_id" {
  description = "The ID of the Data Lake subnet"
  value       = google_compute_subnetwork.network_subnet.id
}

output "subnet_self_link" {
  description = "Self link of the Data Lake subnet"
  value       = google_compute_subnetwork.network_subnet.self_link
}

output "network_self_link" {
  description = "Self link of the VPC network"
  value       = google_compute_network.network_vpc.self_link
}

