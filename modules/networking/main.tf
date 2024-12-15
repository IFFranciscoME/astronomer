
resource "google_compute_network" "data_platform_vpc" {

  name                    = "data-platform-vpc"
  description             = "VPC Network for the Data Platform"
  auto_create_subnetworks = false
  routing_mode            = var.vpc_routing_mode
  mtu                     = 1460
  
  delete_default_routes_on_create = true
  
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
  
}

resource "google_compute_subnetwork" "data_lake_subnet" {
  
  name          = "data-lake-subnet"
  region        = var.pro_region
  network       = google_compute_network.data_platform_vpc.id
  
  ip_cidr_range = var.vpc_dl_subnet_ipv4
  ipv6_access_type = "INTERNAL"

  
}

resource "google_compute_firewall" "data_platform_firewall" {
  name    = "data-platform-firewall"
  network = google_compute_network.data_platform_vpc.id

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"] # Allow SSH, HTTP, HTTPS
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = [
    var.vpc_dl_subnet_ipv4,
  ]
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.data_platform_vpc.id
}

resource "google_service_networking_connection" "vpc_private_connection" {
  network                 = google_compute_network.data_platform_vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

