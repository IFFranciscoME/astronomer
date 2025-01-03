
// ------------------------------------------------------------------------------------- ROLES -- //
// ------------------------------------------------------------------------------------- ----- -- //

module "roles" {

  source = "../../modules/roles/"

  prj_project_id  = var.prj_project_id
  prj_environment = var.prj_environment
  prj_region      = var.prj_region

}

// -------------------------------------------------------------------------------- NETWORKING -- //
// -------------------------------------------------------------------------------- ---------- -- //

module "networking" {

  source = "../../modules/networking/"

  prj_project_id  = var.prj_project_id
  prj_environment = var.prj_environment
  prj_region      = var.prj_region

  vpc_name         = var.vpc_name
  vpc_id           = var.vpc_id
  vpc_routing_mode = var.vpc_routing_mode

  subnet_name   = var.subnet_name
  subnet_ipv4   = var.subnet_ipv4
  firewall_name = var.firewall_name

  depends_on = [module.roles]

}

// ----------------------------------------------------------------------------------- COMPUTE -- //
// ----------------------------------------------------------------------------------- ------- -- //

module "compute" {

  source = "../../modules/compute/"

  prj_project_id  = var.prj_project_id
  prj_environment = var.prj_environment
  prj_region      = var.prj_region

  cmp_subnet_id = module.networking.subnet_id

  cmp_instance_name  = var.cmp_instance_name
  cmp_instance_image = var.cmp_instance_image
  cmp_instance_type  = var.cmp_instance_type

  depends_on = [module.networking]

}

