
output "data_platform_vpc_id" {
  description = "The ID of the VPC network"
  value       = google_compute_network.data_platform_vpc.id
}

output "private_vpc_connection" {
  description = "The definition of the private VPC for cross communications"
  value       = google_service_networking_connection.private_vpc_connection
}

output "data_lake_subnet_id" {
  description = "The ID of the Data Lake subnet"
  value       = google_compute_subnetwork.data_lake_subnet.id
}

output "vpc_network_self_link" {
  description = "Self link of the VPC network"
  value       = google_compute_network.data_platform_vpc.self_link
}

output "data_lake_subnet_self_link" {
  description = "Self link of the Data Lake subnet"
  value       = google_compute_subnetwork.data_lake_subnet.self_link
}

