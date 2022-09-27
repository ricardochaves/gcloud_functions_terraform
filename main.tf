provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
  credentials = file("SANDBOX-363623-0810979e1116.json")
}
