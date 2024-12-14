
resource "google_project_service" "sqladmin_api" {
  project = var.pro_project_id
  service = "sqladmin.googleapis.com"

  disable_on_destroy = false
}

resource "google_project_service" "servicenetworking_api" {
  project = var.pro_project_id
  service = "servicenetworking.googleapis.com"

  disable_on_destroy = false
}

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

  depends_on = [var.private_vpc_connection,
                google_project_service.sqladmin_api,
                google_project_service.servicenetworking_api,
  ]

}

// -------------------------------------------------------------------------------- DATA BASE -- //
// -------------------------------------------------------------------------------- --------- -- //

resource "google_sql_database" "dbm_data_lake" {
  name     = var.dbm_name
  instance = google_sql_database_instance.dbm_data_lake_instance.name
}

// ------------------------------------------------------------------------ DB INSTANCE USERS -- //
// ------------------------------------------------------------------------ ----------------- -- //

resource "google_sql_user" "iam_group_user" {
  name     = trimsuffix(var.gcp_client_email, ".gserviceaccount.com")
  instance = google_sql_database_instance.dbm_data_lake_instance.name
  type     = "CLOUD_IAM_SERVICE_ACCOUNT"
  depends_on = [
    google_sql_database_instance.dbm_data_lake_instance,
    google_sql_database.dbm_data_lake,]
}

resource "google_project_iam_member" "cloudsql_admin" {
  project = var.pro_project_id
  role    = "roles/cloudsql.admin"
  member  = "serviceAccount:${trimsuffix(var.gcp_client_email, ".serviceaacount.com")}"
}

