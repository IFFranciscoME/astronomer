
module "networking" {

  source = "../../modules/networking/"

  prj_project_id  = var.prj_project_id
  prj_region      = var.prj_region
  prj_environment = var.prj_environment

  vpc_id             = module.networking.data_lake_vpc_id
  vpc_name           = var.vpc_name
  vpc_routing_mode   = var.vpc_routing_mode
  vpc_dl_subnet_ipv4 = var.vpc_dl_subnet_ipv4

}

module "data" {
  source = "../../modules/data/"

  vpc_id                 = module.networking.data_lake_vpc_id
  vpc_private_connection = module.networking.vpc_private_connection

  gcp_account_email = var.gcp_account_email

  prj_project_id  = var.prj_project_id
  prj_region      = var.prj_region
  prj_environment = var.prj_environment
  prj_zone        = var.prj_zone

  dbm_instance_name  = var.dbm_instance_name
  dbm_instance_tier  = var.dbm_instance_tier
  dbm_name           = var.dbm_name
  dbm_engine_version = var.dbm_engine_version

}

