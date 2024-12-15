
variable "pro_project_id" {
  type        = string
  description = "GCP Related: The whole project ID"
}

variable "pro_environment" {
  type        = string
  description = "a Tag to identify different environments to deploy"
  default     = "dev"
}

variable "pro_region" {
  description = "The GCP region where the SQL instance will be created"
  type        = string
}

variable "vpc_id" {
  description = "The fields for the VPC where the Data Platform operates"
  type        = string
}

