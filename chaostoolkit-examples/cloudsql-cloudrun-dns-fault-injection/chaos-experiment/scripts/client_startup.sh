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
sudo apt-get -y install curl git-all python3-pip python3 python3-venv
sudo apt-get -y install python-dev
sudo apt-get -y install build-essential
python3 -m pip install -U pip
pip3 install --upgrade setuptools

python3 -m venv /var/.venvs/chaostk
source  /var/.venvs/chaostk/bin/activate
pip3 install -U chaostoolkit
pip3 install -U chaostoolkit-toxiproxy
pip3 install -U google-cloud-network-connectivity
# git clone https://github.com/yujunliang/chaostoolkit-google-cloud-platform
# cd chaostoolkit-google-cloud-platform/
# git pull
# pip3 install -e .
# make install-dev
pip3 install -U chaostoolkit-google-cloud-platform
