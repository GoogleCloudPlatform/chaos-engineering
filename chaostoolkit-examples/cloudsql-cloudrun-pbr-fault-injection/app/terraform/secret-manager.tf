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
   secret_ids = [
      google_secret_manager_secret.db-password.secret_id,
      google_secret_manager_secret.db-user.secret_id
   ]
}
resource "google_secret_manager_secret_iam_member" "member" {
  for_each = toset(local.secret_ids)
  project = var.project_id
  secret_id = each.value
  role = "roles/secretmanager.secretAccessor"
  member = local.sa_member
}

resource "google_secret_manager_secret" "db-password" {
  secret_id = "db-password-pbr"
  
  replication {
    auto {}
  }

  depends_on = [
     google_project_service.enabled_apis
  ]
}

resource "google_secret_manager_secret_version" "secret-db-password-version" {
  secret = google_secret_manager_secret.db-password.id

  secret_data = local.pass 
}

resource "google_secret_manager_secret" "db-user" {
  secret_id = "db-user-pbr"
  
  replication {
    auto {}
  }

  depends_on = [
     google_project_service.enabled_apis
  ]
}

resource "google_secret_manager_secret_version" "secret-db-user-version" {
  secret = google_secret_manager_secret.db-user.id

  secret_data = local.user 
}
