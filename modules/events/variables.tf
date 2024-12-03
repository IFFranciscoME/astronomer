
variable "project_id" {
  type        = string
  description = "GCP Related: The whole project ID"
}

variable "environment" {
  type        = string
  description = "a Tag to identify different environments to deploy"
  default     = "dev"
}

variable "region" {
  description = "The GCP region where the SQL instance will be created"
  type        = string
}

