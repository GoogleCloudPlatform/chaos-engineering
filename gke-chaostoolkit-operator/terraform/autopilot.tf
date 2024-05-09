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
  autopilot = "autopilot-cluster-chaostoolkit"
}

module "autopilot" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/beta-autopilot-private-cluster"
  version = "~> 30.0"

  project_id              = var.project_id
  name                    = local.autopilot
  regional                = true 
  region                  = var.region
  network                 = google_compute_network.gke_vpc.name
  subnetwork              = google_compute_subnetwork.gke_subnet.name
  ip_range_pods           = var.ip_range_pods
  ip_range_services       = var.ip_range_services
  create_service_account  = false
  enable_private_endpoint = true
  enable_private_nodes    = true
  master_ipv4_cidr_block  = "172.16.1.0/28"
  deletion_protection     = false

  master_authorized_networks = [
    {
      cidr_block   = "10.0.0.0/24" 
      display_name = "VPC"
    },
    {
      cidr_block   = "10.0.1.0/24" 
      display_name = "auth"
    },
  ]

  depends_on = [google_compute_network.gke_vpc] 

}
