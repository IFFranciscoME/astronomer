
resource "google_project_service" "platform_apis" {

  for_each = local.prj_platform
  project  = var.prj_project_id
  service  = "${each.value["url"]}"
  disable_dependent_services = false
  disable_on_destroy = false

}

resource "google_compute_network" "network_vpc" {

  name                    = var.vpc_name
  description             = "VPC Network for the ${var.vpc_name}"
  auto_create_subnetworks = false
  routing_mode            = var.vpc_routing_mode
  mtu                     = 1460
  
  delete_default_routes_on_create = true
  
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
  
  enable_ula_internal_ipv6 = false

  depends_on = [google_project_service.platform_apis]

}

resource "google_compute_subnetwork" "network_subnet" {
  
  name          = var.subnet_name
  region        = var.prj_region
  network       = google_compute_network.network_vpc.id
  
  ip_cidr_range = var.subnet_ipv4
  ipv6_access_type = "INTERNAL"

  depends_on = [google_compute_network.network_vpc]

}

resource "google_compute_firewall" "network_firewall" {
  name    = var.firewall_name
  network = google_compute_network.network_vpc.id

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"] # Allow SSH, HTTP, HTTPS
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = [
    var.subnet_ipv4,
  ]
  
  depends_on = [google_compute_subnetwork.network_subnet]

}

