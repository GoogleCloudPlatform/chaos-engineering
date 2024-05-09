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
output "project" {
  value       = google_compute_network.pubsubfaulttest-vpc.project
  description = "The GCP Project ID where the experiment resources are created"
}

output "region" {
  value       = google_compute_subnetwork.pubsubfaulttest-subnet.region
  description = "The GCP region where the experiment resources are created"
}


output "zone" {
  value       = google_compute_instance.pubsubtestserver.zone
  description = "The GCP zone where the compute instances are created"
}

output "server_name" {
  value       = google_compute_instance.pubsubtestserver.name
  description = "The name of the server compute instances"
}
output "server_IP" {
  value       = google_compute_instance.pubsubtestserver.network_interface[0].network_ip
  description = "The server IP of compute instances created"
}

output "pubsubfaulttestsubnetid" {
  value       = google_compute_subnetwork.pubsubfaulttest-subnet.id
  description = "The GCP subnetwork id"
}

output "pubsubfaulttestvpcname" {
  value       = google_compute_network.pubsubfaulttest-vpc.name
  description = "The name of the VPC"
}

