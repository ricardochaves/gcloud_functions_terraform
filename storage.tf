
resource "random_id" "server" {
  byte_length = 8
}

resource "google_storage_bucket" "bucket" {
  name     = "code-${random_id.server.hex}"
  location = var.location
  storage_class = "REGIONAL"

  labels = {
    project = var.project
  }
}

data "archive_file" "lambdazip" {
  type        = "zip"
  output_path = "./source/Archive.zip"

  source_dir = "./source"
}

resource "google_storage_bucket_object" "archive" {
  name   = "Archive.zip"
  bucket = google_storage_bucket.bucket.name
  source = "./source/Archive.zip"
  depends_on = [
    data.archive_file.lambdazip
  ]
}