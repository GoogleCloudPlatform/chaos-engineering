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
resource "local_file" "variable_config" {

  filename = "${var.folder}/variables.env"

  content  = <<-EOT
    var_gcp_project_id=${var.project_id}
    var_parent=projects/${var.project_id}/locations/global
    var_gcp_region=${var.region}
    var_cloudrun_endpoint=${var.cloudrun_endpoint}
    var_route_name=cloudrun_pbr1
    var_src_range=${var.vpcconnrange}
    var_dest_range=${var.ip_psc_endpoint_cloudsql}
    var_vpc_id=${var.vpc_id}
    var_ilb_ip=${var.lb_ip_address}
    var_ip_psc_endpoint_cloudsql=${var.ip_psc_endpoint_cloudsql}
  EOT
  
}
