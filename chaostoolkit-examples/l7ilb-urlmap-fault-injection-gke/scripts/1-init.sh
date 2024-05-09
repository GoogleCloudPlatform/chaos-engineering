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
. .setEnv.sh
sudo mkdir -p $folder
sudo chmod 777 $folder

cd ../../../gke-chaostoolkit-operator/scripts;
while true; do
	read -p "Do you wish to init GKE cluster as well(Yes/No)? " yn
    case $yn in
        [Yy]* ) ./1-init.sh; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

cd ../../chaostoolkit-examples/l7ilb-urlmap-fault-injection-gke/scripts
./.createSA.sh
cd ../app/scripts
./setupApp.sh
cd ../terraform
terraform init -reconfigure -lock=false
cd ../../chaos-experiment/scripts
./setupChaos.sh
cd ../terraform
terraform init -reconfigure  -lock=false
