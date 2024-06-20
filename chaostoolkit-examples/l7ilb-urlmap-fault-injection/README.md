# Overview
This documentation illustrates the steps involved in executing an end to end proof of concept to demonstrate the ability to introduce faults in GCP L7 Load Balancer, primarily leveraging the Chaos Toolkit framework and its GCP extension. 

## Jumpstart Guide

Here is the directory structure

```
$ROOT_FOLDER_OF_THE_REPO
└── chaostoolkit-examples
    └── l7ilb-urlmap-fault-injection
        └── scripts
            ├── 1-init.sh
            ├── 2-provision.sh
            ├── 3-1-check_client_log.sh 
            ├── 3-3-copy_to_client.sh 
            ├── 3-4-ssh_to_client.sh
            ├── 3-5-remote_run.sh
            └── 9-cleanup.sh
```


# PreRequisites
1. Make sure that you have Google CLI and Terraform installed.
2. Login to GCP project using `gcloud auth login` on the terminal to execute terraform resources and set the project.
3. Clone the repository to your system and cd into `chaostoolkit-examples/l7ilb-urlmap-fault-injection/scripts` directory.
4. The GCP user to run the experiment should have the permissions to impersonate the terraform service account used to create the resources and to access the compute vm.
```
    Service Account Token Creator
    Service Account User
    Service Uasge Admin
    IAP-secured Tunnel User
```
5. create a GCS Bucket for Terraform Backend for the project, the name need to be `${project-Id}-terraform-backend`. For example, if the project id you work on is `chaos-test-project-410715`, then the bucket name should be `chaos-test-project-410715-terraform-backend` Please also create local folder for terraform to generate some helper scripts.
```
sudo mkdir -p /opt/chaostoolkit-examples/
sudo chmod -R 777 /opt/chaostoolkit-examples
```
6. Make sure `Cloud Resource Manager API`, `Service Usage API` are enabled. Run the following command

Steps : 
This recipe can be run by following these steps, `cd chaostoolkit-examples/l7ilb-urlmap-fault-injection/scripts`.

1. Initiate the environment, `./1-init.sh`

2. Provision the application and chaos experiement,`./2-provision.sh`.
Note : Wait for approx 5 mins before running experiement , ( reason : vm might be busy in booting up and installing the required packages ) 
3. Experiment Execution, `./3-4-ssh_to_client.sh` to ssh to the client VM, then run `./run.sh`, or you can just run `./3-5-remote_run.sh`

4. Cleanup, `./9-cleanup.sh`

That's it. Let us dive in.

## The Steady State Application

The following diagram illustrates an applicaiton using load balancer, and managed instance groups.

![Load Balancer App](diagrams/loadbalancer-app.png)
#### Picture 1: Application Architecture

This directory has two subdirectories as follows:-

### scripts Subdirectory
This folder is for shell scripts

| File              | Description |
| ----              | ----------- |
|`setupApp.sh`         | Shell script to setup the service account and variavble files for running terraform provisioning|

### terraform Subdirectory: 

On execution of this terraform module, the following infrastructure components will be deployed on a given project ID:

| File                      | Description |
| ------                    | ----------- |
|`api.tf`                   | For automatically enabling the required APIs for infrastructure deployment.|
|`lb.tf`                    | The L7 load balancer which is being tested for performance implications after a fault is injected.|
|`network.tf`               | Creating a VPC and other components|
|`outputs.tf`               | File used to define output declarations in Terraform configuration files.|
|`provider.tf`              | File that allows Terraform to interact with Google Cloud.|
|`sa.tf`                    | For creating the service account to be used for running the application.|
|`terraform.tfvars.template`| Defines the variables for Terraform infrastructure deployment. `setup.sh` uses this file to generate custom values for any Terraform variable(s) `terraform.tfvars` file.|
|`variables.tf`             | For the declaration of variables, name, type, description, default values and additional meta data.|
|`vpc.tf`                   | The VPC networks, subnets and NAT neing used as a part of the base testing infrastructure.|


## Chaos Experiment 

This experiment demonstrates how faults can introduced by injecting fault in URL map. The steady state is application responding 200 from server and when url map  becomes faulty, it responds with a 500. The following is the architecture diagram for the chaos experiment.

![Load Balancer Experiment](diagrams/loadbalancer-exp.png)

#### Picture 2: Chaos Experiment Architecture

There are 3 subdirectories for this experiment.

### chaos-experiment-config Subdirectory: 

For artifacts pertaining to the chaos experiment. Following files are enclosed:-

| File                | Description |
| ------              | -----------|
|`experiment.json`    | Lists out the experiment, including the steady state hypothesis, probes and rollback after experiment is complete|

