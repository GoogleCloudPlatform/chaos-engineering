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
#
# Important: 
#   When you modify the code under ../cloudruncode/ folder, please switch the version to enable
#   the build.
#
locals {
   version = "latest"
   #version = random_string.version.result 
}

resource "random_string" "version" {
  length  = 6
  special = false
}


resource "null_resource" "build" {
  triggers = {
    # Only turn on this when you modify ../cloudruncode/* files.
    always_run = local.version 
  }
  provisioner "local-exec" {
    command = <<-EOT
        cd ../cloudruncode
        gcloud builds submit --tag=gcr.io/${var.project_id}/simple-pbr-app:${local.version} \
          --service-account=projects/${var.project_id}/serviceAccounts/${var.tf_service_account} \
          --default-buckets-behavior=regional-user-owned-bucket
      EOT
  }

  depends_on = [
     google_sql_database_instance.cloudsql,
  ]
}


resource "google_cloud_run_service" "simple_web_app" {
  name     = "simple-pbr-app"
  location = var.region

  template {
    metadata {
      annotations = {
          "run.googleapis.com/vpc-access-egress"    = "private-ranges-only" 
          "run.googleapis.com/vpc-access-connector" = google_vpc_access_connector.vpccon.name
      }
    }
    spec {
      containers {
        image = "gcr.io/${var.project_id}/simple-pbr-app:${local.version}"
        env {
           name = "db_host"
           value = google_sql_database_instance.cloudsql.dns_name
        }
        env {
           name = "project_id"
           value = var.project_id
        }
      }
      service_account_name = local.sa_email
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [
     null_resource.build,
     google_sql_user.users
  ]
}

#  --allow-unauthenticated
resource "google_cloud_run_service_iam_binding" "test" {
  location = google_cloud_run_service.simple_web_app.location
  service  = google_cloud_run_service.simple_web_app.name
  role     = "roles/run.invoker"
  members = [
    "allUsers",
    local.sa_member
  ]
}
