
// ---------------------------------------------------------------------- DB ADMIN -- //
// ---------------------------------------------------------------------- -------- -- //

resource "google_project_service" "sqladmin_api" {
  project = var.project_id
  service = "sqladmin.googleapis.com"

  disable_on_destroy = true
}

resource "google_project_service" "servicenetworking_api" {
  project = var.project_id
  service = "servicenetworking.googleapis.com"

  disable_on_destroy = true
}

