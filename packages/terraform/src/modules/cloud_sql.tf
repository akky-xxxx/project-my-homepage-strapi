resource "google_sql_database_instance" "db_instance-strapi" {
  name             = "strapi-db-instance-${var.random_id}"
  region           = "us-central1"
  database_version = var.cloud_sql_database_version

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "db-strapi" {
  name     = var.cloud_sql_database_name
  instance = google_sql_database_instance.db_instance-strapi.name
}

resource "google_sql_user" "users" {
  name     = var.cloud_sql_database_user_name
  password = var.cloud_sql_database_user_password
  instance = google_sql_database_instance.db_instance-strapi.name
}
