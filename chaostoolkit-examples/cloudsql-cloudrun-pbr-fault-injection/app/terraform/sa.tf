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
locals {

  chaos_service_account_perms = [
    "roles/run.invoker", 
    "roles/dns.admin",
    "roles/compute.instanceAdmin.v1", 
    "roles/secretmanager.secretAccessor",
    "roles/cloudsql.client" 
  ]
  
  sa_member = google_service_account.app_service_account.member
  sa_email  = google_service_account.app_service_account.email 
}

resource "google_service_account" "app_service_account" {
  account_id   = "app-cloudsql-pbr-sa"
  display_name = "Cloud Run App with cloud SQL Service Account"
  
  depends_on = [
     google_project_service.enabled_apis
  ]
}

resource "google_project_iam_member" "project" {
  for_each = toset(local.chaos_service_account_perms)
  project  = google_sql_database_instance.cloudsql.project
  member   = local.sa_member
  role     = each.value
}
