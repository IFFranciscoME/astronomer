
pro_environment    = "delorian"
pro_project_id     = "delorian-stg"
pro_region         = "us-central1"
pro_zone           = "us-central1-a"

vpc_id             = "delorian_vpc"
vpc_routing_mode   = "REGIONAL"
vpc_dl_subnet_ipv4 = "192.168.1.0/24"

cmp_instance_type  = "e2-small"
cmp_instance_name  = "progression_server"

dbm_instance_name  = "dev-datalake-instance"
dbm_name           = "dev-datalake-db"
dbm_instance_tier  = "db-f1-micro"
dbm_engine_version = "POSTGRES_15"
dbm_schema         = "schema"

