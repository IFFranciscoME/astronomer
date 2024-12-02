
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

  credentials = jsonencode({
    type                        = "service_account"
    project_id                  = var.project_id
    private_key_id              = var.gcp_private_key_id
    private_key                 = var.gcp_private_key
    client_email                = var.gcp_client_email
    client_id                   = var.gcp_client_id
    auth_uri                    = "https://accounts.google.com/o/oauth2/auth"
    token_uri                   = "https://oauth2.googleapis.com/token"
    auth_provider_x509_cert_url = "https://www.googleapis.com/oauth2/v1/certs"
    client_x509_cert_url        = "https://www.googleapis.com/robot/v1/metadata/x509/${var.gcp_client_email}"
  })

}
