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
### PubSub Topic ######
resource "google_pubsub_topic" "hellopsc" {
  name                       = "hellopsc"
  project                    = var.project_id
  message_retention_duration = "86600s"

  depends_on = [
    google_project_service.enable_apis
  ]
}



