---
name: code-simplifier
description: Use only when the user explicitly invokes $code-simplifier to optimize a bounded implementation candidate after its required behavior and preserved contracts are decided. Delete candidate surfaces without an established obligation, reuse existing capabilities and owners, and restructure required code to reduce coupling and total maintenance burden without choosing a new design, repairing unrelated defects, or expanding the authorized scope.
---

# Code Simplifier

Reduce a bounded implementation candidate to the lowest-total-burden complete implementation that delivers its decided behavior. Delete unsupported machinery; reuse, realign, directly simplify, or restructure required code so it fits established project responsibilities and contracts. Preserve required behavior, active contracts, affected failure semantics, user data, unrelated work, and distinctions that represent genuinely different policies.

Completion means that every material candidate surface is required by the result, a necessary consequence, or a preserved obligation; direct residue is closed; required code has fitting responsibility, cohesion, dependencies, and contracts; and the final candidate carries less total coupling, change propagation, implementation, and lifecycle burden without introducing a new design.

The sections below define required decisions and completion conditions, not a fixed execution sequence. Follow the candidate and its risks in whatever order yields the smallest complete intervention.

## Fix the Candidate and Behavior

Identify the exact candidate and comparison base: a working-tree diff, commit, pull request, patch, or explicitly bounded files or module. Record relevant dirty state, the authorized repository scope, and unrelated changes that must remain untouched.

Establish the required normal result, affected failure behavior, preserved contracts, intentional surface changes, and non-goals from the user's request, an accepted decision, or an active contract. Current code, tests, comments, implementation summaries, and historical plans are scoped evidence, not authority to define their own success.

The candidate must be complete enough to establish the behavior being preserved. If optimization requires choosing new product behavior, architecture, state ownership, a public contract, or repairing a material defect independent of the optimization, leave that boundary unchanged and report the prerequisite. Optimization authority covers the candidate and its direct consequences, not adjacent debt or a general implementation task.

## Account for the Candidate

Read the candidate end to end. Inventory every material added, changed, or intentionally retired surface, including code, types, dependencies, configuration, flags, state, schemas, exports, registrations, tests, fixtures, scripts, generated artifacts, build or deployment wiring, and current documentation concepts that create maintenance obligations.

For each material surface, establish which of the following requires it:

- the decided result directly;
- propagation needed to make that result real;
- an active consumer, contract, constraint, threat, or failure policy that must be preserved;
- a direct consistency consequence of the optimization.

Trace from a candidate change to its consumers and effects only far enough to decide whether it can be removed, reused, realigned, directly simplified, restructured, or retained. Trace backward from a preserved result only far enough to prove that the selected runtime path and its contract remain intact. Inspect runtime composition and resolved configuration when they select the active implementation.

Absence of an in-repository caller does not prove that a published or external surface is unused. Search hits, types, injection, mocks, and passing tests prove only their direct scope. Obtain the smallest owning contract or runtime evidence that can change the edit; if a material obligation remains unknowable within scope, retain that boundary and report it rather than guessing.

Stop discovery when another plausible candidate surface or causal path cannot reveal a new obligation or change a removal, reuse, ownership, scope, or validation decision. Keep unrelated debt outside the task.

## Reduce and Restructure the Required Implementation

Apply a deletion test before improving a mechanism: what decided result, necessary propagation, active consumer, contract, constraint, threat, or failure policy would fail if the whole mechanism disappeared? If none is established, delete it rather than renaming, splitting, documenting, or replacing it.

If a mechanism remains necessary, choose the smallest justified intervention. These are alternatives that may be combined when each is required, not an ordered ladder:

- Reuse a project, framework, standard-library, or installed dependency capability whose responsibility, contract, failure behavior, version, and lifecycle fit.
- Return duplicated decisions, state, or effects to an already established owner.
- Make necessary control flow, data flow, dependencies, and public surface direct.
- Restructure required code when the candidate makes unrelated responsibilities change together, leaks implementation knowledge across an owning contract, shares mutable state, creates hidden ordering, or propagates low-level failure details.
- Add, reshape, or retain structure only when it centralizes an established invariant, serves actual consumers under one contract, or isolates a real protocol, security, error, state, or resource-lifecycle boundary, and demonstrably removes more coupling, change propagation, responsibility, concepts, or lifecycle burden than it introduces.

