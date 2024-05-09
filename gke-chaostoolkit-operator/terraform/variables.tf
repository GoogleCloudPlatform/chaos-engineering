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
variable "project_id" {
  type        = string
  description = "The project ID to deploy the resources in"
}

variable "subnet_cidr" {
  type        = string
  description = "subnetwork CIDR range"
  default     = "10.0.0.0/24"
}

variable "auth_subnet_cidr" {
  type        = string
  description = "proxy subnetwork CIDR range for L7 ILB"
  default     = "10.0.1.0/24"
}

variable "folder" {
  description = "folder for generated script files"
  type        = string
}

variable "operator_root" {
  description = "folder for installing Chaostoolkit Operator Kustomization code."
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

variable "ip_range_pods" {
  description = "The secondary ip range to use for pods"
}

variable "ip_range_services" {
  description = "The secondary ip range to use for pods"
}

variable "cluster_name_suffix" {
  description = "A suffix to append to the default cluster name"
  default     = ""
}

variable "zones" {
  type        = list(string)
  description = "The zone to host the cluster in (required if is a zonal cluster)"
  default     = ["us-central1-a","us-central1-b"]
}
