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
output "project_id" {
  value = var.project_id
}

output "region" {
  value = google_compute_region_url_map.default.region
}

output "var_url_map_name" {
  value = google_compute_region_url_map.default.name
}

output "var_url_map_target_name" {
  value = google_compute_region_url_map.default.path_matcher[0].name
}

output "compute_ip_address" {
  value = google_compute_forwarding_rule.google_compute_forwarding_rule.ip_address
}

output "subnetid" {
  value       = google_compute_subnetwork.ilb_subnet.id
  description = "The GCP subnetwork id"
}

output "vpcname" {
  value       = google_compute_network.ilb_vpc.name
  description = "The name of the VPC"
}

output "app_network_self_link" {
  value       = google_compute_network.ilb_vpc.self_link
}
