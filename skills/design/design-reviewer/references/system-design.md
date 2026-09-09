# System Design Review Methods

Read this reference when a pivotal conclusion involves cross-boundary integration, durable state, capability choice, ownership, failure recovery, compatibility, migration, or cutover. Apply only the methods that can change the design judgment.

## Capability and Current-System Fit

Verify concrete selection and consumption rather than inferring capability from names, interfaces, files, dependencies, or inactive components. Trace relevant entrypoints through configuration, composition, credentials, process wiring, defaults, timeouts, cancellation, producers, consumers, schemas, and durable work to the observable result.

Before accepting custom code, a dependency, durable state, abstraction, or runtime path, compare:

1. direct use of the current maintained capability;
2. extension at the boundary that owns the behavior;
3. the smallest new capability with complete semantics and lifecycle.

Reuse is wrong when similarity is superficial, extension distorts the owner or contract, unrelated consumers inherit the change, or its lifecycle burden exceeds a narrow stable implementation. New construction is wrong when it duplicates a maintained capability, creates parallel authority, configuration, execution, or operational paths without an active coexistence obligation and exit, or reimplements externally evolving or security-sensitive behavior that a maintained dependency already owns. Judge dependency fit against the required behavior, contracts, failure semantics, project architecture, runtime, security, license, and lifecycle rather than feature names alone.

## Scope, Contract, and Authority

Trace each external contract change to the boundary responsible for its final meaning and conflict resolution (its semantic owner), actual consumers, and authority to request or commit the change. When a proposal changes a wire field, field meaning, version, or release sequence outside the authorized boundary, do not assume its dependent persistence, migration, compatibility, rollback, and recovery chain is required until that mutation is accepted or committed.

First test the unchanged external contract and the simplest viable mapping at the system-owned integration boundary. If mapping semantics are unknown, keep that choice and only its dependent conclusions open. Once a contract mutation is committed, derive compatibility, coexistence, cutover, and retirement obligations from the real consumers and release sequence. Ordinary mappings that preserve the external contract do not trigger a migration design by themselves.

Acceptance by the semantic owner may remain an explicit implementation or cutover gate without invalidating an earlier route decision to seek that acceptance. Until acceptance is established, do not audit machinery that depends only on treating the proposed external mutation as committed.

A non-goal limits proactive construction but cannot exclude a consequence caused by the proposal. Possible future consumers, expected growth, cleanup convenience, or option value do not justify platformization unless a current irreversible or path-dependent choice makes deferral materially unsafe or more costly.

## Responsibility, State, and Boundaries

Require one semantic owner for each material decision, authoritative fact, transition, side effect, failure response, and recovery rule. Multiple sources, writers, replicas, or executors are coherent only when one owner defines arbitration, consistency, conflict, and recovery semantics. Call order, data possession, dependency injection, or names such as Manager, Service, and Orchestrator do not prove ownership.

Keep responsibilities together when they share an inseparable invariant, transaction, lifecycle, or failure response. Separate them when authority, trust, lifecycle, failure containment, or established variation materially differs. Do neither for symmetry, naming, file size, or hypothetical reuse.

Use a credible current or committed change to test placement. A business-rule change should primarily alter its semantic owner; a provider, transport, store, model, or channel change should not alter business decisions unless its real capability changes the required guarantee. An interface, event bus, configuration language, or extra layer reduces coupling only when it contains evidenced variation or failure propagation.

Also test the proposal's interacting choices for conflicting premises, cycles, implicit ordering or timeout protocols, and transferred cost or failure that no individual judgment exposes.

## Obligation Before Mechanism

Every established outcome, invariant, contract, and material failure response must be covered by an owner and existing or proposed behavior. Add a mechanism only for a proven coverage gap, and trace every long-lived mechanism back to that obligation.

Before auditing durable copies, retry coordinators, outboxes, replay, reconciliation, exactly-once machinery, compatibility readers, migrations, fallbacks, generic engines, or extension points, ask whether a simpler allowed failure semantic would delete the first mechanism and its derivative lifecycle. If the required guarantee is a user-owned choice, expose the tradeoff before completing the machinery.

Apply a premise reset whenever one concern keeps generating identities, versions, migration, draining, legacy readers, reconciliation, compatibility, or more recovery state:

1. identify the first mechanism;
2. establish the obligation that requires it;
3. test deletion under the allowed semantics;
4. invalidate all derivative findings if the obligation fails;
5. otherwise resume completeness review at the owning boundary.

Never use this reset to waive active consumers, durable business facts, committed external effects, security facts, safety obligations, or independent cleanup risks.

## Failure and Transition

For each applicable failure, establish the premise, action, resulting state, next dependency, authoritative fact, and recovery owner. Inspect interruption, retry, cancellation, concurrency, partial success, coexistence, rollback, forward recovery, cleanup, and exit only where the established semantics make them material.

A transition is defective when a necessary intermediate state is unreachable, violates an invariant, or cannot recover; when deployment order or mixed consumers cannot reach the target; or when partial completion leaves a durable fact or committed effect ambiguous. If rollback is intentionally removed, establish the last safe rollback point, the action that admits new mutation, recovery before it, and forward recovery afterward.

Keep one-time analysis, backfill, validation, and migration at transition or tooling boundaries rather than in permanent runtime structure. Each necessary temporary mechanism needs an owner, active consumer or contract, verification, exit condition, and deletion path.

## Simplicity and Required Quality

A simpler counterroute must preserve the same outcomes, constraints, authority, contracts, state semantics, failure behavior, quality requirements, and transition safety. Name the receiving owner and the concrete responsibilities, states, dependencies, or lifecycles removed. Fewer components alone is not better; simplification is underdesign when it loses a necessary owner, isolation boundary, lifecycle, or failure response.

Performance, scale, security, privacy, trust, reliability, observability, and operability are design defects only when an established constraint, threat, operating condition, or outcome makes them material. Locate the actual work, resource, trust boundary, failure, and dominant end-to-end cost at their owner. A plausible claim or local optimization proves neither defect nor benefit.

## Focused Methods

Select the smallest method that can overturn a pivotal judgment:

- **Active-path trace:** follow selected runtime paths forward to observable effects and backward through consumers, mixed versions, deployment, migration, rollback, recovery, and operator action.
- **Causal trace:** follow `choice -> owner, contract, state, dependency, lifecycle -> behavior and transition -> result`, then reason backward from outcomes and invariants.
- **Semantic ownership map:** identify the owner of each material decision, fact, transition, effect, failure response, and recovery rule.
- **State and failure simulation:** derive the resulting authoritative state and recovery behavior across applicable failure points.
- **Credible-change test:** apply a real or committed change and observe unnecessary propagation across boundaries.
- **Simpler counterroute:** delete, merge, directly own, reuse, or adopt a simpler allowed semantic while holding established obligations constant.

Do not complete every method as a checklist. Complete the applicable active path before supporting implementation authorization or a migration or cutover design for a system-level replacement or stateful cross-boundary change. For release, judge only whether the design specifies the necessary prerequisites; acceptance of the delivered release belongs to a later delivery review.
