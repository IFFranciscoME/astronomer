
// ---------------------------------------------------------------------------------- PUB-SUB -- //
// ---------------------------------------------------------------------------------- ------- -- //

resource "google_pubsub_schema" "progressions_schema" {

  name = "progression-schema"
  type = "PROTOCOL-BUFFER"
  definition = "syntax = \"proto3\";\nmessage Results {\nstring message_request = 1;\nstring message_response = 2;\nstring timestamp_request = 3;\nstring timestamp_response = 4;\n}"

}

resource "google_pubsub_topic" "progressions_topic" {
  
  name = "progressions-topic"
  project = var.project_id
  depends_on = [google_pubsub_schema.progressions_schema]
  schema_settings {
    schema = "projects/my-project-name/schemas/example"
    encoding = "JSON"
  }

}

// ----------------------------------------------------------------------------- RUN-FUNCTION -- //
// ----------------------------------------------------------------------------- ------------ -- //

resource "google_cloudfunctions2_function" "producer_function" {
  name        = "producer-triggered-function"
  location    = "us-central1"
  description = "Function triggered by Pub/Sub messages"

  build_config {
    runtime     = "python311"
    entry_point = "process_pubsub_message"
    source {
      storage_source {
        bucket = google_storage_bucket.function_bucket.name
        object = google_storage_bucket_object.function_zip.name
      }
    }
  }

  service_config {
    max_instance_count = 1
    available_memory   = "256M"
    timeout_seconds    = 60
  }

  event_trigger {
    trigger_region = "us-central1"
    event_type     = "google.cloud.pubsub.topic.v1.messagePublished"
    pubsub_topic   = "projects/${var.project_id}/topics/${var.pubsub_topic_name}"
    retry_policy   = "RETRY_POLICY_RETRY"
  }

}

