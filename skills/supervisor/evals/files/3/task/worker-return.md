# Worker return

- Responsibility: read-only query of the deployment owner's supplied status source
- Authoritative evidence: `deployment-state.json`
- Observed operation: `deploy-913`
- Observed status: `succeeded`
- Requested revision: `c31fe42`
- Running revision: `c31fe42`
- Healthy: `true`
- Artifact changes: none
- External side effects: none
- Active descendant operations: none
- Unknowns: none for the requested completion judgment
- Invalidated conclusion: the prior `running` observation and timeout-based suggestion to redeploy
- Next-worker context: none; this is a terminal result if the evidence satisfies the original query handoff
