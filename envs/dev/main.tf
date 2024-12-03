
module "data" {

  source      = "../../modules/data/"
  region      = var.region
  environment = var.environment
  zone        = var.zone

  vpc_id = module.networking.data_platform_vpc_id
  
  db_instance_name  = var.db_instance_name
  db_instance_tier  = var.db_instance_tier
  db_name           = var.db_name
  db_schema         = var.db_schema
  db_engine_version = var.db_engine_version

}

module "networking" {

  source      = "../../modules/networking/"
  region      = var.region
  environment = var.environment

  vpc_id = module.networking.data_platform_vpc_id
  
  vpc_routing_mode   = var.vpc_routing_mode
  vpc_dl_subnet_ipv4 = var.vpc_dl_subnet_ipv4
  vpc_dl_subnet_ipv6 = var.vpc_dl_subnet_ipv6
  vpc_dw_subnet_ipv4 = var.vpc_dw_subnet_ipv4
  vpc_dw_subnet_ipv6 = var.vpc_dw_subnet_ipv6

}

module "events" {

  source = "../../modules/events/"
  region = var.region
  environment = var.environment

  vpc_id = module.networking.data_platform_vpc_id

}

