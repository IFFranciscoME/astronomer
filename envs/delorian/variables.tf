
// ---------------------------------------------------------------------------------- PROJECT -- //
// ---------------------------------------------------------------------------------- ------- -- //

variable "pro_region" {
  type        = string
  description = "The region to deploy resources, as specified by the Cloud Provider"
  default     = "us-central1"
}

variable "pro_zone" {
  type        = string
  description = "The zone within the region to deploy resources, as specified by the Cloud Provider"
  default     = "us-central1-a"
}

variable "pro_environment" {
  type        = string
  description = "a Tag to identify different environments to deploy"
  default     = "dev"
}

variable "pro_project_id" {
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

// --------------------------------------------------------------------------------- DATABASE -- //
// --------------------------------------------------------------------------------- -------- -- //

variable "dbm_instance_name" {
  type        = string
  description = "The name of the database instance"
}

variable "dbm_name" {
  type        = string
  description = "the name of a database"
}

variable "dbm_schema" {
  description = "The schema of the database"
  type        = string
}

variable "dbm_instance_tier" {
  type        = string
  description = "the type of compute instance for the database"
}

variable "dbm_engine_version" {
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

variable "gcp_client_email" {}

