
// ---------------------------------------------------------------------------------- DB ADMIN -- //
// ---------------------------------------------------------------------------------- -------- -- //

resource "google_sql_user" "iam_service_account_user" {
  instance   = var.dbm_instance_name
  type       = "CLOUD_IAM_SERVICE_ACCOUNT"
  name       = trimsuffix(var.gcp_account_email, ".gserviceaccount.com")
}

// ------------------------------------------------------------------------ DB INSTANCE USERS -- //
// ------------------------------------------------------------------------ ----------------- -- //

locals {
  users = {
    "c_dev_r_01"  = { env = "dev" }
    "c_dev_rw_02" = { env = "dev" }
    "h_dev_r_01"  = { env = "dev" }
    "h_dev_rw_02" = { env = "dev" }
  }
}

resource "google_sql_user" "users" {
  instance = var.dbm_instance_name
  
  for_each = local.users
  name     = each.key
  password = random_password.user_passwords[each.key].result
  type     = "BUILT_IN"
}

resource "random_password" "user_passwords" {
  for_each = local.users

  length      = 15
  special     = true
  min_special = 2
  numeric     = true
  min_numeric = 2
  lower       = true
  min_lower   = 2
  upper       = true
  min_upper   = 2
  override_special = "!@#$%^&*()_+"
}

resource "google_secret_manager_secret" "user_credentials" {
  for_each = local.users

  secret_id = "sql-user-${each.key}"
  
  labels = {
      label = "db_users-${var.dbm_name}"
    }

    replication {
      user_managed {
        replicas {
          location = var.pro_region
        }
      }
    }
}

resource "google_secret_manager_secret_version" "user_credentials" {
  for_each = local.users
  secret      = google_secret_manager_secret.user_credentials[each.key].id
  secret_data = jsonencode({
    username = each.key
    password = random_password.user_passwords[each.key].result
  })
}

