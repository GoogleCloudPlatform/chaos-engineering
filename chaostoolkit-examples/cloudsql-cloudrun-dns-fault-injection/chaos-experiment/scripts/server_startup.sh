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
sudo apt-get install curl
sudo apt-get install python3-pip -y
pip3 install -U chaostoolkit
wget -O toxiproxy-2.1.4.deb https://github.com/Shopify/toxiproxy/releases/download/v2.1.4/toxiproxy_2.1.4_amd64.deb
sudo dpkg -i toxiproxy-2.1.4.deb
sudo cp /etc/init/toxiproxy.conf /lib/systemd/system/toxiproxy.service
cat <<EOF >> /lib/systemd/system/toxiproxy.service 
                                                              
[Unit]                                                         
Description=TCP proxy to simulate network and system Conditions 
After=network-online.target firewalld.service            
Wants=network-online.target                              
                                                          
[Service]                                                  
Type=simple                                                 
ExecStart=/usr/bin/toxiproxy-server -port 8474 -host 0.0.0.0 
Restart=on-failure                                            
                                                              
[Install]                                                      
WantedBy=multi-user.target                                      
EOF
sudo service toxiproxy start

