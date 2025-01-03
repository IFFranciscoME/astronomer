
// ----------------------------------------------------------------------------------- PROJECT -- //
// ----------------------------------------------------------------------------------- ------- -- //

variable "prj_platform" {
  type        = string
  description = "Cloud services platform to use (gcp, aws, ...)"
  default     = "gcp"
}

variable "prj_region" {
  type        = string
  description = "The region to deploy resources, as specified by the Cloud Provider"
  default     = "us-central1"
}

variable "prj_environment" {
  type        = string
  description = "a Tag to identify different environments to deploy"
  default     = "dev"
}

variable "prj_project_id" {
  type        = string
  description = "GCP Related: The whole project ID"
}

// ------------------------------------------------------------------------------------- ROLES -- //
// ------------------------------------------------------------------------------------- ----- -- //



// -------------------------------------------------------------------------------- NETWORKING -- //
// -------------------------------------------------------------------------------- ---------- -- //

variable "vpc_id" {
  description = "ID for the VPC to be used"
  type        = string
}

variable "vpc_routing_mode" {
  description = "config for the dynamic routing mode"
  type        = string
}

variable "vpc_name" {
  description = "The given name for the VPC to be created"
  type        = string
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

// ----------------------------------------------------------------------------------- COMPUTE -- //
// ----------------------------------------------------------------------------------- ------- -- //

variable "cmp_instance_type" {
  type        = string
  description = "The compute instance type to be use"
  default     = "e2-small"
}

variable "cmp_instance_name" {
  type        = string
  description = "The compute instance name to asign"
}

variable "cmp_instance_image" {
  description = "The source image to use"
  type        = string
}

// ------------------------------------------------------------------------------- CREDENTIALS -- //
// ------------------------------------------------------------------------------- ----------- -- //

variable "account_email" {}
variable "account_credentials" {}

variable "TF_VAR_account_email" {}
variable "TF_VAR_account_credentials" {}
