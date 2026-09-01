# Product-journey acceptance context

The product capability converts supplied business text into a template, obtains signed human publication approval, then lets the existing instance Skill create and complete a workflow instance.

## Material journey obligations

- The real conversation entry produces a reviewable template candidate without model publication authority.
- Signed approval publishes exactly one searchable template.
- The existing instance Skill consumes the published template.
- A human candidate task starts unassigned; a backup candidate can claim it, and concurrent claims have one winner.
- A successful handling result reaches a confirmation task.
- Rejection at confirmation creates a new handling task with the rejection reason visible.
- Final approval reaches authoritative instance state `completed` with no current tasks.
- A deterministic stale publication request is rejected and replayed consistently; an ambiguous post-publication receipt is not presented as a deterministic rejection.

## Available verifier assets

- Owner-level contract and integration tests cover field schemas, revision compare-and-swap, request-key persistence, candidate identity limits, compiler validation, notification serialization and transaction rollback.
- An existing serial E2E runner contains 28 cases spanning many schema, validation, persistence, claim and recovery permutations. Individual cases can wait 60–300 seconds.
- A separate production-composition driver can enter through the conversation service, use the real workflow-service composition, correlate published template and instance identifiers, and observe task and instance state. Its journey shape and coverage disposition have not been chosen for this case.

## Acceptance-boundary limits

- The private source-document identity, real directory identities and real chat client are unavailable in this environment.
- Synthetic document content, directory identities and transport may be used diagnostically, but cannot prove those real external boundaries.
- The task authorizes planning the case set only. It does not authorize product writes, external publication or running E2E.
