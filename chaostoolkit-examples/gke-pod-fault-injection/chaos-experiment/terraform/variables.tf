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

variable "network" {
  description = "VPC in project"
  type        = string
}

variable "subnet_id" {
  description = "Subentwork id in project"
  type        = string
}

variable "lb_ip" {
  description = "External IP address of the Load Balancer"
  type = string
}

# variable "deployment" {
#   description = "Name of the GKE deployment"
#   type = string
# }

variable "namespace" {
  description = "Namespace of the GKE deployment"
  type = string
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type = string
}

variable "cluster_region" {
  description = "Region in which the GKE cluster is deployed"
  type = string
}

variable "vm_instance_name" {
  description = "Name of the GCE VM Instance"
  type = string
  default = "chaos-controlplane-vm-gke-pod"
}