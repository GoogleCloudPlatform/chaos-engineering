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
export OLD_IP=`terraform output ip_psc_endpoint_cloudsql    | tr -d '"'`
export DNS_NAME=`terraform output dns_name_sql    | tr -d '"'`
export ZONE_NAME=`terraform output zone_name      | tr -d '"'`
export CLOUDRUN=`terraform output cloudrun_endpoint | tr -d '"'`
export SUBNET_ID=`terraform output subnet_id | tr -d '"'`
export VPC_CON=`terraform output vpcconnrange | tr -d '"'`
export REGION=`terraform output region      | tr -d '"'`
export ZONE=`terraform output zone      | tr -d '"'`
export SUBNET_CIDR=`terraform output consumer_subnet_cidr | tr -d '"'`
echo $NEW_IP
echo $OLD_IP
echo $DNS_NAME
echo $ZONE_NAME
echo $CLOUDRUN

cd ../../chaos-experiment/terraform
cp terraform.tfvars.template terraform.tfvars
 
sed -i "" "s/<gcp-project-id>/\"$PROJECT_ID\"/g" terraform.tfvars
sed -i "" "s/<terraform-service-account>/\"$MEMBER\"/g" terraform.tfvars
sed -i "" "s/<output.var_ip_address_old>/\"$OLD_IP\"/g" terraform.tfvars
sed -i "" "s/<output.dns_name_sql>/\"$DNS_NAME\"/g" terraform.tfvars
sed -i "" "s/<output.zone_name>/\"$ZONE_NAME\"/g" terraform.tfvars
sed -i "" "s|<output.subnet_id>|\"$SUBNET_ID\"|g" terraform.tfvars
sed -i "" "s|<output.cloudrun_endpoint>|\"$CLOUDRUN\"|g" terraform.tfvars
sed -i "" "s|<output.vpcconnrange>|\"$VPC_CON\"|g" terraform.tfvars
sed -i "" "s/<output.region>/\"$REGION\"/g" terraform.tfvars
sed -i "" "s/<output.zone>/\"$ZONE\"/g" terraform.tfvars
sed -i "" "s|<output.consumer_subnet_cidr>|\"$SUBNET_CIDR\"|g" terraform.tfvars
sed -i "" "s|<folder>|\"$folder\"|g" terraform.tfvars

cp provider.template provider.tf
sed -i "" "s/<gcp-project-id>/$PROJECT_ID/g" provider.tf
