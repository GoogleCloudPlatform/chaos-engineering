What is Chaos Engineering?
Chaos engineering is a methodology that emerged in response to the need to build more resilient and reliable systems in the face of increasing complexity. The core idea is simple: intentionally introduce controlled chaos into a system to uncover vulnerabilities, assess its robustness, and improve its overall reliability.
The core principles of Chaos Engineering include:

1. Define Steady State: First, you need to define what "normal" looks like for your system. This involves understanding the metrics, behaviors, and performance characteristics that indicate your system is running smoothly.

2. Introduce Chaos: Next, you introduce controlled chaos, often through techniques like network latency, server failures, or resource depletion, to disrupt your system.

3. Monitor and Analyze: While chaos is introduced, you closely monitor the system to identify how it behaves under stress and to detect any anomalies.

4. Learn and Iterate: The insights gained from these experiments are used to make improvements, update runbooks, and better prepare your system for real-world failures.

Chaos Engineering isn't about breaking things for the sake of it but about building more resilient systems by understanding their limitations and addressing them proactively.

This repo contains examples on how to perform Chaos Engineering using Chaos Toolkit and its GCP extension.

# chaos-engineering
