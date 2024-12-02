
// --------------------------------------------------------------------- SQL MANAGED INSTANCE -- //
// --------------------------------------------------------------------- -------------------- -- //

resource "google_sql_database_instance" "db_data_lake_instance" {
  name             = var.db_instance_name
  database_version = var.db_engine_version 
  region           = var.region

  settings {
    tier = var.db_instance_tier
    
    ip_configuration {
      ipv4_enabled   = false
      private_network = var.vpc_id
    }

    database_flags {
      name  = "password_encryption"
      value = "scram-sha-256"
    }

    password_validation_policy {
      min_length                  = 15
      complexity                  = "COMPLEXITY_DEFAULT"
      reuse_interval              = 2
      disallow_username_substring = true
      password_change_interval    = "30s"
      enable_password_policy      = true
    }
  }
}

// -------------------------------------------------------------------------------- DATA BASE -- //
// -------------------------------------------------------------------------------- --------- -- //

resource "google_sql_database" "db_data_lake" {
  name     = var.db_name
  instance = google_sql_database_instance.db_data_lake_instance.name
}

// ------------------------------------------------------------------------------ DATA TABLES -- //
// ------------------------------------------------------------------------------ ----------- -- //

resource "google_sql_database" "tables" {
  
  for_each = { for table in local.database_schema.tables : table.name => table }
  name     = each.key
  instance = var.db_name

  provisioner "local-exec" {
    command = <<-EOT
      python3 /scripts/create_table.py \
        ${var.db_instance_name} \
        ${var.db_name} \
        ${each.key} \
        '${jsonencode(each.value.columns)}'
    EOT
  }

  depends_on = [
    google_sql_database_instance.db_data_lake_instance,
    google_sql_database.db_data_lake
  ]

}
