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
#
# Important:
#
#   When you modify this file, please uncomment #always_run
#   in ../terraform/cloudrun.tf file to enable the build.
#
import os

from google.cloud.sql.connector import Connector, IPTypes
from google.cloud import secretmanager
import pg8000
import pymysql

import socket
import sqlalchemy
from flask import Flask

app = Flask(__name__)

def get_secret(name):
    print("1------------------")
     # Create the Secret Manager client.
    client = secretmanager.SecretManagerServiceClient()


    print("3------------------")
    # Access the secret version.
    response = client.access_secret_version(request={"name": name})

    # Print the secret payload.
    #
    # WARNING: Do not print the secret in a production environment - this
    # snippet is showing how to access the secret material.
    return response.payload.data.decode("UTF-8")

@app.route("/")
def connect_tcp_socket() -> sqlalchemy.engine.base.Engine:

    """Initializes a TCP connection pool for a Cloud SQL instance of MySQL."""
    # Note: Saving credentials in environment variables is convenient, but not
    # secure - consider a more secure solution such as
    # Cloud Secret Manager (https://cloud.google.com/secret-manager) to help
    # keep secrets safe.
    db_host = os.environ.get("db_host")
    db_name = "mysql" 
    db_port = 3306 

    # IP lookup from hostname
    print(f'The {db_host} IP Address is {socket.gethostbyname(db_host)}')
    print("2------------------")
    project_id = os.environ.get("project_id")
    
    # Build the resource name of the secret version.

    pool = sqlalchemy.create_engine(
        # Equivalent URL:
        # mysql+pymysql://<db_user>:<db_pass>@<db_host>:<db_port>/<db_name>
        sqlalchemy.engine.url.URL.create(
            drivername="mysql+pymysql",
            username=get_secret(f"projects/{project_id}/secrets/db-user-pbr/versions/1"),
            password=get_secret(f"projects/{project_id}/secrets/db-password-pbr/versions/1"),
            host=db_host,
            port=db_port
        ),
        # ...
    )
    res={}
    with pool.connect() as db_conn:

    # query and fetch ratings table
        try:
            res= db_conn.execute(sqlalchemy.text("CREATE DATABASE testdb;"))
        except:
            print("database already created")
        try:
            res= db_conn.execute(sqlalchemy.text("USE testdb;"))
        except:
            print("already in database")
        try:
            res= db_conn.execute(sqlalchemy.text("CREATE TABLE employeetable (name VARCHAR(255), id INT)"))
        except:
            print("Already table is there")
        try:
            res= db_conn.execute(sqlalchemy.text("INSERT INTO employeetable (name, id) VALUES ('Peter', 1)"))
        except:
            print("Already data is present")
        try:
            res= db_conn.execute(sqlalchemy.text("INSERT INTO employeetable (name, id) VALUES ('John', 2)"))
        except:
            print("Already data is present")
        try:
           results = db_conn.execute(sqlalchemy.text("SELECT * FROM employeetable WHERE id=1")).fetchall()
        except:
            print("Select statement not working")
        
    return str(results)
    


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))
