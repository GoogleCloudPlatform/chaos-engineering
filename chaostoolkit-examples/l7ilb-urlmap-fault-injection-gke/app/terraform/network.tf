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
resource "google_compute_network" "ilb_vpc" {
  name                    = "l7-ilb-vpc-gke"
  project                 = var.project_id
  auto_create_subnetworks = false

  depends_on = [
     google_project_service.enable_apis
  ]
}

resource "google_compute_subnetwork" "ilb_subnet" {
  name          = "l7-ilb-subnet-${var.region}-gke"
  project       = var.project_id
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.ilb_vpc.id
}

# proxy-only subnet
resource "google_compute_subnetwork" "proxy_subnet" {
  name          = "l7-ilb-proxy-subnet-gke"
  ip_cidr_range = var.proxy_subnet_cidr
  region        = var.region
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
  network       = google_compute_network.ilb_vpc.id
}

resource "google_compute_router" "router" {
  name    = "l7ilb-test-router-gke"
  region  = google_compute_subnetwork.ilb_subnet.region
  network = google_compute_network.ilb_vpc.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "l7ilb-router-nat-gke"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }

}
