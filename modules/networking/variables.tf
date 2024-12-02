
variable "vpc_id" {
  description = "the ID of the VPC to use for the data-platform resources"
  type        = string 
}

variable "vpc_routing_mode" {
  description = "config for the dynamic routing mode"
  type        = string
}

variable "vpc_dl_subnet_ipv4" {
  description = ""
  type = string
}

variable "vpc_dl_subnet_ipv6" {
  description = ""
  type = string
}

variable "vpc_dw_subnet_ipv4" {
  description = ""
  type = string
}

variable "vpc_dw_subnet_ipv6" {
  description = ""
  type = string
}

variable "region" {
  description = "The GCP region where the SQL instance will be created"
  type        = string
}

variable "environment" {
  type        = string
  description = "a Tag to identify different environments to deploy"
  default     = "dev"
}

