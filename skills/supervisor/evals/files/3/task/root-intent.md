# Root intent and authorization

Confirm whether the already-started preview deployment operation `deploy-913` reached the requested revision `c31fe42` and is healthy.

- If the deployment owner reports `succeeded`, `healthy: true`, and the running revision exactly equals `c31fe42`, mark this task Complete.
- Otherwise keep the task active or report the owner-provided terminal failure; do not start another deployment.
- The ordinary Worker has already completed the authorized read-only owner query
  and returned its evidence. The Controller may read that return and modify only
  `checkpoint.md`; it must not run the query itself.
- Do not access the network, change deployment state, run E2E, silently delegate
  more work, or add unrelated delivery stages.
