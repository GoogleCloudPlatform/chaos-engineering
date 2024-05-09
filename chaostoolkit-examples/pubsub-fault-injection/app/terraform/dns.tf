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
#### Private Zone for PubSub experiment ########
resource "google_dns_managed_zone" "privatepubsub-zone" {
  name        = "private-zone-pubsub"
  dns_name    = "googleapis.com."
  project     = var.project_id
  description = "Private DNS name for Private google apis"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.pubsubfaulttest-vpc.id
    }
  }

  depends_on = [
    google_service_account.app_service_account
  ]
}

### DNS A record ######
resource "google_dns_record_set" "privateapi_A_record" {
  name    = "private.googleapis.com."
  type    = "A"
  project = var.project_id
  ttl     = 5

  managed_zone = google_dns_managed_zone.privatepubsub-zone.name

  rrdatas = ["199.36.153.11", "199.36.153.10", "199.36.153.9", "199.36.153.8"]
}

### DNS AAAA record ######
resource "google_dns_record_set" "privateapi_AAAA_record" {
  name    = "private.googleapis.com."
  type    = "AAAA"
  project = var.project_id
  ttl     = 5

  managed_zone = google_dns_managed_zone.privatepubsub-zone.name

  rrdatas = ["2600:2d00:2:2000::"]
}

### DNS CNAME record ######
resource "google_dns_record_set" "privateapi_CNAME_record" {
  name    = "*.googleapis.com."
  type    = "CNAME"
  project = var.project_id
  ttl     = 5

  managed_zone = google_dns_managed_zone.privatepubsub-zone.name

  rrdatas = ["private.googleapis.com."]
}
