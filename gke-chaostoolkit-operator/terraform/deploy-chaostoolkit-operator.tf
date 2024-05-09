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
resource "local_file" "switch_to_standard" {
  
  filename = "${var.folder}/switch-to-standard.sh"

  content  =  <<-EOT
    #!/bin/bash
    gcloud container clusters get-credentials ${local.cluster_name} --zone=${var.zone} --project=${var.project_id}
  EOT

  depends_on = [module.gke]

}

resource "local_file" "deploy" {
  
  filename = "${var.folder}/deploy-operator.sh"

  content  =  <<-EOT
    #!/bin/bash
    while ! [ -f "${var.operator_root}/status" ]; do
       echo "Directory does not exist."
       sleep 1
    done
    cd ${var.operator_root}
    ./kustomize build . | kubectl apply -f -
  EOT

  depends_on = [module.gke]

}

resource "local_file" "switch_to_autopilot" {
  
  filename = "${var.folder}/switch-to-autopilot.sh"

  content  =  <<-EOT
    #!/bin/bash
    gcloud container clusters get-credentials ${local.autopilot} --region=${var.region} --project=${var.project_id}
  EOT

  depends_on = [module.autopilot]

}

resource "local_file" "copy_command" {

  filename = "${var.folder}/copy_command.sh"
  
  content  = <<-EOT
    #!/bin/bash
    for i in {0..10}
    do
      gcloud compute scp --zone "${local.zone}" ${var.folder}/deploy-to-autopilot.sh "${local.name}:~"  --tunnel-through-iap --project "${var.project_id}"
      if [ $? -eq 0 ]; then  
        break
      fi
      sleep 2
    done
    gcloud compute scp --zone "${local.zone}" ${var.folder}/deploy-operator.sh     "${local.name}:~"  --tunnel-through-iap --project "${var.project_id}"
    gcloud compute scp --zone "${local.zone}" ${var.folder}/switch-to-autopilot.sh "${local.name}:~"  --tunnel-through-iap --project "${var.project_id}"
    gcloud compute scp --zone "${local.zone}" ${var.folder}/switch-to-standard.sh  "${local.name}:~"  --tunnel-through-iap --project "${var.project_id}"
    gcloud compute scp --zone "${local.zone}" ${var.folder}/kubectl_desc.sh        "${local.name}:~"  --tunnel-through-iap --project "${var.project_id}"
    gcloud compute scp --zone "${local.zone}" ${var.folder}/kubectl_get.sh         "${local.name}:~"  --tunnel-through-iap --project "${var.project_id}"
    gcloud compute scp --zone "${local.zone}" ${var.folder}/kubectl_logs.sh        "${local.name}:~"  --tunnel-through-iap --project "${var.project_id}"
    gcloud compute scp --zone "${local.zone}" ../kustomization/*                   "${local.name}:${var.operator_root}"  --tunnel-through-iap --project "${var.project_id}"
  EOT

  depends_on = [
     local_file.deploy
  ]

}

resource "local_file" "deploy_to_standard" {

  filename = "${var.folder}/deploy-to-standard.sh"
  
  content  = <<-EOT
    #!/bin/bash
    gcloud compute ssh --zone "${local.zone}"  "${local.name}"  --tunnel-through-iap --project "${var.project_id}" --command "./switch-to-standard.sh; ./deploy-operator.sh; "
  EOT

  depends_on = [
     local_file.switch_to_standard,
     local_file.deploy
  ]

}

resource "local_file" "deploy_to_autopilot" {

  filename = "${var.folder}/deploy-to-autopilot.sh"
  
  content  = <<-EOT
    #!/bin/bash
    gcloud compute ssh --zone "${local.zone}"  "${local.name}"  --tunnel-through-iap --project "${var.project_id}" --command "./switch-to-autopilot.sh; ./deploy-operator.sh; "
  EOT

  depends_on = [
     local_file.switch_to_autopilot,
     local_file.deploy
  ]

}

resource "null_resource" "run_copy_files" {
  triggers = {
    #always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = local_file.copy_command.filename
  }
  depends_on = [
     module.gke,
     module.autopilot,
     google_compute_instance.gke-client, 
     local_file.copy_command,
     local_file.get_command,
     local_file.desc_command,
     local_file.logs_command     
  ]
}

resource "null_resource" "run_deploy" {
  triggers = {
    #always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = local_file.deploy_to_standard.filename
  }
  depends_on = [
     null_resource.run_copy_files     
  ]
}
