
output "dbm_instance_name" {
  value = google_sql_database_instance.dbm_data_lake_instance.name
}

output "dbm_name" {
  value = google_sql_database.dbm_data_lake.name
}

output "dbm_schema" {
  value = var.dbm_schema
}

