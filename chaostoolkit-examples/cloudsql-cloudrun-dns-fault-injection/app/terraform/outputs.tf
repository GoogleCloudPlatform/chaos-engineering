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
output "dns_name_sql" {
  value = google_sql_database_instance.cloudsql.dns_name
  description = "the DNS connection URL of the cloud SQL instance "
}

output "sql_name" {
  value = google_sql_database_instance.cloudsql.name
  description = "Name of the cloud SQL instance"
}

output "project" {
  value = var.project_id
  description = "The GCP Project ID where the experiment resources are created"
}

output "region" {
  value = var.region
  description = "The GCP region where the experiment resources are created"
}

output "zone" {
  value = var.zone
  description = "The GCP region where the experiment resources are created"
}

output "zone_name" {
  value = google_dns_managed_zone.pscsql-zone.name
  description = "The GCP zone where the experiment resources are created"
}

output "vpc_id" {
  value = local.network
  description = "The network id where the experiment resources are created"
}

output "subnet_id" {
  value = google_compute_subnetwork.consumer-subnet.id
  description = "The subnetwork id where the experiment resources are created"
}

output "vpccon" {
  value = google_vpc_access_connector.vpccon.name
  description = "Name of the VPC access connector"
}

output "consumer_subnet_cidr" {
  value = var.consumer_subnet_cidr
  description = "CIDR Range for Consumer VPC"
}

output "vpcconnrange" {
  value = var.vpcconnrange
  description = "CIDR Range for VPC Con"
}

output "ip_psc_endpoint_cloudsql" {
  value = var.ip_psc_endpoint_cloudsql
  description = "old ip address of the server"
}

output "cloudrun_endpoint" {
  value = google_cloud_run_service.simple_web_app.status[0].url
  description = "the url of the cloud run service"
}
