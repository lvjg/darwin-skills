# Archived R1 proposal and review

This is a synthetic prior-round record supplied separately from the R2 author's proposal. The review goal and the responsibility facts cited below remain the same in the supplied current snapshot. Other R2 claims must be assessed against their own evidence.

## Complete R1 proposal

The conversation service interprets a business document and orchestrates workflow-service primitives to produce a template draft. Existing `sop-create` continues to consume published templates only.

The workflow service owns draft persistence, validation, compilation, publication and runtime semantics. The model uses typed authoring operations; it does not submit raw BPMN or expressions. Publication remains a separate signed, human-confirmed application action.

The proposed authoring operations are:

1. Read the available authoring capabilities.
2. Create an empty draft and read its current contents.
3. Add nodes and edges one at a time, using the existing structure operation after each addition.
4. Replace one node's configuration, including its direct edge conditions.
5. Finalize the draft, then let the signed application path request publication.

Every mutation uses request-key idempotency and draft revision compare-and-swap. The draft should retain the source revision for later editing; storage, readers and retention semantics have not yet been designed.

## Independent R1 review

Decision: not ready as an implementation basis.

- The responsibility split agrees with `root-intent.md` and the first two observations in `current-system.md` under “Responsibility and runtime facts”. Keep the existing instance-creation consumer separate from template authoring.
- The typed model interface and separate signed human publication path agree with the third observation in that section. These choices need no new publication authority.
- The source-retention proposal does not yet explain what later work requires it or how that work uses it. Establish its purpose and mechanism before treating the retained state as justified.
- Incrementally submitting an empty or partially constructed graph conflicts with `current-system.md` under “Existing authoring behavior”: structure input must already have a unique start, a terminal node and full reachability. The proposed sequence does not show how it reaches the first accepted complete graph.

This review did not assess the later R2 additions. Its conclusions apply only where the cited requirement, mechanism and current-system fact remain unchanged.
