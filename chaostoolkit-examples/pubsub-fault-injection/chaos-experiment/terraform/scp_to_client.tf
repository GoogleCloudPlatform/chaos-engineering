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
resource "time_sleep" "wait_60_seconds" {
  create_duration = "60s"
  depends_on = [
    google_compute_instance.pubsubtestclient
  ]
}
resource "local_file" "scp_command" {

  filename = "${var.folder}/copy_to_client.sh"

  content = <<-EOT
    #!/bin/bash
    cd  ${abspath(path.module)}/../../chaos-experiment/config
    for i in {0..10}
    do
      gcloud compute scp --zone "${local.zone}" experiment*.json  "${local.name}:~"  --tunnel-through-iap --project "${var.project_id}"
      if [ $? -eq 0 ]; then  
        break
      fi
      sleep 2
    done
    gcloud compute scp --zone "${local.zone}" ${var.folder}/variables.env  "${local.name}:~"  --tunnel-through-iap --project "${var.project_id}"
    gcloud compute scp --zone "${local.zone}" ../scripts/run*.sh  "${local.name}:~"  --tunnel-through-iap --project "${var.project_id}"
  EOT

}

resource "terraform_data" "scp_files" {
  provisioner "local-exec" {
    command = local_file.scp_command.filename
  }
  depends_on = [
    google_compute_instance.pubsubtestclient,
    local_file.scp_command,
    local_file.variable_config,
    resource.time_sleep.wait_60_seconds

  ]
}
