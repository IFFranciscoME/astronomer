
// ----------------------------------------------------------------------------------- PROJECT -- //
// ----------------------------------------------------------------------------------- ------- -- //

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
