# Quick Start Guide


## Provision the environment

1. The GCP user to create the environment for the experiment should have the permissions to impersonate the terraform service account used to create the resources.
```
    Service Account Token Creator
    Service Account User
    Servie Uasge Admin
    Storage Admin
    Kubernetes Engine Cluster Admin
```

2. Here is the directory structure where you can find the scripts to create environments, run experiments, and clean up.
```
$ROOT_FOLDER_OF_THE_REPO
└── chaostoolkit-examples
    └── scripts
        ├── 1-initAll.sh
        ├── 2-provisionAll.sh
        ├── 3-1-cloudsql-cloudrun-dns-fault-injection-remote-run.sh    ───────────────────────────────────────┐    
        ├── 3-2-cloudsql-cloudrun-pbr-fault-injection-remote-run.sh    ──────────────────────────────────┐    │
        ├── 3-3-l7ilb-urlmap-fault-injection-remote-run.sh             ─────────────────────────────┐    │    │
        ├── 3-4-l7ilb-urlmap-fault-injection-gke-ssh-to-operator.sh    ────────────────────────┐    │    │    │
        ├── 3-5-pubsub-fault-injection-remote-run.sh                   ───────────────────┐    │    │    │    │
        └── 9-cleanupAll.sh                                                               │    │    │    │    │
                                                                                          │    │    │    │    │
                                                                                          │    │    │    │    │
/opt                                                                                      │    │    │    │    │
└──chaostoolkit-examples                                                                  │    │    │    │    │
   ├──pubsub-fault-injection                                                              │    │    │    │    │
   │  └──remote_run.sh                            <───────────────────────────────────────┘    │    │    │    │
   ├──l7ilb-urlmap-fault-injection-gke                                                         │    │    │    │    
   │  └──ssh_to_operator.sh                       <────────────────────────────────────────────┘    │    │    │
   ├──l7ilb-urlmap-fault-injection                                                                  │    │    │  
   │  └──remote_run.sh                            <─────────────────────────────────────────────────┘    │    │
   ├──cloudsql-cloudrun-pbr-fault-injection                                                              │    │ 
   │  └──remote_run.sh                            <──────────────────────────────────────────────────────┘    │
   └──cloudsql-cloudrun-dns-fault-injection                                                                   │ 
      └──remote_run.sh                            <───────────────────────────────────────────────────────────┘    

```

3. You can use the following command to init the GCS backend and provision all the the environments for the chaos experiments.

```
cd scripts
./1-initAll.sh
./2-provisionAll.sh
```

## Run the experiments

You can run all the experiments one by one in any order.


1. Run Cloud SQL Experiment - DNS
```
./3-1-cloudsql-cloudrun-dns-fault-injection-remote-run.sh
```

Expect the [output](.readme/cloudsql-experiment.md)


2. Run Cloud SQL Experiment - PBR
```
./3-2-cloudsql-cloudrun-pbr-fault-injection-remote-run.sh
```

Expect the [output](.readme/cloudsql-experiment.md)


3. Run Load Balancer Experiment on GCE

```
./3-3-l7ilb-urlmap-fault-injection-remote-run.sh
```

Expect the [output](.readme/l7b-experiment.md)


4. Run Load Balancer Experiment on GKE

```
./3-4-l7ilb-urlmap-fault-injection-gke-ssh-to-operator.sh
```

On the operator, 
```
./gke-deploy.sh
./kubectl_logs.sh 
```

You may need to run `./kubectl_logs.sh` many times for the experiment to finish.

Expect the [output](.readme/l7b-experiment.md).

4. Run Pub/Sub Experiment

```
./3-4-pubsub-fault-injection/remote_run.sh
```

Expect the [output](.readme/pubsub-experiment.md)

## Clean up

After running all the experiments, you can run the following command to clean up the entire environment.

```
./9-cleanupAll.sh
```

That's it.

Let us dive in.

1. [Cloud SQL Experiement using DNS Fault Injection](cloudsql-cloudrun-dns-fault-injection/README.md)
2. [Cloud SQL Experiement using PBR Fault Injection](cloudsql-cloudrun-pbr-fault-injection/README.md)
3. [Load Balancer Experiment running on GCE](l7ilb-urlmap-fault-injection/README.md)
4. [Load Balancer Experiment running on GKE](l7ilb-urlmap-fault-injection-gke/README.md)
5. [Pub/Sub Experiment](pubsub-fault-injection/README.md)
