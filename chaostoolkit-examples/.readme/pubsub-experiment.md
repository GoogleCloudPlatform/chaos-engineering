```
[2024-03-11 16:46:10 INFO] Validating the experiment's syntax
[2024-03-11 16:46:12 INFO] Experiment looks valid
[2024-03-11 16:46:12 INFO] Running experiment: What is the impact of introducing fault in Pubsub using private google access
[2024-03-11 16:46:12 INFO] Steady-state strategy: default
[2024-03-11 16:46:12 INFO] Rollbacks strategy: default
[2024-03-11 16:46:12 INFO] Steady state hypothesis: Application responds
[2024-03-11 16:46:12 INFO] Probe: python process running and returning 
[2024-03-11 16:46:12 INFO] Steady state hypothesis is met!
[2024-03-11 16:46:12 INFO] Playing your experiment's method now...
[2024-03-11 16:46:12 INFO] Action: set network tag for instance
[2024-03-11 16:46:16 INFO] Pausing after activity for 5s...
[2024-03-11 16:46:21 INFO] Steady state hypothesis: Application responds
[2024-03-11 16:46:21 INFO] Probe: python process running and returning 
[2024-03-11 16:46:44 CRITICAL] Steady state probe 'python process running and returning ' is not in the given tolerance so failing this experiment
[2024-03-11 16:46:44 INFO] Let's rollback...
[2024-03-11 16:46:44 INFO] Rollback: set network tag for instance
[2024-03-11 16:46:44 INFO] Action: set network tag for instance
[2024-03-11 16:46:48 INFO] Pausing after activity for 5s...
[2024-03-11 16:46:53 INFO] Experiment ended with status: deviated
[2024-03-11 16:46:53 INFO] The steady-state has deviated, a weakness may have been discovered
```