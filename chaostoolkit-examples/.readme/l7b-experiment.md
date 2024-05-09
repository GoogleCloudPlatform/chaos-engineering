```
[2024-03-11 16:44:49 INFO] Validating the experiment's syntax
[2024-03-11 16:44:50 INFO] Experiment looks valid
[2024-03-11 16:44:50 INFO] Running experiment: What is the impact of introducing fault in L7 ILB for a backend  service's traffic
[2024-03-11 16:44:50 INFO] Steady-state strategy: default
[2024-03-11 16:44:50 INFO] Rollbacks strategy: default
[2024-03-11 16:44:50 INFO] Steady state hypothesis: Application responds
[2024-03-11 16:44:50 INFO] Probe: app responds without any delays
[2024-03-11 16:44:50 INFO] Steady state hypothesis is met!
[2024-03-11 16:44:50 INFO] Playing your experiment's method now...
[2024-03-11 16:44:50 INFO] Action: inject-fault-in-i7ilb
[2024-03-11 16:45:01 INFO] Pausing after activity for 25s...
[2024-03-11 16:45:26 INFO] Steady state hypothesis: Application responds
[2024-03-11 16:45:26 INFO] Probe: app responds without any delays
[2024-03-11 16:45:26 CRITICAL] Steady state probe 'app responds without any delays' is not in the given tolerance so failing this experiment
[2024-03-11 16:45:26 INFO] Let's rollback...
[2024-03-11 16:45:26 INFO] Rollback: rollback-fault-in-i7elb
[2024-03-11 16:45:26 INFO] Action: rollback-fault-in-i7elb
[2024-03-11 16:45:40 INFO] Experiment ended with status: deviated
[2024-03-11 16:45:40 INFO] The steady-state has deviated, a weakness may have been discovered
```
