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

  zone = var.zone
  name = var.vm_name
}

resource "null_resource" "build" {
  triggers = {
    # Only turn on this when you modify ../cloudruncode/* files.
    #always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = <<-EOT
        cd ../docker
        gcloud builds submit --tag=gcr.io/${var.project_id}/chaostoolkit \
          --service-account=projects/${var.project_id}/serviceAccounts/${var.tf_service_account} \
          --default-buckets-behavior=regional-user-owned-bucket
      EOT
  }

}
