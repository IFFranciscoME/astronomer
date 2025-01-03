
variable "prj_environment" {
  type        = string
  description = "a Tag to identify different environments to deploy"
}

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
}

variable "cmp_instance_image" {
  description = "The source image to use"
  type        = string
}

variable "cmp_subnet_id"  {
  description = "The ID of the subnet where the server operates"
  type = string
}

variable "cmp_instance_ssh" {
  description = "SSH keys for connectivity (test purposes only)"
  type = string
}

