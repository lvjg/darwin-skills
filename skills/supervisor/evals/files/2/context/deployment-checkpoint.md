# Deployment checkpoint after interrupted waiting

- Checkpoint reference: `evals/files/2/context/deployment-checkpoint.md`
- Revision: 4
- Control state: Waiting
- Environment: `internal-preview`
- The preview deployment control plane is the deployment owner. It accepted
  revision `9ad41c2` and returned operation ID `deploy-842`.
- The operation-status API is the authoritative source for `queued`, `running`, `succeeded` and `failed`, including the resulting running revision on success.
- A previous 60-second wait for `deploy-842` timed out without a terminal response.
- No cancellation, failure, rollback or running-revision result was observed.
- The status API remains available for a read-only query, but this fixture stops before any external query is made.
- No other deployment operation is known to be active.

Supervisor must choose the next guarded causal action without treating the timeout as failure or starting a duplicate deployment.
