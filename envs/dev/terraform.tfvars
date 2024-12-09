
environment        = "dev"
project_id         = "astronomer-88"
region             = "us-central1"
zone               = "us-central1-a"

cmp_instance_type  = "e2-small"
cmp_instance_name  = "progression_server"

db_instance_name   = "dev-datalake-instance"
db_name            = "dev-datalake-db"
db_instance_tier   = "db-f1-micro"
db_engine_version  = "POSTGRES_15"
db_schema         = "schema"

vpc_id             = "data_platform"
vpc_routing_mode   = "REGIONAL"
vpc_dl_subnet_ipv4 = "192.168.1.0/24"
vpc_dl_subnet_ipv6 = "2001:fd20:a:b::/48"
vpc_dw_subnet_ipv4 = "192.168.2.0/24"
vpc_dw_subnet_ipv6 = "2001:db8:2::/64"

