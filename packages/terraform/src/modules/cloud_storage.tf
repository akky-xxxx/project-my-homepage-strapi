resource "google_storage_bucket" "strapi" {
  name          = var.cloud_storage_bucket_name
  location      = "ASIA"
  force_destroy = true
}
