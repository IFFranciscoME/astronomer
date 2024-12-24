
output "data_lake_vpc_id" {
  type        = string
  description = "The ID of the VPC network"
  value       = google_compute_network.data_lake_vpc.id
}

output "data_lake_vpc_name" {
  type        = string
  description = "The NAME of the VPC network"
  value       = google_compute_network.data_lake_vpc.name
}

output "data_lake_subnet_id" {
  type        = string
  description = "The ID of the Data Lake subnet"
  value       = google_compute_subnetwork.data_lake_subnet.id
}

output "data_lake_subnet_self_link" {
  type        = string
  description = "Self link of the Data Lake subnet"
  value       = google_compute_subnetwork.data_lake_subnet.self_link
}

output "data_lake_network_self_link" {
  type        = string
  description = "Self link of the VPC network"
  value       = google_compute_network.data_lake_vpc.self_link
}

output "vpc_private_connection" {
  type        = string
  description = "The definition of the private VPC for cross communications"
  value       = google_service_networking_connection.vpc_private_connection
}

