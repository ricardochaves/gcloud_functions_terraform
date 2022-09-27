
resource "google_secret_manager_secret" "secret-basic" {
  secret_id = "MONGO_CONNECTION_STRING"

  labels = {
    project = var.project
  }

  replication {
    automatic = true
  }
}


resource "google_secret_manager_secret_version" "secret-version-basic" {
  secret = google_secret_manager_secret.secret-basic.id

  secret_data = "YOUR_SECRET_VALUE"
}

resource "google_project_iam_member" "function_sa_secret_binding" {
  project = var.project_id
  member  = "serviceAccount:${google_service_account.fundos_service_account.email}"
  role    = "roles/secretmanager.secretAccessor"

  condition {
    title       = "restricted_to_secret"
    description = "Allows access only to the desired secret"
    expression  = "resource.name.startsWith(\"${google_secret_manager_secret.secret-basic.name}\")"
  }
}

resource "google_secret_manager_secret_iam_member" "member" {
  project = google_secret_manager_secret.secret-basic.project
  secret_id = google_secret_manager_secret.secret-basic.secret_id
  role = "roles/secretmanager.secretAccessor"
  member = "serviceAccount:${google_service_account.fundos_service_account.email}"
}