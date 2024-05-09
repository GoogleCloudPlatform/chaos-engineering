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
sudo apt-get update
sudo apt-get install curl -y
sudo apt-get install python3-pip -y
sudo apt-get -y install git-all python3 python3-venv
sudo apt-get -y install python-dev
sudo apt-get -y install build-essential

python3 -m venv /var/.venvs/chaostk
source  /var/.venvs/chaostk/bin/activate
python3 -m pip install -U pip
pip3 install --upgrade setuptools
pip3 install -U chaostoolkit
pip3 install -U chaostoolkit-google-cloud-platform
