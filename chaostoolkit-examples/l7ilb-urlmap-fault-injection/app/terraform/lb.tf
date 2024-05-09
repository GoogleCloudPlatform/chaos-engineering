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
resource "google_compute_address" "ip_address" {
  name         = "chaos-controlplane-ipv4address"
  address      = var.compute_ip_address
  address_type = "INTERNAL"
  subnetwork   = google_compute_subnetwork.ilb_subnet.id
}

# forwarding rule
resource "google_compute_forwarding_rule" "google_compute_forwarding_rule" {
  name = "l7-ilb-forwarding-rule"

  region                = var.region
  ip_address            = google_compute_address.ip_address.address
  depends_on            = [google_compute_subnetwork.proxy_subnet]
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL_MANAGED"
  port_range            = "8080"
  target                = google_compute_region_target_http_proxy.default.id
  network               = google_compute_network.ilb_vpc.id
  subnetwork            = google_compute_subnetwork.ilb_subnet.id
  network_tier          = "PREMIUM"
}

# HTTP target proxy
resource "google_compute_region_target_http_proxy" "default" {
  name    = "l7-ilb-target-http-proxy"
  region  = var.region
  url_map = google_compute_region_url_map.default.id
}

# URL map
resource "google_compute_region_url_map" "default" {
  name            = var.url_map_name
  region          = var.region
  default_service = google_compute_region_backend_service.default.id

  host_rule {
    hosts        = ["*"]
    path_matcher = var.url_map_target_name
  }

  path_matcher {
    name            = var.url_map_target_name
    default_service = google_compute_region_backend_service.default.id

    path_rule {
      paths   = ["/*"]
      service = google_compute_region_backend_service.default.id
    }
  }


}

# backend service
resource "google_compute_region_backend_service" "default" {
  name = "l7-ilb-backend-subnet"

  region                = var.region
  protocol              = "HTTP"
  load_balancing_scheme = "INTERNAL_MANAGED"
  timeout_sec           = 10
  health_checks         = [google_compute_region_health_check.default.id]
  port_name             = "http"
  backend {
    group           = google_compute_region_instance_group_manager.mig.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

# instance template
resource "google_compute_instance_template" "instance_template" {
  name         = "l7-ilb-mig-template"
  machine_type = "e2-small"
  tags         = ["http-server"]

  network_interface {
    network    = google_compute_network.ilb_vpc.id
    subnetwork = google_compute_subnetwork.ilb_subnet.id
  }
  disk {
    source_image = "debian-cloud/debian-12"
    auto_delete  = true
    boot         = true
  }

  # install nginx and serve a simple web page
  metadata = {
    startup-script = file("../scripts/server_startup.sh")
  }

  lifecycle {
    create_before_destroy = true
  }
}

# health check
resource "google_compute_region_health_check" "default" {
  name   = "l7-ilb-hc"
  region = var.region
  http_health_check {
    port_specification = "USE_SERVING_PORT"
  }

  depends_on = [
     google_project_service.enable_apis
  ]

}

# MIG
resource "google_compute_region_instance_group_manager" "mig" {
  name   = "l7-ilb-mig"
  region = var.region
  version {
    instance_template = google_compute_instance_template.instance_template.id
    name              = "primary"
  }
  base_instance_name = "l7-ilb-mig"
  target_size        = 1
  named_port {
    name = "http"
    port = 80
  }
}

