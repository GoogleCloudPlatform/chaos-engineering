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

cd ../../app/terraform

export SUBNET_ID=`terraform output pubsubfaulttestsubnetid | tr -d '"'`
export SERVER_IP=`terraform output server_IP | tr -d '"'`
export SERVER_NAME=`terraform output server_name | tr -d '"'`
export VPC_NAME=`terraform output pubsubfaulttestvpcname | tr -d  '"'`
export MEMBER="$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" 

cd ../../chaos-experiment/terraform
cp terraform.tfvars.template terraform.tfvars
 
sed -i "s/<gcp-project-id>/\"$PROJECT_ID\"/g" terraform.tfvars
sed -i "s/<terraform-service-account>/\"$MEMBER\"/g" terraform.tfvars
sed -i "s/<server-ip>/\"$SERVER_IP\"/g" terraform.tfvars
sed -i "s/<server-name>/\"$SERVER_NAME\"/g" terraform.tfvars
sed -i "s|<subnet-id>|\"$SUBNET_ID\"|g" terraform.tfvars
sed -i "s|<gcp-vpc-name>|\"$VPC_NAME\"|g" terraform.tfvars
sed -i "s|<folder>|\"$folder\"|g" terraform.tfvars

cp provider.template provider.tf
sed -i "s/<gcp-project-id>/$PROJECT_ID/g" provider.tf
