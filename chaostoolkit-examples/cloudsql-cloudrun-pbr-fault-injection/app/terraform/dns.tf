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
#### DNS record for Cloud SQL ########
resource "google_dns_managed_zone" "pscsql-zone" {
  name        = "private-zone-pscsql-pbr"
  dns_name    = "${var.region}.sql.goog."
  project     = var.project_id
  description = "Private DNS name for Cloud SQL"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.vpc-consumer.id
    }
  }
}

### DNS record ######
resource "google_dns_record_set" "frontend" {
  name    = data.google_sql_database_instance.default.dns_name
  type    = "A"
  project = var.project_id
  ttl     = 5

  managed_zone = google_dns_managed_zone.pscsql-zone.name

  rrdatas = [var.ip_psc_endpoint_cloudsql]
}
