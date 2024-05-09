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
resource "local_file" "remote_run" {

  filename = "${var.folder}/remote_run.sh"

  content  = <<-EOT
    gcloud compute ssh --zone "${google_compute_instance.proxyclient.zone}" \
     "${google_compute_instance.proxyclient.name}" \
      --tunnel-through-iap --project "${var.project_id}" --command "./run.sh"
  EOT
  
} 