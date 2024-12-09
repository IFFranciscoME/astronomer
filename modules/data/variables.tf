
variable "vpc_id" {
  description = "The fields for the VPC where the Data Platform operates"
  type        = string
}

variable "region" {
  description = "The GCP region where the SQL instance will be created"
  type        = string
}

variable "zone" {
  description = "The GCP zone according to the region"
  type        = string
}

variable "environment" {
  description = "The cloud environment where everything is run"
}

variable "db_instance_name" {
  description = "The name of the SQL instance"
  type        = string
}

variable "db_engine_version" {
  description = "The version of the SQL engine"
  type        = string
}

variable "db_instance_tier" {
  type        = string
  description = "the type of compute instance for a db"
}

variable "db_name" {
  description = "The name of the PostgreSQL database"
  type        = string
}

variable "db_schema" {
  description = "The schema of the PostgreSQL database"
  type        = string
}

locals {
  
  database_schema = {
    tables = [
      { name = "exchanges", },
      { name = "markets", },
      { name = "agents", },
      { name = "order-events", },
      { name = "orderbooks", },
      { name = "trade-events", },
    ]
  }

  database_creator = "scripts/create_tables.py"

}

