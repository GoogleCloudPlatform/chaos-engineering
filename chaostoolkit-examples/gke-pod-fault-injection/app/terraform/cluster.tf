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
resource "google_container_cluster" "default" {
    name = var.gke_cluster_name
    location = var.region
    initial_node_count = 1
    deletion_protection = false
    cluster_autoscaling {
        enabled = false
        # auto_provisioning_defaults {
        #   shielded_instance_config {
        #     enable_integrity_monitoring = true
        #     enable_secure_boot          = true
        #   }
        # }
    }
    node_config {
      shielded_instance_config {
        enable_integrity_monitoring = true
        enable_secure_boot          = true
      }
    }
    # enable_shielded_nodes = true
    private_cluster_config {
      enable_private_nodes = true
      master_ipv4_cidr_block  = var.master_ipv4_cidr_address
    } 
    addons_config {
        horizontal_pod_autoscaling {
          disabled = true
        }
    }
    enable_l4_ilb_subsetting = true
    network = google_compute_network.default.id
    subnetwork = google_compute_subnetwork.default.id
    ip_allocation_policy {
      services_secondary_range_name = google_compute_subnetwork.default.secondary_ip_range[0].range_name
      cluster_secondary_range_name = google_compute_subnetwork.default.secondary_ip_range[1].range_name
    }
}