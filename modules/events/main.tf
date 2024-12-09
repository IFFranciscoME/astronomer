
// ---------------------------------------------------------------------------------- PUB-SUB -- //
// ---------------------------------------------------------------------------------- ------- -- //

resource "google_pubsub_topic" "progressions_topic" {
  name = "progressions-topic"
}

// ----------------------------------------------------------------------------- RUN-FUNCTION -- //
// ----------------------------------------------------------------------------- ------------ -- //

resource "google_cloud_run_v2_job" "consumer_function" {
  name     = "consumer-function"
  location = var.region
  deletion_protection = false

  template {
    template {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/job"
        // image = "gcr.io/${var.project_id}/subscriber:latest"
      }
    }
  }
}

