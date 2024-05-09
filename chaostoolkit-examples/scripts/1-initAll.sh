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
cd ../cloudsql-cloudrun-dns-fault-injection/scripts/
. .setEnv.sh
gcloud storage buckets create gs://$PROJECT_ID-terraform-backend --location=us-central1

./1-init.sh
cd ../../cloudsql-cloudrun-pbr-fault-injection/scripts/
./1-init.sh
cd ../../l7ilb-urlmap-fault-injection/scripts/
./1-init.sh
cd ../../l7ilb-urlmap-fault-injection-gke/scripts/
./1-init.sh
cd ../../pubsub-fault-injection/scripts/
./1-init.sh

