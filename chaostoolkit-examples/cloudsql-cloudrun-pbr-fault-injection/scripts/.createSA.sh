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
export PROJECT_ID=$(gcloud config get-value project)
export SA_NAME="terraform-cloudsql-pbr-sa"
export MEMBER="$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" 

gcloud iam service-accounts create $SA_NAME \
    --description="Terraform service account to create the GCP infra resources required for cloudsql experiment." \
    --display-name="Service Account for Terraform to create infra recourses for Cloud SQL."

roles=("roles/compute.admin" \
       "roles/compute.networkAdmin" \
       "roles/dns.admin" \
       "roles/vpcaccess.admin" \
       "roles/monitoring.editor" \
       "roles/cloudsql.admin" \
       "roles/run.admin" \
       "roles/iam.serviceAccountAdmin" \
       "roles/resourcemanager.projectIamAdmin" \
       "roles/iam.serviceAccountUser" \
       "roles/iam.serviceAccountTokenCreator" \
       "roles/iam.serviceAccountKeyAdmin" \
       "roles/serviceusage.serviceUsageAdmin" \
       "roles/secretmanager.admin" \
       "roles/resourcemanager.projectIamAdmin" \
       "roles/cloudbuild.builds.builder" \
       "roles/viewer" \
       "roles/logging.logWriter" \
       "roles/storage.objectViewer")

for role in ${roles[@]};
do
      gcloud projects add-iam-policy-binding $PROJECT_ID \
        --member="serviceAccount:$MEMBER" \
        --role="$role"
done
