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
resource "local_file" "get_command" {

  filename = "${var.folder}/kubectl_get.sh"

  content  = <<-EOT
    kubectl -n chaostoolkit-run get pods 
    kubectl -n chaostoolkit-run get pod $(cut -c 1-25 <<< `kubectl -n chaostoolkit-run get pods | grep chaostoolkit`) -o json
  EOT
  
}
