resource "google_cloud_run_service" "strapi" {
  name     = var.cloud_run_service_name
  location = "asia-northeast1"

  template {
    spec {
      container_concurrency = var.cloud_run_container_concurrency

      containers {
        image = var.cloud_run_image_name

        resources {
          limits = {
            memory = var.cloud_run_memory
            cpu : var.cloud_run_cpu
          }
        }

        env {
          name  = "APP_KEYS"
          value = var.cloud_run_api_keys
        }

        env {
          name  = "JWT_SECRET"
          value = var.cloud_run_jwt_secret
        }

        env {
          name  = "API_TOKEN_SALT"
          value = var.cloud_run_api_token_salt
        }

        env {
          name  = "ADMIN_JWT_SECRET"
          value = var.cloud_run_admin_jwt_secret
        }

        env {
          name  = "CLOUD_STORAGE_BUCKET_NAME"
          value = google_storage_bucket.strapi.name
        }

        env {
          name  = "CLOUD_SQL_SOCKET"
          value = "/cloudsql/${google_sql_database_instance.db_instance-strapi.connection_name}"
        }

        env {
          name  = "CLOUD_SQL_NAME"
          value = google_sql_database.db-strapi.name
        }

        env {
          name  = "CLOUD_SQL_USERNAME"
          value = google_sql_user.users.name
        }

        env {
          name  = "CLOUD_SQL_PASSWORD"
          value = google_sql_user.users.password
        }
      }
    }

    metadata {
      annotations = {
        "run.googleapis.com/cloudsql-instances" = google_sql_database_instance.db_instance-strapi.connection_name
        "run.googleapis.com/client-name"        = "terraform"
      }
    }
  }
}

resource "google_cloud_run_service_iam_policy" "no_auth-strapi" {
  location = google_cloud_run_service.strapi.location
  project  = google_cloud_run_service.strapi.project
  service  = google_cloud_run_service.strapi.name

  policy_data = data.google_iam_policy.no_auth.policy_data
}