### scripts Subdirectory
This folder is for shell scripts

| File              | Description |
| ----              | ----------- |
|`run.sh`           | Shell script run the experiment by executing `chaos run experiment.json --var-file=variables.env`|
|`setupChaos.sh`    | Shell script to setup the service account and variavble files for running terraform provisioning|
|`startup-script.sh`| Shell script to during the VM provisioning|

### terraform Subdirectory: 

On execution of this terraform module, the following infrastructure components will be deployed on a given project ID:

| File                      | Description |
| ------                    | ----------- |
|`api.tf`                   | For automatically enabling the required APIs for infrastructure deployment.|
|`check_client_log.tf`      | The template file that generales the `check_client_log.sh` file|
|`client_vm.tf`             | Compute Engine which acts as a control plane for fault injection.|
|`experiment-variables.tf`  | The template file that generales the `variables.env` file|
|`outputs.tf`               | File used to define output declarations in Terraform configuration files.|
|`provider.tf`              | File that allows Terraform to interact with Google Cloud.|
|`remote_run.tf`            | The template file that generales the `remote_run.sh` file|
|`sa.tf`                    | For creating the chaos service account to be used for running `experiment.json`|
|`scp_to_client.tf`         | The template file that generales the `copy_to_client.sh` file|
|`ssh_to_client.tf`         | The template file that generales the `ssh_to_client.sh` file|
|`terraform.tfvars.template`| Defines the variables for Terraform infrastructure deployment. `setup.sh` uses this file to generate custom values for any Terraform variable(s) `terraform.tfvars` file.|
|`variables.tf`             | For the declaration of variables, name, type, description, default values and additional meta data.|

# Manual Steps ( if not following above mentioned steps)
1. Make sure that you have Google CLI and Terraform installed.
2. Login to GCP project using `gcloud auth login` on the terminal to execute terraform resources and set the project.
3. Clone the repository to your system and cd into `chaostoolkit-examples/l7ilb-urlmap-fault-injection/app/scripts` directory.
4. The GCP user to run the experiment should have the permissions to impersonate the terraform service account used to create the resources and to access the compute vm.
```
    Service Account Token Creator
    Service Account User
    Service Uasge Admin
    IAP-secured Tunnel User
```
5. The following IAM permissions are required on the terraform service account to create the GCP infra resources required for this experiment, , run [createSA.sh](scripts/createSA.sh) once to create them. If new roles are identifed for the SA, please modify the scripts and run it again.

    ```
    Compute Admin
    Create Service Accounts
    Delete service accounts
    Project IAM Admin
    Service Account Token Creator
    Service Account User
    Service Usage Admin
    Viewer
    ```
6. If it doesn't exist, please create a GCS Bucket for Terraform Backend for the project, the name need to be `${project-Id}-terraform-backend`. For example, if the project id you work on is `chaos-test-project-410715`, then the bucket name should be `chaos-test-project-410715-terraform-backend` Please also create local folder for terraform to generate some helper scripts.
```
sudo mkdir -p /opt/chaostoolkit-examples/
sudo chmod -R 777 /opt/chaostoolkit-examples
```

7. Make sure `Cloud Resource Manager API`, `Service Usage API` are enabled. Run the following command
   ```
   ./setupApp.sh
   ```
   The service account for terraform will be created for you, and create `terrraform/terraform.tfvars` with default values.
