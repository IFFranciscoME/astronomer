output "credentials_json" {
 
  description = "the GCP credentials JSON"
  value       = jsonencode(local.credentials)
  sensitive   = false

}
