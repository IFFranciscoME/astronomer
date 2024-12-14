
module "networking" {

  source      = "../../modules/networking/"
  
  pro_project_id  = var.pro_project_id
  pro_region      = var.pro_region
  pro_environment = var.pro_environment

  vpc_id = module.networking.data_platform_vpc_id
  vpc_routing_mode   = var.vpc_routing_mode
  vpc_dl_subnet_ipv4 = var.vpc_dl_subnet_ipv4

}

module "data" {

  source      = "../../modules/data/"
  
  pro_project_id  = var.pro_project_id
  pro_region      = var.pro_region
  pro_environment = var.pro_environment
  pro_zone        = var.pro_zone

  vpc_id                 = module.networking.data_platform_vpc_id
  private_vpc_connection = module.networking.private_vpc_connection

  dbm_instance_name  = var.dbm_instance_name
  dbm_instance_tier  = var.dbm_instance_tier
  dbm_name           = var.dbm_name
  dbm_schema         = var.dbm_schema
  dbm_engine_version = var.dbm_engine_version

}

