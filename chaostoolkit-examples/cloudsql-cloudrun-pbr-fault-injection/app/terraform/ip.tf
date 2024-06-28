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
##### Creating a static address #######
resource "google_compute_address" "ip-address-psc" {
  name         = "ip-address-psc-${google_sql_database_instance.cloudsql.name}"
  project      = var.project_id
  region       = var.region
  address_type = "INTERNAL"
  subnetwork   = google_compute_subnetwork.consumer-subnet.name # Replace value with the name of the subnet here.
  address      = var.ip_psc_endpoint_cloudsql                          # Replace value with the IP address to reserve.
  
}

###### Forwarding rule for this address ########
resource "google_compute_forwarding_rule" "default" {
  name                  = "psc-forwarding-rule-pbr"
  region                = var.region
  project               = var.project_id
  network               = local.network_name
  ip_address            = google_compute_address.ip-address-psc.self_link
  load_balancing_scheme = ""
  target                = data.google_sql_database_instance.default.psc_service_attachment_link
}

