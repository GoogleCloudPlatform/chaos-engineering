#
# Copyright 2024 Google LLC
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

cd ../../app/terraform
export SUBNET_ID=`terraform output subnetwork | tr -d '"'`
export VPC_NAME=`terraform output network | tr -d  '"'`
export CLUSTER_NAME=`terraform output cluster_name | tr -d '"'`
export CLUSTER_REGION=`terraform output cluster_region | tr -d '"'`
export LB_IP=`terraform output load_balancer_ip | tr -d '"'`
export NAMESPACE=`terraform output namespace | tr -d '"'`

cd ../../chaos-experiment/terraform
cp terraform.tfvars.template terraform.tfvars
 
sed -i "" "s/<gcp-project-id>/\"$PROJECT_ID\"/g" terraform.tfvars
sed -i "" "s/<terraform-service-account>/\"$MEMBER\"/g" terraform.tfvars
sed -i "" "s|<subnet-id>|\"$SUBNET_ID\"|g" terraform.tfvars
sed -i "" "s|<gcp-vpc-name>|\"$VPC_NAME\"|g" terraform.tfvars
sed -i "" "s|<folder>|\"$folder\"|g" terraform.tfvars
sed -i "" "s|<lb_ip>|\"$LB_IP\"|g" terraform.tfvars
sed -i "" "s|<namespace>|\"$NAMESPACE\"|g" terraform.tfvars
sed -i "" "s|<cluster_name>|\"$CLUSTER_NAME\"|g" terraform.tfvars
sed -i "" "s|<cluster_region>|\"$CLUSTER_REGION\"|g" terraform.tfvars

cp provider.template provider.tf
sed -i "" "s/<gcp-project-id>/$PROJECT_ID/g" provider.tf
