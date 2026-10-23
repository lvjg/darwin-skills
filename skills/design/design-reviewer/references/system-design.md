# System Design Review Methods

Read this reference when a pivotal judgment involves reuse versus new construction, borrowed external methods, uncommitted external contract changes, cross-boundary budgets and cost transfer, or migration and cutover.

## 1. Reuse, Extension, and Borrowed Methods

Trace actual runtime wiring—entrypoints, configuration, credentials, timeouts, schemas, and consumers—rather than inferring capability from component names or inactive code.

Before accepting custom logic, a new dependency, durable state, or a new execution path, compare direct use of an existing maintained capability, a bounded extension at the current semantic owner, and the smallest new capability with complete semantics and lifecycle. Reject reuse or extension when it distorts the owner's contract or leaks behavior to unrelated consumers. Reject new construction when an existing maintained capability already closes the obligation or when the proposal creates parallel state, configuration, or authority without an active coexistence need and exit path.

When a proposal adapts an external algorithm, paper, or architectural pattern, test each assumption the source relies on—data distribution, workload scale, consistency model, latency or compute budget, or human fallback—against current-system facts, and verify that any prerequisite or recovery work left unspecified by the source is closed locally.

## 2. External Contract Authority, Budgets, and Heavy Machinery

Trace every external contract mutation (wire fields, semantics, versioning, or release order) to its semantic owner, active consumers, and the authority required to commit it. Before auditing persistence, migration, or rollback machinery that depends on an external contract change, first test whether the unchanged contract plus a local mapping at the integration boundary suffices. Until the external semantic owner accepts the mutation, treat that acceptance as an explicit gate and do not audit downstream machinery that assumes the mutation is already committed.

Check how composed components interact under load and failure:

- **End-to-end budgets and cost transfer:** compare response latency budgets against synchronous downstream timeouts, retry windows against deduplication or idempotency TTLs, and resource limits against contention or batch sizes. Verify that a local simplification does not silently shift polling, manual reconciliation, lost context, or lock contention to callers, operators, or users.
- **Premise reset on heavy machinery:** before auditing the internal failure modes of durable copies, outboxes, retry coordinators, reconciliation jobs, compatibility readers, or generic engines, apply the core review's mechanism-necessity test to the root concern. If an existing capability or simpler allowed failure semantic satisfies the obligation (or if the guarantee is an unresolved user-owned tradeoff), challenge or surface that root choice first and drop derivative findings that exist only to maintain the extra machinery. Never waive active consumers, durable business facts, committed external effects, security boundaries, or cleanup obligations.

## 3. Stateful Transition and Cutover

For stateful or cross-boundary replacements, trace `failure or deployment state -> resulting durable state and external effect -> what the next reader, retry, or mixed-version consumer observes -> who owns recovery` before supporting implementation or cutover.

A transition design is defective when a required intermediate state violates an invariant, when deployment order or mixed consumers cannot coexist, or when partial completion leaves a durable fact or committed effect ambiguous. When rollback is intentionally unavailable after cutover, require the design to establish the last safe rollback point, the gate that admits irreversible mutation, recovery before it, and forward recovery afterward. Keep one-time backfill, validation, and migration in transition tooling with an explicit owner, verification check, and removal condition rather than in permanent runtime structure.
