
// ---------------------------------------------------------------------------------- GENERAL -- //
// ---------------------------------------------------------------------------------- ------- -- //

variable "region" {
  type        = string
  description = "The region to deploy resources, as specified by the Cloud Provider"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "The zone within the region to deploy resources, as specified by the Cloud Provider"
  default     = "us-central1-a"
}

variable "environment" {
  type        = string
  description = "a Tag to identify different environments to deploy"
  default     = "dev"
}

variable "project_id" {
  type        = string
  description = "GCP Related: The whole project ID"
}

// ------------------------------------------------------------------------------- NETWORKING -- //
// ------------------------------------------------------------------------------- ---------- -- //

variable "vpc_id" {
  description = "ID for the VPC to be used"
  type        = string
}

variable "vpc_routing_mode" {
  description = "config for the dynamic routing mode"
  type        = string
}

variable "vpc_dl_subnet_ipv4" {
  description = ""
  type        = string
}

variable "vpc_dl_subnet_ipv6" {
  description = ""
  type        = string
}

variable "vpc_dw_subnet_ipv4" {
  description = ""
  type        = string
}

variable "vpc_dw_subnet_ipv6" {
  description = ""
  type        = string
}

// --------------------------------------------------------------------------------- DATABASE -- //
// --------------------------------------------------------------------------------- -------- -- //

variable "db_instance_name" {
  type        = string
  description = "The name of the database instance"
}

variable "db_name" {
  type        = string
  description = "the name of a database"
}

variable "db_schema" {
  description = "The schema of the database"
  type        = string
}

variable "db_instance_tier" {
  type        = string
  description = "the type of compute instance for the database"
}

variable "db_engine_version" {
  type        = string
  description = "the database's engine version"
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

// ------------------------------------------------------------------------------- CREDENTIALS -- //
// ------------------------------------------------------------------------------- ----------- -- //

variable "gcp_credentials" {}

variable "gcp_private_key_id" {}
variable "gcp_private_key" {}
variable "gcp_client_email" {}
variable "gcp_client_id" {}
variable "gcp_client_cert_url" {}
variable "gcp_auth_provider" {}
variable "gcp_token_uri" {}
variable "gcp_auth_uri" {}
