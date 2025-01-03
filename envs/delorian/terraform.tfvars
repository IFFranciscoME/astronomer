gcp_account_email = "dev-astronomer@astronomer-88.iam.gserviceaccount.com"

prj_environment = "dev"
prj_project_id  = "astronomer-88"
prj_region      = "us-central1"
prj_zone        = "us-central1-a"

vpc_id   = "astronomer_vpc"
vpc_name = "astronomer_vpc"

vpc_routing_mode   = "REGIONAL"
vpc_dl_subnet_ipv4 = "192.168.1.0/24"

cmp_instance_type = "e2-small"
cmp_instance_name = "progression_server"

dbm_instance_name = "dev-datalake-instance"
dbm_instance_tier = "db-f1-micro"

dbm_engine_version = "POSTGRES_15"
dbm_schema         = "schema"
dbm_name           = "dev-datalake-db"
