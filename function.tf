
resource "google_cloudfunctions_function" "function" {
  name        = "process-data"
  description = "Download of CVM file and save data in MongoDB"
  runtime     = "python39"

  available_memory_mb   = 1024

  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name

  entry_point = "hello_pubsub"

  service_account_email = google_service_account.fundos_service_account.email

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.pubsub_topic.name
  }

  environment_variables = {
    MONGO_CONSULTATIONS_COLLECTION_NAME = "fundos_data"
    CVM_FILE_URL="http://dados.cvm.gov.br/dados/FI/DOC/INF_DIARIO/DADOS/"
  }

  secret_environment_variables {
    key = "MONGO_CONNECTION_STRING"
    secret = google_secret_manager_secret.secret-basic.secret_id
    version = "1"
  }

  labels = {
    project = var.project
  }

  depends_on = [
    google_service_account_iam_member.opentok_webhook_mixer
  ]
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "serviceAccount:${google_service_account.fundos_service_account.email}"
}
