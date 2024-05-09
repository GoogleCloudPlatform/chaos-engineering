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
resource "local_file" "client_startup" {
  
  filename = "${var.folder}/client_startup.sh"

  content  =  <<-EOT
    #!/bin/bash
    sudo mkdir -p ${var.operator_root}
    sudo chmod 777 ${var.operator_root}
    cd ${var.operator_root}
    sudo apt-get update
    sudo apt-get -y install curl git-all 
    curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
    git clone https://github.com/chaostoolkit-incubator/kubernetes-crd.git
    sudo apt-get install -y kubectl
    sudo apt --fix-broken install
    sudo apt-get install -y kubectl
    sudo apt-get install -y google-cloud-sdk-gke-gcloud-auth-plugin
    echo "done" > /opt/chaostoolkit/status
  EOT
}
