#
# Copyright 2024 Google LLC
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
  enable_apis = [
    "compute.googleapis.com", 
    "iam.googleapis.com"
  ]
}

resource "google_project_service" "enable_apis" {
  for_each = toset(local.enable_apis)
  project = var.project_id
  service = each.value

  timeouts {
    create = "20m"
    update = "20m"
  }
  disable_on_destroy         = false 
  disable_dependent_services = false  
}
