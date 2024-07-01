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
output "cluster_name" {
  value       = split("/",google_container_cluster.default.id)[5]
  description = "The GKE cluster name"
}

output "cluster_region" {
  value = google_container_cluster.default.location
  description = "The GKE cluster region"
}

output "load_balancer_ip" {
  value = kubernetes_service_v1.default.status.0.load_balancer.0.ingress.0.ip
  description = "Load balancer external IP"
}

output "namespace" {
  value = kubernetes_deployment_v1.default.metadata.0.namespace
  description = "Kubernetes deployment namespace"
}

output "network" {
  value = google_compute_network.default.name
  description = "Name of the VPC network"
}

output "subnetwork" {
  value = google_compute_subnetwork.default.name
  description = "Name of the subnetwork"
}
