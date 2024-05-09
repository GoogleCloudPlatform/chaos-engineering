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
#!/bin/bash
. ../../scripts/.setEnv.sh

cd ../../../../gke-chaostoolkit-operator/terraform
export VM_NAME=`terraform output vm_name | tr -d  '"'`
export GKE_NETWORK=`terraform output gke_network_self_link | tr -d  '"'`

echo $COMPUTE_IP
cd ../../chaostoolkit-examples/l7ilb-urlmap-fault-injection-gke/chaos-experiment/terraform
cp terraform.tfvars.template terraform.tfvars
 
sed -i "s/<gcp-project-id>/\"$PROJECT_ID\"/g" terraform.tfvars
sed -i "s/<terraform-service-account>/\"$MEMBER\"/g" terraform.tfvars
sed -i "s|<vm-name>|\"$VM_NAME\"|g" terraform.tfvars
sed -i "s|<gke-network-self-link>|\"$GKE_NETWORK\"|g" terraform.tfvars
sed -i "s|<folder>|\"$folder\"|g" terraform.tfvars

cp provider.template provider.tf
sed -i "s/<gcp-project-id>/$PROJECT_ID/g" provider.tf

cd ../../app/terraform
export COMPUTE_IP=`terraform output compute_ip_address | tr -d '"'`
export SUBNET_ID=`terraform output subnetid | tr -d '"'`
export VPC_NAME=`terraform output vpcname | tr -d  '"'`
export APP_NETWORK=`terraform output app_network_self_link | tr -d  '"'`

echo $COMPUTE_IP
cd ../../chaos-experiment/terraform

sed -i "s/<gcp-project-id>/\"$PROJECT_ID\"/g" terraform.tfvars
sed -i "s/<terraform-service-account>/\"$MEMBER\"/g" terraform.tfvars
sed -i "s/<compute-ip-address>/\"$COMPUTE_IP\"/g" terraform.tfvars
sed -i "s|<subnet-id>|\"$SUBNET_ID\"|g" terraform.tfvars
sed -i "s|<gcp-vpc-name>|\"$VPC_NAME\"|g" terraform.tfvars
sed -i "s/<gcp-project-id>/$PROJECT_ID/g" provider.tf
sed -i "s|<app-network-self-link>|\"$APP_NETWORK\"|g" terraform.tfvars
