
// ------------------------------------------------------------------------- ----------------- -- //
// ------------------------------------------------------------------------- ENABLE APIs USAGE -- //
// ------------------------------------------------------------------------- ----------------- -- //

resource "google_project_service" "first_enable_apis" {

  project = var.prj_project_id
  service = "cloudresourcemanager.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false

}

resource "google_project_service" "enable_apis" {

  for_each = local.apis
  project = var.prj_project_id
  service = "${each.value["url"]}.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false

  timeouts {
    create = "100m"
    update = "100m"
    delete = "100m"
    read   = "100m"
  }

depends_on = [
  google_project_service.first_enable_apis
  ]

}

// ----------------------------------------------------------------------- ------------------- -- //
// ----------------------------------------------------------------------- VPC/SUBNET/FIREWALL -- //
// ----------------------------------------------------------------------- ------------------- -- //

resource "google_compute_network" "data_lake_vpc" {

  name                    = var.vpc_name
  description             = "VPC Network for the Data Lake"
  auto_create_subnetworks = false
  routing_mode            = var.vpc_routing_mode
  mtu                     = 1460
  
  delete_default_routes_on_create = true
  
  timeouts {
    create = "100m"
    update = "100m"
    delete = "100m"
  }
  
}

resource "google_compute_subnetwork" "data_lake_subnet" {
  
  name          = "data-lake-subnet"
  region        = var.prj_region
  network       = google_compute_network.data_lake_vpc.id
  
  ip_cidr_range = var.vpc_dl_subnet_ipv4
  ipv6_access_type = "INTERNAL"
  
}

resource "google_compute_firewall" "data_lake_firewall" {

  name    = "data-lake-firewall"
  network = google_compute_network.data_lake_vpc.id

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

// ---------------------------------------------------------------------- ------------------- -- //
// ---------------------------------------------------------------------- PRIVATE CONNECTIONS -- //
// ---------------------------------------------------------------------- ------------------- -- //

resource "google_compute_global_address" "private_ip_address" {

  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.data_lake_vpc.id

}

resource "google_service_networking_connection" "vpc_private_connection" {

  network                 = google_compute_network.data_lake_vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]

}

