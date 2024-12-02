
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
  
  internal_ipv6_range = var.vpc_dl_subnet_ipv6
  enable_ula_internal_ipv6 = true
  
}

resource "google_compute_subnetwork" "data_lake_subnet" {
  
  name          = "data-lake-subnet"
  region        = var.region
  network       = google_compute_network.data_platform_vpc.id
  
  ip_cidr_range = var.vpc_dl_subnet_ipv4
  ipv6_access_type = "INTERNAL"

}

resource "google_compute_subnetwork" "data_warehouse_subnet" {
  
  name          = "data-warehouse-subnet"
  region        = var.region
  network       = google_compute_network.data_platform_vpc.id
  
  ip_cidr_range = var.vpc_dw_subnet_ipv4
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
    var.vpc_dl_subnet_ipv6,
    var.vpc_dw_subnet_ipv4,
    var.vpc_dw_subnet_ipv6
  ]

}

