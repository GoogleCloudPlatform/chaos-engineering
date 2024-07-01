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
variable "project_id" {
  type        = string
  description = "The project ID to deploy the resources in"
}

variable "folder" {
  description = "folder for generated script files"
  type        = string
}

variable "region" {
  type        = string
  description = "The region in which to deploy the resources"
  default     = "us-central1"
}

variable "zone" {

  type        = string
  description = "The zone in which to deploy the VM"
  default     = "us-central1-a"
}

variable "tf_service_account" {
  type        = string
  description = "Service account for creating terraform resources for the L7 ILB Chaos experiment"
}

variable "gke_cluster_name" {
  description = "Name of the GKE cluster"
  type = string
  default = "test-cluster"
}

variable "deployment_name" {
  description = "Name of the GKE deployment"
  type = string
  default = "example-hello-app-deployment"
}

variable "app_name" {
  description = "Name of the app to be deployed on GKE."
  type = string
  default = "hello-app"
}

variable "service_name" {
  description = "Name of the service that exposes the application"
  type = string
  default = "hello-app-svc"
}

variable "load_balancer_name" {
  description = "Name of the load balancer that exposes the application"
  type = string
  default = "example-hello-app-loadbalancer"
}

variable "network_name" {
  description = "Name of the VPC network"
  type = string
  default = "gke-network"
}

variable "subnetwork_name" {
  description = "Name of the subnetwork inside VPC network."
  type = string
  default = "gke-subnetwork"
}

variable "subnet_cidr_range" {
  type        = string
  description = "Subnetwork CIDR range"
  default     = "10.0.0.0/16"
}

variable "secondary_ip_range" {
  type = list(object({
    range_name = string
    ip_cidr_range = string
  }))
  description = "List of secondary IP ranges for the network"
  default = [{
        range_name = "service-range"
        ip_cidr_range = "192.168.0.0/16"
    },
    {
        range_name = "pod-ranges"
        ip_cidr_range = "192.167.0.0/16"
    }]
}

variable "router_name" {
  type = string
  description = "Name of the cloud router that allows Internet access"
  default = "exp-router"
}

variable "nat_name" {
  type = string
  description = "Name of the Cloud NAT service"
  default = "exp-nat"
}

variable "master_ipv4_cidr_address" {
  type = string
  description = "IPv4 address to be used for master plane of the private cluster"
  default = "172.16.0.0/28"
}