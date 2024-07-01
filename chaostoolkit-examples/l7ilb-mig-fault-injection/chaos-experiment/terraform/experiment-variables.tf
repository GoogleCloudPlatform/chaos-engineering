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
resource "local_file" "variable_config" {

  filename = "${var.folder}/variables.env"
  
  content  = <<-EOT
    var_gcp_project_id=${var.project_id}
    var_gcp_region=${var.region}
    var_url_map_name=${var.url_map_name}
    var_url_map_target_name=${var.url_map_target_name}
    var_url_map_ip_address=${var.compute_ip_address}
    var_gcp_zone=${split("/", data.google_compute_region_instance_group.group.instances[0].instance)[8]}
    var_gce_instance_name=${split("/", data.google_compute_region_instance_group.group.instances[0].instance)[10]}
    var_creds_file=serviceaccount.json
  EOT

}
