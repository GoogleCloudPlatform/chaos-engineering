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
  network = google_compute_network.vpc-consumer.id
  region  = google_compute_subnetwork.consumer-subnet.region  
}

resource "google_compute_network" "vpc-consumer" {
  name                    = "consumer-vpc-pbr"
  project                 = var.project_id
  auto_create_subnetworks = false

  depends_on = [
     google_project_service.enabled_apis
  ]
}
 
resource "google_compute_subnetwork" "consumer-subnet" {
  name          = "consumer-subnet-pbr"
  project       = var.project_id
  ip_cidr_range = var.consumer_subnet_cidr
  region        = var.region
  network       = local.network
}

resource "google_vpc_access_connector" "vpccon" {
  name          = "vpccon-pbr"
  ip_cidr_range = var.vpcconnrange
  project       = var.project_id
  region        = var.region
  network       = local.network
}

resource "google_compute_router" "router" {
  name    = "consumer-router-pbr"
  region  = local.region
  network = local.network

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "consumer-router-nat-pbr"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }

}
