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
  description = "ID for project"
  type        = string
}

variable "network" {
  description = "VPC in project"
  type        = string
}


variable "subnet_id" {
  description = "Subentwork id in project"
  type        = string
}

variable "region" {
  description = "Region in project"
  type        = string
}

variable "zone" {
  description = "Zone in project"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR range for subnet"
  type        = string
}


variable "server_IP" {
  description = "IP for the server"
  type        = string
}

variable "server_name" {
  description = "namefor the server"
  type        = string
}
variable "folder" {
  description = "folder for generated script files"
  type        = string
}

variable "tf_service_account" {
  description = "Service Account for running the terraform code to create resources"
  type        = string
}
