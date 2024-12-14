
resource "google_compute_instance" "progressions" {
  project      = var.project_id
  zone         = var.zone
  name         = var.cmp_instance_name
  machine_type = var.cmp_instance_type

  boot_disk {
    initialize_params {
      image = var.cmp_instance_image
      size = 20
      type = "pd-ssd"
    }
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  tags = ["http-server", "https-server"]

  metadata = {
      startup-script = file("${path.module}/scripts/start_progressions_server.sh")
      ssh-keys       = "root:${file("${var.public_key_path}")}"
    }

  service_account {
    email  = var.gcp_client_email
    scopes = [
        "https://www.googleapis.com/auth/compute.readonly",
    ]
  }

  depends_on = [google_compute_address.static]

}

// ----------------------------------------------------- CLOUD RUN: TABLES CREATION -- //
// ----------------------------------------------------- -------------------------- -- //

resource "google_cloud_run_service" "create_table_function" {
  
  name     = "create-table-function"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/create-table-function"
        env {
          name  = "INSTANCE_CONNECTION_NAME"
          value = google_sql_database_instance.postgres_instance.connection_name
        }
        env {
          name  = "DB_NAME"
          value = var.db_name
        }
        env {
          name  = "TABLE_SCHEMA_FILE"
          value = "/etc/secrets/table_schema.json"
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# IAM roles for Cloud Run service account
resource "google_project_iam_member" "cloudsql_client" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_cloud_run_service.create_table_function.template[0].spec[0].service_account_name}"
}

resource "google_project_iam_member" "cloudsql_instance_user" {
  project = var.project_id
  role    = "roles/cloudsql.instanceUser"
  member  = "serviceAccount:${google_cloud_run_service.create_table_function.template[0].spec[0].service_account_name}"
}

