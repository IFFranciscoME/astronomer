
// ---------------------------------------------------------------------------------- PUB-SUB -- //
// ---------------------------------------------------------------------------------- ------- -- //

resource "google_pubsub_topic" "progressions_topic" {
  name = "progressions-topic"
  schema_settings {
    schema = google_pubsub_schema.enum_schema.id
    encoding = "JSON"
  }
}

resource "google_pubsub_schema" "enum_schema" {

  name = "enum-schema"
  type = "AVRO"

  definition = jsonencode({
    type = "record"
    name = "EnumMessage"
    fields = [
      {
        name = "enumField"
        type = {
          type = "enum"
          name = "EnumType"
          symbols = ["RED", "GREEN", "BLUE"]
        }
      },
      {
        name = "value"
        type = "string"
      }
    ]
  })

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
      }
    }
  }
}

// ---------------------------------------------------------------------------- CREATE TABLES -- //
// ---------------------------------------------------------------------------- ------------- -- //


