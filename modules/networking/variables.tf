
// -------------------------------------------------------------------------------------- VPC -- //

variable "vpc_id" {
  type        = string 
  description = "the ID of the VPC to use for the data-lake resources"
}

variable "vpc_name" {
  type        = string 
  description = "the NAME of the VPC to use for the data-lake resources"
}

variable "vpc_routing_mode" {
  type        = string
  description = "config for the dynamic routing mode"
}

variable "vpc_dl_subnet_ipv4" {
  type = string
  description = ""
}

// ---------------------------------------------------------------------------------- PROJECT -- //

variable "prj_project_id" {
  type        = string
  description = "GCP Related: The whole project ID"
}

variable "prj_region" {
  type        = string
  description = "The GCP region where the SQL instance will be created"
}

variable "prj_environment" {
  type        = string
  description = "a Tag to identify different environments to deploy"
}

// -------------------------------------------------------------------------- LOCAL VARIABLES -- //

locals {
  
  apis = {
    "networking" = { url = "servicenetworking.googleapis.com" }
    "services"  = { url = "serviceusage.googleapis.com" }
    "compute" = { url = "compute.googleapis.com" }
    "pub/sub" = { url = "pubsub.googleapis.com" }
    "secrets" = { url = "secretmanager.googleapis.com" }
  }

}

