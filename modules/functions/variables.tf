
variable "prj_project_id" {
  type        = string
  description = "GCP Related: The whole project ID"
}

variable "prj_region" {
  description = "The GCP region where the SQL instance will be created"
  type        = string
}

variable "prj_environment" {
  type        = string
  description = "a Tag to identify different environments to deploy"
}

