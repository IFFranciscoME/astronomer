
// ---------------------------------------------------------------------------------- PUB-SUB -- //
// ---------------------------------------------------------------------------------- ------- -- //

resource "google_pubsub_topic" "progressions_topic" {
  name = "progressions-topic"
  schema_settings {
    schema = google_pubsub_schema.market_event_schema.id
    encoding = "JSON"
  }
}

resource "google_pubsub_schema" "market_event_schema" {

  name = "market-event-schema"
  type = "AVRO"

  definition = jsonencode({

    type = "record"
    name = "EnumMessage"
    
    fields = [
      {
        name = "eventType"
        type = {
          type = "enum"
          name = "EnumType"
          symbols = ["order_event", "trade_event"]
        }
      },
      {
        name = "eventContent"
        type = "string"
      }
    ]
  })

}

resource "google_pubsub_schema" "data_event_schema" {

  name = "data-event-schema"
  type = "AVRO"

  definition = jsonencode({

    type = "record"
    name = "EnumMessage"
    
    fields = [
      {
        name = "eventType"
        type = {
          type = "enum"
          name = "EnumType"
          symbols = ["write", "read"]
        }
      },
      {
        name = "eventContent"
        type = "string"
      }
    ]
  })

}

