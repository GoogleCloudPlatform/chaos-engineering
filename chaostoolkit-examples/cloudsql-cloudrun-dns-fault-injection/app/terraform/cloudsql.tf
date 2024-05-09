#
# Copyright 2023 Google LLC
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
##### Cloud SQL instance with Private Service Connect #######
resource "google_sql_database_instance" "cloudsql" {
  name             = "cloudsql"
  region           = var.region
  project          = var.project_id
  database_version = "MYSQL_8_0"
  settings {
    tier              = "db-f1-micro"
    availability_type = "ZONAL"
    backup_configuration {
      enabled            = false
      binary_log_enabled = false
    }
    location_preference {
      zone = var.zone
    }
    ip_configuration {
      psc_config {
        psc_enabled               = true
        allowed_consumer_projects = [var.project_id]
      }
      ipv4_enabled = false
    }
  }
  deletion_protection = false
  
  depends_on = [
     google_project_service.enabled_apis
  ]
}

data "google_sql_database_instance" "default" {
  project = var.project_id
  name    = google_sql_database_instance.cloudsql.name
}

locals {
  user    = random_string.user.result
  pass    = random_password.pwd.result
}

resource "google_sql_user" "users" {
  name     = local.user
  instance = google_sql_database_instance.cloudsql.name
  password = local.pass 
}

resource "random_string" "user" {
  length  = 16
  special = false
}

resource "random_password" "pwd" {
  length  = 16
  special = false
}
