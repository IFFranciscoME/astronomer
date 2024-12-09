
locals {

  credentials = {
    type                        = "service_account"
    project_id                  = var.project_id
    private_key_id              = var.gcp_private_key_id
    private_key                 = var.gcp_private_key
    client_email                = var.gcp_client_email
    client_id                   = var.gcp_client_id
    auth_uri                    = var.gcp_auth_uri 
    token_uri                   = var.gcp_token_uri
    auth_provider_x509_cert_url = var.gcp_auth_provider
    client_x509_cert_url        = var.gcp_client_cert_url
  }

}

