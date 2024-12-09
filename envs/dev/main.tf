
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

  project_id  = var.project_id
  source      = "../../modules/events/"
  region      = var.region
  environment = var.environment

  vpc_id      = module.networking.data_platform_vpc_id

}

module "credentials" {

  source              = "../../modules/credentials"

  project_id          = var.project_id
  gcp_private_key_id  = var.gcp_private_key_id
  gcp_private_key     = var.gcp_private_key
  gcp_client_email    = var.gcp_client_email
  gcp_client_id       = var.gcp_client_id
  gcp_auth_uri        = var.gcp_auth_uri
  gcp_token_uri       = var.gcp_token_uri
  gcp_client_cert_url = var.gcp_client_cert_url
  gcp_auth_provider   = var.gcp_auth_provider
  
  credentials_json    = module.credentials.credentials_json

}
