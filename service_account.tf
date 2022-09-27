resource "random_string" "service_account" {
  length = 4
  special = false
  upper = false
  numeric = false
}

resource "google_service_account" "fundos_service_account" {
  account_id   = "process-data-account-${random_string.service_account.result}"
  display_name = "Process Data Service Account"
  description = "Service account used in process-data function"
  project = var.project_id
}

resource "google_service_account_iam_member" "opentok_webhook_mixer" {
  service_account_id = google_service_account.fundos_service_account.id
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${var.build_service_account_email}"
}

