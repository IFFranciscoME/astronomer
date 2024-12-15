variable "pro_environment" {
  description = "The cloud environment where everything is run"
}

variable "pro_project_id" {
  description = "The GCP Project"
  type        = string
}

variable "pro_region" {
  description = "The GCP region where the SQL instance will be created"
  type        = string
}

variable "dbm_instance_name" {
  description = "The name of the SQL instance"
  type        = string
}

variable "dbm_name" {
  description = "The name of the PostgreSQL database"
  type        = string
}

variable "gcp_account_email" {}

