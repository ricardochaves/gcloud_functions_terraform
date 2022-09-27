
resource "google_pubsub_topic" "pubsub_topic" {
  name = "start-functions"

  labels = {
    project = var.project
  }

  message_retention_duration = "86600s"
}