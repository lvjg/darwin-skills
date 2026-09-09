# Accepted delivery contract

The candidate should implement the accepted typed authoring route across the conversation service and workflow service.

- Node, Node Field and Edge have typed CRUD operations and stable keys.
- Mutations use revision compare-and-swap and request-key idempotency.
- The workflow service owns resource validation, dependency conflicts, deterministic cascades, compilation and publication.
- The conversation tool reconciles every mutation result with an authoritative draft reread. When a mutation has a material result such as a cascade summary, that result remains visible to the Agent together with the reread draft.
- `applicant`, `fixed_user` and `fixed_candidates` are all accepted authoring inputs for this client. The capability catalog is the complete public source for those configurations.
- The two services share one public contract for accepted and returned values.
- Finalize and signed publication remain separate; the model cannot publish.
- Existing publication replay, rollback and concurrency guarantees must remain supported and have discriminating proof at the persistent owning boundary.

The requested next action is a local commit if the exact candidate satisfies this contract. E2E and external product-journey acceptance are outside this delivery.

`tool-registration.ts` is the selected Agent tool binding. `authoring-client.ts` is the selected capability gate and mutation-reread decoder path; a successful `updateNode` commits workflow state before `getNode` is decoded.
