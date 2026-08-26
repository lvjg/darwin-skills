---
name: code-cleanup
description: Use only when the user explicitly invokes $code-cleanup for authorized cleanup of an existing implementation after the required outcome is confirmed. Remove or realign unsupported, duplicate, obsolete, or misplaced mechanisms without choosing a new design or expanding mutation authority.
---

# Code Cleanup

Bring an authorized implementation to the smallest coherent system that satisfies a confirmed outcome. Preserve required behavior, active contracts, failure and recovery semantics, user data, and unrelated work. Cleanup removes unsupported responsibilities, behavior, state, paths, dependencies, and surface area; it does not invent requirements, choose an unresolved design, or optimize nearby code.

Completion means that every remaining element in the affected system is required by the target or a preserved obligation, sits at a fitting owner, and has no simpler supported replacement.

`confirmed outcome -> affected responsibilities and distinct paths -> necessity judgment -> delete / reuse / realign / simplify / retain -> close affected surfaces and retired producers -> behavior + retirement + net-simplicity proof`

## Confirm the Cleanup Contract

Fix the target before editing. Accept it only from the user's stated result, a still-valid decision governing the affected contract, an active contract, or a traceable remediation outcome explicitly accepted by the user. The agent's diagnosis, current implementation and tests, historical plans, and unaccepted suggestions are evidence, not authority to establish the target.

Judge completion against the authorized target on the final candidate snapshot, not on planned future changes.

Express the required observable result, behavior and failure semantics that must remain, behavior or mechanisms intended to retire, and non-goals independently of the current implementation. Include the actual user-visible or business result when cleanup affects one. Record the authorized repository scope, comparison baseline, dirty-worktree state, delivery state, and boundaries requiring separate authority. Preserve unrelated changes.

Do not edit through a material unresolved choice. If the requested result conflicts with an active contract, or cleanup would require a new product or architecture decision, leave that boundary unchanged and report the prerequisite.

## Reconstruct the Affected System

Start from each required or preserved outcome and follow every materially distinct active path from entry or consumer to observable result. A path is materially distinct when it introduces a different contract, decision owner, authoritative state, side effect, dependency selection, failure or recovery behavior, ordering requirement, or resource lifecycle. Inspect runtime composition and configuration when they decide which implementation is active.

Across those paths, identify the actual consumers and published contracts; where decisions are made; who writes and reads authoritative, derived, cached, or replicated state; where effects occur; which internal and external dependencies are required; how errors, cancellation, retries, compensation, concurrency, and resources behave when relevant; and which current surfaces carry the behavior. Current surfaces can include APIs, events, commands, jobs, registrations, configuration, flags, schemas, tests, documentation, prompts, scripts, generators, templates, build or deployment artifacts, telemetry, and visible output.

For behavior or mechanisms intended to retire, also trace any target-relevant path or producer that can preserve, recreate, or re-enable them, even when unchanged by the candidate.

Follow published or external consumers far enough to establish their binding contract; absence of an in-repository caller does not prove that a public surface is unused. Search hits, types, dependency injection, mocks, and passing tests prove only their direct scope. Check the owning contract and concrete runtime consumption whenever that distinction could change an edit.

Coverage is sufficient when examining another plausible active path no longer reveals a new consumer, contract, decision owner, state authority, effect, failure semantic, or lifecycle relevant to the target. Keep unrelated debt outside the cleanup boundary.

## Derive Necessary Cleanup

Judge every behavior, decision, state, dependency, abstraction, defensive mechanism, compatibility path, and active surface in the affected system by necessity:

- Which target result, preserved contract, constraint, threat, or failure policy requires it?
- Who consumes it, and is it owned where its decision, state, effect, and lifecycle can be enforced?
- Does another location make the same decision, store the same fact, perform the same effect, or expose an equivalent capability?
- Does the project, framework, standard library, or an installed dependency already provide a responsibility- and contract-matching capability?
- Does it leak internals, create a cycle or hidden ordering, share mutable state, broaden an interface, or force unrelated modules to change together?
- Is it only a wrapper, forwarding layer, historical compatibility mechanism, speculative extension point, or producer of a retired surface?
- What confirmed outcome would fail if it were removed?

For each validation, guard, retry, fallback, default, broad catch, adapter, timeout, limit, cache, synchronization path, or compatibility branch, identify the untrusted boundary, active consumer or contract, reproduced failure, performance constraint, or explicit degradation policy that requires it. Do not preserve or add one because a scenario can merely be imagined. Do not infer that security, data integrity, or public compatibility code is unnecessary from local silence; verify the authority that owns the obligation.

When the basis is unclear and removal could change material behavior, investigate until the evidence can distinguish removal from retention. If the boundary remains unknowable within scope, retain it as an explicit unresolved boundary rather than claiming it was cleaned. Before wrapping or reimplementing an existing capability, verify the installed version, supported contract, relevant source or runtime behavior, and ownership fit.

