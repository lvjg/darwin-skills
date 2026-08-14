---
name: code-cleanup
description: Use when the user authorizes cleanup edits to an existing or partially delivered implementation, including a feature, fix, refactor, migration, or a remediation outcome explicitly accepted by the user or recorded in a current decision governing the affected contract, to remove obsolete paths, speculative defenses, silent fallbacks, duplication, misplaced responsibility, harmful coupling, over-abstraction, or mismatched active surfaces while preserving confirmed behavior. Establish the target independently of current code and tests, prefer deletion and fitting existing capabilities, and prove the final behavior and retired residue. Do not use for read-only assessment, unresolved design choices, or general refactoring without a confirmed target. Repository cleanup authority excludes user assets, persistent data, remote resources, production configuration, and irreversible migration unless separately authorized.
---

# Code Cleanup

Bring an authorized implementation to the smallest coherent state that satisfies a confirmed outcome. Preserve required behavior, active contracts, failure semantics, user data, and unrelated work. Cleanup removes unsupported code and complexity; it does not invent requirements, redesign unresolved choices, or optimize nearby code.

`independent outcome -> actual path and delta -> delete / reuse / realign / simplify -> affected surfaces agree -> final behavior and absence proof`

## Establish the Outcome

Fix the target before editing. Accept it only from the user's stated result, a still-valid design decision, an active contract, or a traceable remediation outcome explicitly accepted by the user or recorded in a current decision governing the affected contract. The agent's diagnosis, current code and tests, historical plans, and unaccepted suggestions are evidence, not authority to establish the target. Express required behavior, preserved behavior, intended removals, and non-goals as observable outcomes independent of the current implementation. Include the actual user-visible or business result when the cleanup affects one.

Record the authorized repository scope, dirty-worktree baseline, delivery state, and boundaries that require separate authority. Preserve unrelated changes. If a material choice remains unresolved or the requested result conflicts with an active contract, leave that boundary unchanged and report the prerequisite instead of choosing a design implicitly.

## Trace the Actual Delta

Follow a representative active path from entry to observable result through callers, decisions, state, effects, dependencies, and runtime wiring. At ownership crossings, verify that dependencies remain directional and contract-based; treat competing writes or policies, cycles, shared mutable state, hidden ordering or effects, internal leakage, and unrelated co-change as evidence of misplaced or duplicated responsibility. Separate required behavior, target residue, existing capabilities that fit, intentional constraints, and unrelated debt. Search hits and passing tests do not prove that a path is active or correct; inspect the owning contract and runtime connection when the distinction changes an edit.

Test the necessity of defensive and compatibility code. For each guard, validation, retry, fallback, default, broad catch, adapter, compatibility branch, timeout, or data limit, identify the untrusted boundary, active contract, reproduced failure, or explicit degradation policy that requires it. If that basis is unclear and removal could change material behavior, investigate or leave it unresolved; do not preserve or add it merely because a scenario can be imagined. When reuse or integration depends on a library or framework, check the installed version, supported contract, and relevant source or runtime behavior before wrapping or reimplementing it.

## Converge the Implementation

Apply changes in this order: delete superseded or unsupported behavior; use an existing capability whose responsibility and contract fit; move a rule or effect to the boundary that owns it; simplify state, control flow, dependencies, and public surface; add or retain structure only when the target needs a stable responsibility, contract, authority, lifecycle, change boundary, or consistency rule and its reduction in total complexity and change propagation exceeds its conceptual and indirection cost. Every edit must reduce the target delta, unsupported behavior, total concepts, change propagation, or ambiguity without breaking a preserved outcome.

Assign a single decision owner only where conflicting inputs require one decision or policy. Do not create canonical state, projections, synchronization, or a new “source of truth” solely to satisfy an ownership rule. Local, derived, cached, or replicated state is valid when the target needs it and its authority, lifecycle, refresh or reconciliation, and failure behavior are clear.

Validate untrusted input and external failure at the boundary that owns them. Inside a controlled path, rely on its explicit contract and let invariant violations fail visibly. Do not make a failing test pass through a shallow fallback, silent default, swallowed exception, speculative retry, or duplicate validation. Do not silently truncate, drop, or coerce data; make any intentional limit or degradation explicit, observable, owned, and verified. Preserve compatibility only for an evidenced active contract with an owner, verification, and an exit condition.

Do not force reuse across the wrong owner, merge genuinely different policies, or split and wrap code mechanically. Within the changed surface, keep control and data flow readable and names aligned with the project's intent and conventions; do not turn style preference into broader refactoring. Remove incidental helpers, variables, branches, and indirection only when the resulting flow is easier to understand and no required distinction disappears.

## Close the Affected System

Align only causally affected callers, exports, contracts, state, configuration, current documentation, tests, prompts, scripts, artifacts, and visible output. Treat tests as protection and evidence, not a default cleanup target: change setup only for an authorized surface change, and change assertions only when the independent outcome or protected contract changes; never weaken or delete them merely to accept the implementation. Remove superseded active code, names, routes, adapters, flags, tests, and concepts. Bound any residue that must remain with its consumer, reason, verification, and removal condition. Moving or renaming code without reducing unsupported behavior, concepts, or change radius is not cleanup.

Inspect the evolving diff against the baseline and target. If an edit expands beyond the established causal path, either prove that the new surface is required to complete the outcome or leave it out.

## Verify and Stop

Judge the final snapshot against the independent outcome, not against the implementation's preferred behavior. During editing, run the smallest check that distinguishes the current hypothesis; do not run the full suite after every small change. After the last relevant edit, rerun checks invalidated by that edit and use broader tests only when the affected contracts or risk justify them.

Prove required success, affected failure behavior, and absence or bounded ownership of retired surfaces. Include asynchronous error propagation, ordering, concurrency, idempotency, resource lifetime, and data preservation only when the changed path exposes those risks. For user-visible behavior, verify the actual observable result; a frontend simulation, backend-only exercise, or test derived from the code is not sufficient by itself. Distinguish working-tree behavior from what is tracked, built, deployed, or otherwise deliverable.

If cleanup closes a material acceptance condition or release gate, validate the causally affected final range against that condition. Stop when the target is met and every remaining issue is unrelated, aesthetic, requires a separate decision, or cannot change the completion judgment with further evidence. Make no edit when the implementation already satisfies the target.

## Response Contract

Lead with whether cleanup completed. State the target source, changed surface, meaningful deletion, reuse or responsibility correction, verification on the final snapshot, preserved constraints, and unresolved boundaries. If no edit was needed, say so with evidence. Do not expose internal classifications, imply that unverified work is complete, or add ceremonial sections. Keep the response as short as the outcome allows.
