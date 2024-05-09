/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

# Internal TCP/UDP load balancer with a managed instance group backend

resource "google_compute_address" "ip_address" {
  name         = "cloudsql-nlb-ipv4address"
  address      = var.lb_ip_address
  address_type = "INTERNAL"
  subnetwork   = var.subnet_id
}


# [START cloudloadbalancing_int_tcp_udp_gce]

# [START cloudloadbalancing_int_tcp_udp_gce_forwarding_rule]
resource "google_compute_forwarding_rule" "google_compute_forwarding_rule" {
  name                  = "l4-ilb-forwarding-rule"
  ip_address            = google_compute_address.ip_address.address
  region                = var.region     
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL"
  all_ports             = true
  allow_global_access   = true
  backend_service       = google_compute_region_backend_service.default.id
  network               = var.vpc_id
  subnetwork            = var.subnet_id
}
# [END cloudloadbalancing_int_tcp_udp_gce_forwarding_rule]

# [START cloudloadbalancing_int_tcp_udp_gce_backend_service]
resource "google_compute_region_backend_service" "default" {
  name                  = "l4-ilb-backend"
  region                = var.region    
  protocol              = "TCP"
  load_balancing_scheme = "INTERNAL"
  health_checks         = [google_compute_region_health_check.default.id]
  backend {
    group          = google_compute_region_instance_group_manager.mig.instance_group
    balancing_mode  = "CONNECTION"
  }
}
# [END cloudloadbalancing_int_tcp_udp_gce_backend_service]

# [START compute_int_tcp_udp_gce_instance_template]
resource "google_compute_instance_template" "instance_template" {
  name         = "l4-ilb-mig-template"
  machine_type = "e2-micro"
  tags         = ["allow-ssh", "allow-health-check", "http-server", "https-server", "toxiproxy"]

  network_interface {
    network    = var.vpc_id
    subnetwork = var.subnet_id
  }
  disk {
    source_image = "debian-cloud/debian-10"
    auto_delete  = true
    boot         = true
  }
  can_ip_forward = true

  # install nginx and serve a simple web page
  metadata = {
    startup-script = file("../scripts/server_startup.sh")
  }
  
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = local.sa_email
    scopes = ["cloud-platform"]
  }
  
  lifecycle {
    create_before_destroy = true
  }
}
# [END compute_int_tcp_udp_gce_instance_template]

# [START cloudloadbalancing_int_tcp_udp_gce_health_check]
resource "google_compute_region_health_check" "default" {
  name   = "l4-ilb-hc"
  region = var.region     
  http_health_check {
    request_path = "/proxies"
    port = "8474"
  }
}
# [END cloudloadbalancing_int_tcp_udp_gce_health_check]

# [START compute_int_tcp_udp_gce_mig]
resource "google_compute_region_instance_group_manager" "mig" {
  name   = "l4-ilb-mig"
  region = var.region
  version {
    instance_template = google_compute_instance_template.instance_template.id
    name              = "primary"
  }
  base_instance_name = "l4-ilb-mig-toxiproxy-server"
  target_size        = 1
}
# [END compute_int_tcp_udp_gce_mig]

# [START vpc_int_tcp_udp_gce_mig_firewall_health_check]
# allow all access from health check ranges
resource "google_compute_firewall" "fw_hc" {
  name          = "l4-ilb-fw-allow-hc"
  direction     = "INGRESS"
  network       = var.vpc_id
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16", "35.235.240.0/20"]
  allow {
    protocol = "tcp"
    ports    = ["8474"]
  }
  target_tags = ["allow-health-check"]
}
# [END vpc_int_tcp_udp_gce_mig_firewall_health_check]

# [START vpc_int_tcp_udp_gce_firewall_backends]
# allow communication within the subnet
resource "google_compute_firewall" "fw_ilb_to_backends" {
  name          = "l4-ilb-fw-allow-ilb-to-backends"
  direction     = "INGRESS"
  network       = var.vpc_id
  source_ranges = [var.consumer_subnet_cidr]
  allow {
    protocol = "all"
  }
}
# [END vpc_int_tcp_udp_gce_firewall_backends]

# [START vpc_int_tcp_udp_gce_firewall_ssh]
# allow SSH
resource "google_compute_firewall" "fw_ilb_ssh" {
  name      = "l4-ilb-fw-ssh"
  direction = "INGRESS"
  network   = var.vpc_id
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags   = ["allow-ssh"]
  source_ranges = ["0.0.0.0/0"]
}
# [END vpc_int_tcp_udp_gce_firewall_ssh]
