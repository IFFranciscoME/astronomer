
variable "prj_project_id" {
  description = "GCP Project ID"
}

variable "prj_region" {
  description = "The region to deploy to"
  default     = "us-central1"
}

variable "prj_zone" {
  description = "The zone to deploy the instance"
  default     = "us-central1-a"
}

variable "cmp_instance_type" {
  description = "The instance type for the server"
  type        = string
  default     = "e2-small"
}

variable "cmp_instance_name" {
  description = "The instance name for the server"
  type        = string
  default     = "progression_server"
}

variable "cmp_instance_image" {
  description = "The source image to use"
  default     = "projects/debian-cloud/global/images/family/debian-10"
}

