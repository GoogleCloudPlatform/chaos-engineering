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
locals {

  server_startup_script = <<-EOT
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install curl -y
    sudo apt-get install python3-pip -y
    sudo apt-get install git -y
    pip3 install google-cloud
    pip3 install google-api-python-client
    pip3 install google-cloud-pubsub
    pip3 install google-cloud-compute
    pip3 install flask

    cat <<EOF > messages_server.txt 
    Hello World!!!
    EOF

    cat <<EOF > flask_server.py
    from flask import Flask, jsonify, request 
    from google import api_core
    from google.cloud import pubsub_v1
    import json
    import sys
    from google.oauth2 import service_account
    from google.api_core.retry import Retry

    #### Parameter from command line arguments ######
    project_id = str(sys.argv[1])
    topic_id = "hellopsc"

    app = Flask(__name__) 

    def get_client_cert():
        # code to load client certificate and private key.
        return client_cert_bytes, client_private_key_bytes


    @app.route('/', methods=['GET']) 
    def pubsub():
        publisher = pubsub_v1.PublisherClient()
        topic_path = publisher.topic_path(project_id, topic_id)
        for n in range(1, 2):
            f = open("messages_server.txt", "r")
            data_str = f.read()
            data = data_str.encode("utf-8")
            print(data)
            future = publisher.publish(topic_path, data=data,retry=Retry(deadline=24))
            print(future.result())
            print(f"Published messages to {topic_path}.")
        return json.dumps({'success':True}), 200, {'ContentType':'application/json'}
            
        
    if __name__ == '__main__': 
        app.run(host="0.0.0.0",debug=True) 
    EOF
    python3 flask_server.py ${var.project_id} &
  EOT 

}