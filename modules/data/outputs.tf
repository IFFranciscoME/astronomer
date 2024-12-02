
output "db_instance_name" {
  value = google_sql_database_instance.db_data_lake_instance.name
}

output "db_name" {
  value = google_sql_database.db_data_lake.name
}

output "db_schema" {
  value = var.db_schema
}

