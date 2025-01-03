
account_email = "dev-astronomer@astronomer-88.iam.gserviceaccount.com"

prj_platform    = "gcp"
prj_project_id  = "atelier-012024"
prj_environment = "dev"
prj_region      = "us-central1"

// -------------------------------------------------------------------------------- NETWORKING -- //
// -------------------------------------------------------------------------------- ---------- -- //

vpc_id           = "atelier-vpc"
vpc_name         = "atelier-vpc"
vpc_routing_mode = "REGIONAL"
subnet_name      = "atelier-subnet"
subnet_ipv4      = "192.168.1.0/24"
firewall_name    = "atelier-firewall"

cmp_instance_type  = "e2-micro"
cmp_instance_name  = "progression-server"
cmp_instance_image = "debian-cloud/debian-11"
cmp_instance_ssh   = ""
