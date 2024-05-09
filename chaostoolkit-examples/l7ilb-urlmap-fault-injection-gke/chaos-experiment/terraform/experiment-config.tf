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
resource "local_file" "yaml_config" {

  filename = "${var.folder}/experiment.yaml"
  
  content  = <<-EOT
    ---
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: chaostoolkit-experiment
      namespace: chaostoolkit-run
    data:
      experiment.json: |
        {
          "title": "What is the impact of introducing fault in L7 ILB for a backend  service's traffic",
          "description": "If a fault is introduced, we should see an error.",
          "tags": ["gce-ilb-fault"],
          "configuration": {
             "gcp_project_id": "${var.project_id}",
             "gcp_region": "${var.region}"
          },
          "steady-state-hypothesis": {
              "title": "Application responds",
              "probes": [
                  {
                      "type": "probe",
                      "name": "app responds without any delays",
                      "tolerance": 200,
                      "provider": {
                          "type": "http",
                          "timeout": 3,
                          "verify_tls": false,
                          "url": "http://${var.compute_ip_address}:8080/"
                      }
                  }
           
              ]
          },
          "method": [
              {
            	"name" : "inject-fault-in-i7ilb",
            	"type" : "action",
                    "provider": {
                       "type": "python",
                       "module": "chaosgcp.lb.actions",
                       "func": "inject_traffic_faults",
                       "secrets": ["gcp"],
                       "arguments": {
                           "url_map": "${var.url_map_name}",
                           "target_name": "${var.url_map_target_name}",
                           "target_path": "/*",
                           "regional": true,
                           "impacted_percentage": 100.0,
                           "http_status": 503
                       }
                    },
                    "pauses": {
                      "after" :30 
                    }
              }
          ],
          "rollbacks": [
              {
                "name" : "rollback-fault-in-i7elb",
                "type" : "action",
                "provider": {
                            "type": "python",
                            "module": "chaosgcp.lb.actions",
                            "func": "remove_fault_injection_traffic_policy",
                            "secrets": ["gcp"],
                            "arguments": {
                                "url_map": "${var.url_map_name}",
                                "target_name": "${var.url_map_target_name}",
                                "target_path": "/*",
                                "regional" : true
                            }
                        }
              }
          ]
        }
    ---
    apiVersion: chaostoolkit.org/v1
    kind: ChaosToolkitExperiment
    metadata:
      name: l7ilb-urlmap-fault-injection-experiment
      namespace: chaostoolkit-crd
    spec:
      serviceaccount:
        name: l7b-ksa
      namespace: chaostoolkit-run
      pod:
        image: "gcr.io/${var.project_id}/chaostoolkit"
  EOT

}
