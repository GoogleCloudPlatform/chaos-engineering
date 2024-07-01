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
output "client_vm_name" {
  value = google_compute_instance.client.name
}

output "mig_vm_list" {
  value = data.google_compute_region_instance_group.group
}

output "mig_vm_zone" {
  value = split("/", data.google_compute_region_instance_group.group.instances[0].instance)[8]
}

output "mig_vm_name" {
  value = split("/", data.google_compute_region_instance_group.group.instances[0].instance)[10]
}