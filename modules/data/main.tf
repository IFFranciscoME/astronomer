
// --------------------------------------------------------------------- SQL MANAGED INSTANCE -- //
// --------------------------------------------------------------------- -------------------- -- //

resource "google_sql_database_instance" "dbm_data_lake_instance" {
  name             = var.dbm_instance_name
  database_version = var.dbm_engine_version 
  region           = var.pro_region

  settings {
    tier = var.dbm_instance_tier
    
    ip_configuration {
      ipv4_enabled   = false
      private_network = var.vpc_id
    }

    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "on"
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

  depends_on = [var.vpc_private_connection]

}

// -------------------------------------------------------------------------------- DATA BASE -- //
// -------------------------------------------------------------------------------- --------- -- //

resource "google_sql_database" "dbm_data_lake" {
  name     = var.dbm_name
  instance = google_sql_database_instance.dbm_data_lake_instance.name
  
}

