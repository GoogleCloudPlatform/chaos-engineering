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

variable "subnet_cidr" {
  type        = string
  description = "subnetwork CIDR range"
  default     = "10.1.2.0/26"
}

variable "proxy_subnet_cidr" {
  type        = string
  description = "proxy subnetwork CIDR range for L7 ILB"
  default     = "10.0.1.0/24"
}

variable "folder" {
  description = "folder for generated script files"
  type        = string
}


variable "compute_ip_address" {
  type        = string
  description = "IP address for L7 internal load balancer forwarding rule"
  default     = "10.1.2.23"
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

variable "url_map_target_name" {
  type        = string
  description = "The path matcher name for injecting faults"
  default     = "chaos-int-l7-lb-path-matcher"
}

variable "url_map_name" {
  type        = string
  description = "Url map name for the L7 ILB"
  default     = "chaos-l7-ilb"
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
