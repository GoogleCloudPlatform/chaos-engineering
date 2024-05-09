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
    "roles/compute.instanceAdmin.v1", 
    "roles/compute.networkAdmin", 
    "roles/dns.admin",
    "roles/cloudsql.client" 
  ]
  
  sa_member = google_service_account.chaos_service_account.member
  sa_email  = google_service_account.chaos_service_account.email 
}

resource "google_service_account" "chaos_service_account" {
  account_id   = "chaos-cloudsql-dns-sa"
  display_name = "Chaos cloud SQL Service Account"
  
  depends_on = [
     google_project_service.enabled_apis
  ]
}

resource "google_project_iam_member" "project" {
  for_each = toset(local.chaos_service_account_perms)
  project = google_service_account.chaos_service_account.project
  member   = local.sa_member
  role     = each.value
}