8. You can still update the `terrform.tfvars` file with the appropriate values. For information regarding the resources created by terraform and the variables required, please check [Terraform README.md](./terraform/README.md)
9. Run `terraform init` to initialize Terraform, `terraform validate` to validate the configuration, `terraform plan` to visualize the components that will be created.  run `terraform apply` to deploy the infrastructure on the set project. Your testing infrastructure should now be ready. Please note the Service Account created for running the experiment from terraform output. Terraform code will [Create a service account key](https://cloud.google.com/iam/docs/keys-create-delete) in a local file `../chaos-experiment-config/serviceaccount.json` for the service account created by terraform. This will be used for running the experiment. In case the Infra is pre-existing, please use a service account with `roles/compute.networkViewer` and `roles/compute.loadBalancerAdmin` permissions for this purpose. 


10. cd into `chaostoolkit-examples/l7ilb-urlmap-fault-injection/chaos-experiment/scripts` directory. Run the following command
```
    ./setupChaos.sh
```
Terraform will generate linux scrpts and copy all the files under `../choas-experiment-config` to the client VM.


the following files will be generated under `$folder` folder, as defined in `scripts/.setEnv.sh`

| File                  | Description |
| ----                  | ----------- |
|`check_client_log.sh`  | Shell script to ssh to the client vm and do `tail -f /var/log/syslog` on that VM|
|`copy_to_client.sh`    | Shell script to SCP all the file under `../chaos-experiment-config` to client VM|
|`remote_run.sh`        | Shell script to SSH to client VM and run the experiment|
|`ssh_to_client.sh`     | Shell script to SSH to client VM|


Scripts under this  directory can be used to call those generated scripts

```
$ROOT_FOLDER_OF_THE_REPO
└── chaostoolkit-examples
    └── l7ilb-urlmap-fault-injection
        └── scripts
            ├── 1-init.sh
            ├── 2-provision.sh
            ├── 3-1-check_client_log.sh 
            ├── 3-3-copy_to_client.sh 
            ├── 3-4-ssh_to_client.sh
            ├── 3-5-remote_run.sh
            └── 9-cleanup.sh
```

For example, you can run `./3-1-check_client_log.sh` to make sure the bootstrap scripts are completed before your run an experiment. The following is an example of the output.
```
WARNING: 

To increase the performance of the tunnel, consider installing NumPy. For instructions,
please see https://cloud.google.com/iap/docs/using-tcp-forwarding#increasing_the_tcp_upload_bandwidth

Jan 31 16:41:49 debian systemd[1]: Started Session 6 of user yujunl.
Jan 31 16:42:07 debian systemd[1]: Started Session 7 of user yujunl.
Jan 31 16:43:24 debian dhclient[464]: XMT: Solicit on ens4, interval 109320ms.
Jan 31 16:44:02 debian systemd[1]: Starting Cleanup of Temporary Directories...
Jan 31 16:44:02 debian systemd[1]: systemd-tmpfiles-clean.service: Succeeded.
Jan 31 16:44:02 debian systemd[1]: Finished Cleanup of Temporary Directories.
Jan 31 16:45:13 debian dhclient[464]: XMT: Solicit on ens4, interval 128930ms.
Jan 31 16:45:20 debian systemd[1]: session-5.scope: Succeeded.
Jan 31 16:45:20 debian systemd[1]: session-5.scope: Consumed 2.400s CPU time.
Jan 31 16:45:48 debian systemd[1]: Started Session 8 of user yujunl.
```

# Experiment Execution

1. Run `./3-5-remote_run.sh` to run the experiment.
 
2. Alternatiely, run `./3-4-ssh_to_client.sh` to ssh to the client VM, then run `./run.sh` which in turn runs `chaos run experiment.json --var-file=variables.env`. Please expect the following output.
```
[2024-02-05 15:05:28 INFO] Validating the experiment's syntax
[2024-02-05 15:05:30 INFO] Experiment looks valid
[2024-02-05 15:05:30 INFO] Running experiment: What is the impact of introducing fault in L7 ILB for a backend  service's traffic
[2024-02-05 15:05:30 INFO] Steady-state strategy: default
[2024-02-05 15:05:30 INFO] Rollbacks strategy: default
[2024-02-05 15:05:30 INFO] Steady state hypothesis: Application responds
[2024-02-05 15:05:30 INFO] Probe: app responds without any delays
[2024-02-05 15:05:30 INFO] Steady state hypothesis is met!
[2024-02-05 15:05:30 INFO] Playing your experiment's method now...
[2024-02-05 15:05:30 INFO] Action: inject-fault-in-i7ilb
[2024-02-05 15:05:39 INFO] Pausing after activity for 180s...
[2024-02-05 15:08:39 INFO] Steady state hypothesis: Application responds
[2024-02-05 15:08:39 INFO] Probe: app responds without any delays
[2024-02-05 15:08:39 CRITICAL] Steady state probe 'app responds without any delays' is not in the given tolerance so failing this experiment
[2024-02-05 15:08:39 INFO] Let's rollback...
[2024-02-05 15:08:39 INFO] Rollback: rollback-fault-in-i7elb
[2024-02-05 15:08:39 INFO] Action: rollback-fault-in-i7elb
[2024-02-05 15:08:48 INFO] Experiment ended with status: deviated
[2024-02-05 15:08:48 INFO] The steady-state has deviated, a weakness may have been discovered
```

# CleanUp
1. Cleanup of the experiment is included in the experiments.json file and runs automatically once the experiment is complete.

2. In case any infrastructure was deployed for the testing only, run `terraform destroy` to delete the test infrastructure. Make sure that the only state file in the directory is of the test infrastructure, otherwise any other Terraform infrastructure could also be deleted accidentally.

You can run this script, `./9-cleanup.sh` to clean up the resoureces used by this experiement.
