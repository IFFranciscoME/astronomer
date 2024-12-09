
terraform {
  cloud {
    organization = "iteralabs"
    
    workspaces {
      name = "dev"
    }
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.12.0"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "~> 1.24"
    }
  }

  required_version = ">= 1.0"
}

provider "google" {

  project = var.project_id
  region  = var.region
  credentials = var.gcp_credentials

}

