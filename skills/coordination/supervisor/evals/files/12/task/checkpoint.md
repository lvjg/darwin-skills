# Preview deployment checkpoint

- Task: `connector-preview-9fd72b4`
- State: `Active`
- Revision: `4`

## Result and acceptance boundary

Deploy revision `9fd72b4` to `internal-preview`; completion requires the deployment Owner to report a healthy running revision exactly equal to `9fd72b4`.

## Authorization and governing facts

- Preview deployment is authorized.
- The current user does not own platform roles or credentials.
- Preview Platform Operations owns the deployment identity and its `preview.deploy` permission.

## Open obligations

- [ ] Start the authorized deployment and obtain its stable operation reference.
- [ ] Prove the healthy running revision from the deployment Owner.

## Current action

- Owner: another ordinary deployment Worker
- Inputs: revision `9fd72b4`, environment `internal-preview`
- Expected result: accepted deployment operation
- Stop condition: return the operation reference or a bounded owner-provided blocker

## Valid conclusions and evidence

- The first Worker returned that the deployment identity lacks `preview.deploy`; no operation was created.
