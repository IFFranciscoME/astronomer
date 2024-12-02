
output "data_platform_vpc_id" {
  description = "The ID of the VPC network"
  value       = google_compute_network.data_platform_vpc.id
}

output "data_lake_subnet_id" {
  description = "The ID of the Data Lake subnet"
  value       = google_compute_subnetwork.data_lake_subnet.id
}

output "data_warehouse_subnet_id" {
  description = "The ID of the Data Warehouse subnet"
  value       = google_compute_subnetwork.data_warehouse_subnet.id
}

output "vpc_network_self_link" {
  description = "Self link of the VPC network"
  value       = google_compute_network.data_platform_vpc.self_link
}

output "data_lake_subnet_self_link" {
  description = "Self link of the Data Lake subnet"
  value       = google_compute_subnetwork.data_lake_subnet.self_link
}

output "data_warehouse_subnet_self_link" {
  description = "Self link of the Data Warehouse subnet"
  value       = google_compute_subnetwork.data_warehouse_subnet.self_link
}

