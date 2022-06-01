terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

resource "random_id" "id" {
  byte_length = 4
}

provider "google" {
  credentials = file(var.project.credentials)
  project     = lookup(var.project, "project_id")
  region      = "us-central1"
  zone        = "us-central1-c"
}

module "modules" {
  source = "../../modules"

  random_id = random_id.id.hex

  # cloud run
  cloud_run_service_name          = "${lookup(var.run_strapi, "name")}-dev"
  cloud_run_container_concurrency = "10"
  cloud_run_image_name            = lookup(var.run_strapi, "registry")
  cloud_run_memory                = "16Gi"
  cloud_run_cpu                   = "4000m"
  cloud_run_api_keys              = lookup(var.run_strapi, "app_keys")
  cloud_run_jwt_secret            = lookup(var.run_strapi, "jwt_secret")
  cloud_run_api_token_salt        = lookup(var.run_strapi, "api_token_salt")
  cloud_run_admin_jwt_secret      = lookup(var.run_strapi, "admin_jwt_secret")

  # cloud storage
  cloud_storage_bucket_name = "${lookup(var.storage_strapi, "name")}-dev"

  # cloud sql
  cloud_sql_database_version       = lookup(var.db_strapi, "version")
  cloud_sql_database_name          = "${lookup(var.db_strapi, "name")}-dev"
  cloud_sql_database_user_name     = "${lookup(var.db_strapi, "user")}-dev"
  cloud_sql_database_user_password = lookup(var.db_strapi, "pass")
}
