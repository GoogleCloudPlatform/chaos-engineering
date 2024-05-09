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
### Firewall rules #####

### SSH into vm instances #####
resource "google_compute_firewall" "sshtoinstances" {
  name    = "sshtoinstances"
  project = var.project_id
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  disabled      = false
  source_ranges = ["35.235.240.0/20", var.subnet_cidr]
  direction     = "INGRESS"
}

### For allowing traffic from outside from the IPs in the source_ranges #####
resource "google_compute_firewall" "internetingress" {
  name    = "internetingress"
  project = var.project_id
  network = var.network

  allow {
    protocol = "all"
  }

  disabled      = false
  source_ranges = [var.subnet_cidr]
  direction     = "INGRESS"
}

#### Allow traffic to internet for download packages #####
resource "google_compute_firewall" "internetegress" {
  name    = "internetegress"
  project = var.project_id
  network = var.network

  allow {
    protocol = "all"
  }
  disabled      = false
  source_ranges = ["0.0.0.0/0"]
  direction     = "EGRESS"
}

#### We have to use all the below only for testing the experiments #####
####So creating then and disabling them for now ########################

#### Enable this for experiment1 manually ########
resource "google_compute_firewall" "testdenyegress" {
  name    = "testdenyegress"
  project = var.project_id
  network = var.network

  deny {
    protocol = "all"
  }
  disabled           = false
  target_tags        = ["testdenyegress"]
  destination_ranges = ["199.36.153.8/30"]
  direction          = "EGRESS"
}

#### Enable this for experiment2 manually ########
resource "google_compute_firewall" "pubsubdenyonall" {
  name    = "pubsubdenyonall"
  project = var.project_id
  network = var.network

  deny {
    protocol = "all"
  }
  disabled           = true
  target_tags        = ["pubsubdeny"]
  destination_ranges = ["0.0.0.0/0"]
  direction          = "EGRESS"
}

#### Enable this for experiment2 manually ########
resource "google_compute_firewall" "pubsuballowprivateapis" {
  name    = "pubsuballowprivateapis"
  project = var.project_id
  network = var.network

  allow {
    protocol = "all"
  }
  disabled           = true
  target_tags        = ["pubsuballowprivate"]
  destination_ranges = ["199.36.153.8/30"]
  direction          = "EGRESS"
}



