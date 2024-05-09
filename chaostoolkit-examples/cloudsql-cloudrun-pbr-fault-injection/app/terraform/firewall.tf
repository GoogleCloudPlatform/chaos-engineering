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
locals {
   network_name = google_compute_network.vpc-consumer.name
}

resource "google_compute_firewall" "sshtoinstance" {
  name    = "ssh-to-instance-pbr"
  project = var.project_id
  network = local.network_name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  disabled      = false
  source_ranges = ["35.235.240.0/20", var.consumer_subnet_cidr]
  direction     = "INGRESS"
}

resource "google_compute_firewall" "toxiproxyegress" {
  name    = "toxiproxyegress-pbr"
  project = var.project_id
  network = local.network_name

  allow {
    protocol = "all"
  }
  disabled      = false
  source_ranges = ["0.0.0.0/0"]
  direction     = "EGRESS"
}

resource "google_compute_firewall" "toxiproxyingress" {
  name    = "toxiproxyingress-pbr"
  project = var.project_id
  network = local.network_name

  allow {
    protocol = "all"
  }
  source_tags = ["toxiproxy"]
  disabled    = false
  target_tags = ["toxiproxy"]
  direction   = "INGRESS"
}

