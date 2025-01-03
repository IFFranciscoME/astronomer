
// -------------------------------------------------------------------------------- NETWORKING -- //
// -------------------------------------------------------------------------------- ---------- -- //

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

variable "firewall_name" { 
  description = "The given name for the firewall to be used within the VPC"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet to be used within the VPC"
  type        = string
}

variable "subnet_ipv4" {
  description = "the range of ipv4 ranges for the subnet to be used within the vpc"
  type        = string
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
  
  prj_platform = {
    "cloudresource" = { url = "cloudresourcemanager.googleapis.com" }
    "iam" = { url = "iamcredentials.googleapis.com" }
    "networking" = { url = "servicenetworking.googleapis.com" }
    "services"  = { url = "serviceusage.googleapis.com" }
    "compute" = { url = "compute.googleapis.com" }
  }

}

