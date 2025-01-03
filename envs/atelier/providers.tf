
terraform {

  cloud {
    organization = "iteralabs"
    workspaces { name = "dev" }
  }

  required_providers {

    google = {
      source  = "hashicorp/google"
      version = "~> 6.12.0"
    }

  }

  required_version = ">= 1.0"
}

provider "google" {

  project     = var.prj_project_id
  region      = var.prj_region
  credentials = var.account_credentials

}

