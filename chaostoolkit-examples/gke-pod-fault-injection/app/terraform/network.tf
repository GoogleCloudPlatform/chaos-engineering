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
resource "google_compute_network" "default" {
    name = var.network_name
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default" {
    name = var.subnetwork_name
    ip_cidr_range = var.subnet_cidr_range
    region = var.region
    network = google_compute_network.default.id
    secondary_ip_range = var.secondary_ip_range
}

resource "google_compute_firewall" "fw_iap" {
  name          = "allow-iap"
  direction     = "INGRESS"
  network       = google_compute_network.default.name
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16", "35.235.240.0/20"]
  allow {
    protocol = "tcp"
  }
}

resource "google_compute_router" "router" {
  name    = var.router_name
  region  = google_compute_subnetwork.default.region
  network = google_compute_network.default.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = var.nat_name
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}