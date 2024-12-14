
variable "vpc_id" {
  description = "The fields for the VPC where the Data Platform operates"
  type        = string
}

variable "private_vpc_connection" {
  description = "The definition of the private VPC for cross communications"
}

variable "pro_region" {
  description = "The GCP region where the SQL instance will be created"
  type        = string
}

variable "pro_project_id" {
  type        = string
  description = "GCP Related: The whole project ID"
}

variable "pro_zone" {
  description = "The GCP zone according to the region"
  type        = string
}

variable "pro_environment" {
  description = "The cloud environment where everything is run"
}

variable "dbm_instance_name" {
  description = "The name of the SQL instance"
  type        = string
}

variable "dbm_engine_version" {
  description = "The version of the SQL engine"
  type        = string
}

variable "dbm_instance_tier" {
  type        = string
  description = "the type of compute instance for a db"
}

variable "dbm_name" {
  description = "The name of the PostgreSQL database"
  type        = string
}

variable "dbm_schema" {
  description = "The schema of the PostgreSQL database"
  type        = string
}

locals {
  
  database_schema = {
    tables = [
      { name = "order-events", },
      { name = "trade-events", },
      { name = "orderbooks", },
    ]
  }

  database_creator = "scripts/create_tables.py"

  database_admin = {
    users = [
      { name = "c_dev_r_01",  nat = "code", env = "dev", ops = "read", },
      { name = "c_dev_r_02",  nat = "code", env = "dev", ops = "read-write", },
    ]
  }

}