## Choose the Smallest Convergence

Resolve confirmed cleanup needs in this order:

1. **Delete** behavior, state, paths, dependencies, and surfaces with no confirmed obligation.
2. **Reuse** an existing capability when its responsibility, contract, failure behavior, and lifecycle fit.
3. **Realign** a decision, state, or effect to the boundary that owns it.
4. **Simplify** necessary control flow, data flow, dependencies, and public surface.
5. **Retain** a mechanism only with an evidenced obligation and clear owner.

Assign one decision owner only where conflicting inputs require one decision or policy. Do not create canonical state, projections, synchronization, adapters, or a new “source of truth” merely to satisfy an ownership preference. Local, derived, cached, or replicated state is valid when the target needs it and its authority, lifecycle, refresh or reconciliation, and failure behavior are explicit.

Add or retain structure only when all of the following hold: a confirmed responsibility or constraint requires it; it has a real consumer; its owner and lifecycle are clear; no existing capability fits; and it replaces more responsibility, state, paths, change propagation, or lifecycle burden than it introduces. A cleanup that adds concepts without a demonstrated net reduction has not converged.

Validate untrusted input and external failure at their owning boundary. Inside a controlled path, rely on explicit contracts and let invariant violations fail visibly. Do not make tests pass through shallow fallbacks, silent defaults, swallowed exceptions, speculative retries, duplicate validation, or silent truncation, dropping, or coercion. Make intentional limits and degradation explicit, observable, owned, and verified. Preserve compatibility only for an evidenced active obligation with an owner, verification, and exit condition.

Do not force reuse across the wrong owner, merge genuinely different policies, split and wrap code mechanically, or turn naming and style preferences into a broader refactor. Keep necessary control and data flow direct and readable without erasing required distinctions.

## Apply and Close the System

Make the smallest complete edits and align only their causal consequences across callers, consumers, exports, contracts, state, configuration, registrations, current documentation, tests, prompts, scripts, artifacts, operations, and visible output. Remove superseded active code, decisions, state, routes, adapters, flags, tests, names, and concepts. Preserve historical records unless the user authorizes changing them.

Close both the retired surface and every active mechanism that would recreate or re-enable it, including generators, templates, registries, defaults, migrations, synchronization scripts, build composition, and deployment wiring. Bound anything that must remain with its consumer, reason, verification, and removal condition.

Treat tests as protection and evidence, not a default cleanup target. Change setup only for an authorized surface change, and change assertions only when the independent outcome or protected contract changes; never weaken or delete them merely to accept the implementation.

Inspect the evolving diff against the baseline and target. If an edit expands beyond the established causal system, prove that it is necessary to complete the outcome or leave it out. Moving or renaming code without reducing unsupported behavior, responsibility, state, dependency, concepts, or change propagation is not cleanup.

## Prove Final Convergence

Judge the final snapshot against the independent outcome, not the implementation's preferred behavior. During editing, run the smallest check that distinguishes the current hypothesis. After the last relevant edit, rerun checks invalidated by it and broaden validation only when affected contracts or risk justify it.

Prove all three dimensions:

- **Behavior:** required success, preserved behavior, and affected failure or recovery semantics work at the boundary that determines the result. Include data preservation, ordering, concurrency, idempotency, cancellation, resource lifetime, security, and performance only when the changed system exposes those risks.
- **Retirement:** superseded behavior, state, paths, surfaces, and their producers are absent, or each remaining residue has bounded ownership and an exit condition. Verify public or external obligations before treating repository absence as proof.
- **Net simplicity:** the final system has no unexplained decision owner, state or synchronization relation, dependency, public surface, configuration, compatibility path, abstraction, or lifecycle. Any added structure demonstrably replaces greater total burden.

Each dimension must be established. Evidence may overlap, but satisfaction of one dimension does not establish the others.

For user-visible behavior, verify the actual observable result; a frontend simulation, backend-only exercise, or test derived from the implementation is not sufficient by itself. Distinguish working-tree behavior from what is tracked, built, deployed, or otherwise deliverable. If cleanup closes an acceptance condition or release gate, validate the causally affected final range against that condition.

Stop when the target is met, the affected system is closed, and every remaining issue is unrelated, aesthetic, requires a separate decision or authority, or cannot change the completion judgment with further evidence. Make no edit when the implementation already satisfies the target.

## Response Contract

Lead with whether the authorized cleanup target completed and identify any target-relevant residue. State the target source, changed surface, meaningful deletion, reuse or responsibility correction, closure of retired mechanisms, validation on the final snapshot, net effect on system complexity, preserved constraints, and unresolved boundaries. If no edit was needed, say so with evidence. Do not expose internal classifications, imply that unverified work is complete, or add ceremonial sections. Keep the response as short as the outcome allows.
