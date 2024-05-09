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
locals {

  zone = google_compute_instance.proxyclient.zone
  name = google_compute_instance.proxyclient.name

}

resource "google_compute_instance" "proxyclient" {
  boot_disk {
    auto_delete = true
    device_name = "client"

    initialize_params {
      image = "projects/debian-cloud/global/images/debian-12-bookworm-v20240213"
      size  = 10
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src = "vm-add-tf-proxy"
  }

  machine_type = "e2-small"
  project      = var.project_id
  allow_stopping_for_update = true

  metadata = {
    startup-script = file("../scripts/client_startup.sh")
  }

  name = "cloudsql-pbr-client"

  network_interface {
    subnetwork = "${var.subnet_id}"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }


  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = local.sa_email
    scopes = ["cloud-platform"]
  }

  tags = ["http-server", "https-server", "toxiproxy"]
  zone = var.zone
}
