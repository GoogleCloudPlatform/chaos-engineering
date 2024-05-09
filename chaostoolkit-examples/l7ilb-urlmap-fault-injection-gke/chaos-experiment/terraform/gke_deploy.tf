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
resource "local_file" "deploy_command" {

  filename = "${var.folder}/gke_deploy.sh"
  
  content  = <<-EOT
    #!/bin/bash
    kubectl create serviceaccount l7b-ksa --namespace chaostoolkit-run
    gcloud iam service-accounts add-iam-policy-binding "${google_service_account.chaos_service_account.email}" \
        --role roles/iam.workloadIdentityUser \
        --member "serviceAccount:${var.project_id}.svc.id.goog[chaostoolkit-run/l7b-ksa]"
    kubectl annotate serviceaccount l7b-ksa \
        --namespace chaostoolkit-run \
        iam.gke.io/gcp-service-account="${google_service_account.chaos_service_account.email}" 
    kubectl delete -f experiment.yaml
    kubectl apply  -f experiment.yaml
  EOT
}

