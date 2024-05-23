# Chaos-Engineering

What is Chaos Engineering?
Chaos engineering is a methodology that emerged in response to the need to build more resilient and reliable systems in the face of increasing complexity. The core idea is simple: intentionally introduce controlled chaos into a system to uncover vulnerabilities, assess its robustness, and improve its overall reliability.
The core principles of Chaos Engineering include:

# Define Steady State
   First, you need to define what "normal" looks like for your system. This involves understanding the metrics, behaviors, and performance characteristics that indicate your system is running smoothly.

# Introduce Chaos
   Next, you introduce controlled chaos, often through techniques like network latency, server failures, or resource depletion, to disrupt your system.

# Monitor and Analyze
   While chaos is introduced, you closely monitor the system to identify how it behaves under stress and to detect any anomalies.

# Learn and Iterate
   The insights gained from these experiments are used to make improvements, update runbooks, and better prepare your system for real-world failures.

Chaos Engineering isn't about breaking things for the sake of it but about building more resilient systems by understanding their limitations and addressing them proactively.

# Chaos Toolkit
The Chaos Toolkit is an open-source platform that empowers engineers to perform Chaos Engineering experiments in a structured and automated way. It provides a framework for defining and executing chaos experiments using simple JSON or YAML configurations. The Chaos Toolkit supports a wide range of "probes",  “actions” and "steady states" (system conditions) that can be combined to create complex and meaningful experiments.

Some key features of Chaos Toolkit include:

# Extensibility
  It's easy to create custom extensions to support various systems and platforms.

# Reproducibility
  Chaos experiments are defined in configuration files, making them reproducible and shareable.

# Observability
  The Chaos Toolkit encourages the collection of metrics and events during experiments to gain insights into system behavior.

# Integration
  It can be seamlessly integrated with various monitoring and orchestration tools.

# Chaos Toolkit GCP Extension
The Chaos Toolkit extends its reach to Google Cloud Platform through a dedicated extension, allowing you to perform chaos experiments in the GCP environment. This extension provides chaos actions and steady states tailored to GCP services, making it easier to test the resilience of your GCP-hosted applications.

Some advantages of using the Chaos Toolkit with the GCP extension include:

# Native GCP Support
  You can directly target GCP services like Google Compute Engine, Kubernetes Engine, Pub/Sub, and more in your chaos experiments using Google Cloud Python libraries.

# Enhanced Reliability
  Test how your applications and infrastructure on GCP respond to real-world disruptions, helping you uncover and address weaknesses.

# Automation
  Automate the execution of chaos experiments to ensure consistent and frequent testing of your GCP environment.

 # Please note: This is not an officially supported Google product.


This repo contains examples on how to perform Chaos Engineering using Chaos Toolkit and its GCP extension.