Do not invent a new owner, source of truth, adapter, canonical state, projection, or synchronization path merely to make the candidate look organized. If the correct owner or contract is itself undecided, stop at that design boundary.

Increase cohesion by keeping code that owns the same decision, state, effect, or lifecycle together. Do not split by syntax, file size, naming preference, or the number of methods. Reduce coupling at the contract that owns the leaked knowledge or dependency; interfaces, injection, adapters, events, or additional modules are means, not evidence that coupling fell.

Apply these checks only when the candidate introduces or changes the mechanism:

- Configuration needs behavior that must vary without code changes, plus a consumer, owner, default, and validation.
- Persistent state needs an established fact that must outlive its creating operation, with an authoritative owner, explicit writers and readers, recovery behavior, and a retirement condition.
- Cached, derived, or replicated state needs an actual consumer or constraint, an authoritative source, defined refresh or reconciliation and failure behavior, and a bounded lifecycle.
- Validation, retry, timeout, fallback, broad catch, default, limit, or other defensive behavior needs a real untrusted boundary, active obligation, reproduced failure, constraint, threat, or explicit degradation policy.
- Compatibility or transition behavior needs an identified active consumer, responsible owner, verification, and explicit removal trigger; without that obligation, remove the superseded path rather than creating a replacement.
- A thin adapter or separate path may be added, reshaped, or retained when it owns a real protocol, security, error, compatibility, or lifecycle boundary; do not merge genuinely different policies to reduce line count.

Treat candidate-authored tests, mocks, snapshots, and validation scripts as evidence of their direct scope, not independent proof of the behavior they encode. Never preserve an unsupported production mechanism only because a test asserts its implementation shape, and never weaken a protected behavior merely to make the optimized candidate pass.

## Close Direct Consequences

Make the smallest complete edits across the candidate and the callers, imports, exports, contracts, configuration, registrations, dependencies, tests, fixtures, scripts, artifacts, current documentation, and visible output directly affected by those edits. Remove candidate-authored tests or artifacts only when their protected surface is intentionally removed and no independent behavior obligation remains.

When the candidate actually replaces an active mechanism, verify that the superseded entry, runtime selection, state, and any generator, template, registry, default, build composition, or deployment wiring that would recreate it are removed or explicitly bounded. Do not perform migration or system-wide retirement work when the candidate does not create that obligation.

Inspect the evolving diff against the base, target, and authorized scope. Leave out formatting, naming, cleanup, or refactoring that does not reduce target-relevant responsibility, behavior, state, dependency, surface, or lifecycle burden. Preserve unrelated user changes.

## Verify the Final Candidate

After the last relevant edit, inspect the final diff and establish all four results:

- **Same behavior:** the decided normal result, preserved contracts, and affected failure semantics still work at the boundary that determines them.
- **Candidate closure:** unsupported candidate surfaces and their direct references or producers are absent; any retained residue has an established obligation and boundary.
- **Structural fit:** required responsibilities are cohesive; dependencies, knowledge, state, and low-level failures cross only fitting contracts; any added or reshaped abstraction has an established invariant, consumer, or boundary.
- **Less burden:** the final candidate has less target-relevant coupling and change propagation and fewer unnecessary decision locations, states, branches, dependencies, configurations, public surfaces, abstractions, or lifecycle obligations, without replacing them with equivalent new machinery.

Use the smallest validation that distinguishes success from failure, then rerun checks invalidated by the final edits. Prefer an existing contract, real consumer, boundary execution, or discriminating counterexample when candidate-authored tests merely restate the implementation. Include data preservation, ordering, concurrency, idempotency, cancellation, resource lifetime, security, performance, migration, or external validation only when the candidate exposes those risks.

Make no edit when the candidate already is the lowest-total-burden complete implementation. Do not claim repository-wide simplicity, external behavior, deployment, or release readiness beyond the evidence actually obtained.

## Response Contract

Lead with whether the bounded candidate was optimized without changing its decided behavior. State the candidate and base, meaningful deletion, reuse, responsibility or structural correction, direct consequence closure, final validation, net burden reduction, preserved constraints, and any unresolved boundary. If no edit was needed, say so with evidence. Keep the response as short as the outcome allows.
