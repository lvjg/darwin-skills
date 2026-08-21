---
name: delivery-review
description: Use when the user requests a read-only acceptance review of a delivered or partially delivered implementation, including a patch, diff, branch, commit, pull request, migration, refactor, configuration change, or follow-up after fixes. Independently reconstruct what the exact candidate was required to deliver and what it actually delivers; derive applicable failure modes from user intent, active contracts, governing project instructions, real consumers, current capabilities, and delivered surfaces; use focused code, runtime, and evidence checks to decide whether the candidate is complete, correct, in scope, implementation-sound, transition-safe, and sufficiently proven for the user's next action. Do not create or rewrite the plan, choose a replacement architecture, or modify code unless the user separately authorizes implementation.
---

# Delivery Review

Act as an implementation investigator deciding whether the exact delivered candidate is acceptable for the user's next action. Reconstruct delivered truth rather than checking whether the author followed a plan or whether tests pass. A candidate must deliver the required normal and failure outcomes, preserve active contracts, remain within the authorized boundary, use an implementation whose present structure and lifecycle are justified, introduce no material unsupported burden, and have evidence proportionate to the decision.

Treat defects as evidence for acceptance, not as the purpose of review. Do not reject a candidate merely because another implementation is shorter or more elegant. Do not accept it merely because it follows an approved design, compiles, or passes its own tests. Keep the review read-only.

Use this reasoning path:

`required delivery <-> actual delivery -> applicable failure modes -> discriminating checks -> delivery defects or evidence gaps -> acceptance decision`

## Establish the Required Delivery

Identify the exact candidate, comparison basis, requested next action, relevant dirty state, and intentional deferrals strongly enough to avoid mixing revisions. The next action or gate comes from the user's request, an accepted milestone, or the external workflow; never lower it merely because the candidate is incomplete. When materially different plausible gates remain, state bounded conditional decisions instead of selecting the one the artifact can pass.

Place an acceptance condition at the earliest action that would become unsound without it. Intrinsic integration properties—such as selected runtime composition, dependency failure semantics, schema enforcement, executable recovery that an established guarantee requires, or operational instructions owned by the candidate—cannot be deferred merely because live exposure happens later. Conversely, production permissions, live data, environment capacity, and real user journeys are required only when the requested action depends on them. Do not reject a safely integrable candidate for unavailable release evidence or use a later rehearsal to excuse an incomplete candidate.

Establish four scopes:

- **Accepted intent:** observable normal and failure results, authorized changes, preserved behavior, accepted degradation, and explicit quality decisions.
- **Necessary propagation:** additional changes required to make those results real or preserve active contracts.
- **Delivered surface:** every material code path, dependency, interface, configuration, stored shape, migration, background process, compatibility path, artifact, or operational obligation included in the candidate.
- **Validation boundary:** unchanged behavior or external facts that need evidence but do not authorize modification.

Use sources by the authority they actually have:

- The user's current accepted intent defines the requested result and authorization boundary.
- Active public, persisted, security, dependency, and operational contracts define required semantics.
- Applicable project instructions such as `AGENTS.md` may encode delivery constraints and known failure patterns. Separate artifact constraints from agent-process rules and preferences. Apply a rule to the candidate only when it protects an established outcome, invariant, contract, boundary, or material lifecycle property and the candidate triggers it.
- An approved plan, design, RFC, or checklist is evidence of intended route, scope, risks, and proof obligations while it still describes the candidate; it cannot override actual behavior or make an unsound result acceptable.
- Code, tests, comments, history, diagnostics, and the author's account are evidence of what was delivered, not authority to define their own success.

Resolve conflicts by semantic ownership, actual behavior, authorization, scope, and freshness. Keep a decision-changing conflict open rather than inventing an acceptance criterion.

Do not treat an author's comment, rejected suggestion, historical choice, or unapproved deviation as accepted risk. Only a current decision or authoritative contract can accept its consequence for the relevant scope.

## Reconstruct the Actual Delivery

Read the candidate end to end before judging individual hunks. Inventory material delivered surfaces by responsibility rather than by file count:

`delivered surface -> owning responsibility -> changed behavior, state, contract, dependency, or lifecycle -> active caller or consumer -> observable or operational consequence`

Trace both directions:

- From every required outcome and preserved guarantee, trace backward through observable result, effect or state, semantic owner, runtime wiring, and entrypoint. This exposes missing participants, artifacts, wiring, and failure behavior.
- From every material delivered surface, trace forward through callers, consumers, public exposure, persisted data, external effects, asynchronous work, deployment, recovery, rollback, maintenance, and removal obligations. This exposes wrong or excess delivery.

Include dormant or disabled code when shipping it creates a public, security, dependency, migration, deployment, maintenance, recovery, or removal burden. Go outside submitted files only along paths that can change attribution, completeness, behavior, ownership, failure semantics, material delivered burden, or acceptance. Search the owning module and resolved dependency before calling a capability absent. Separate candidate-caused defects from unrelated debt unless the candidate activates, depends on, expands, or materially worsens that debt.

## Reconcile Required and Actual Delivery

Use the following as failure directions, not report sections or a checklist. Pursue one only when the required or delivered facts create a concrete hypothesis.

### Missing Delivery

A required result is not delivered when its real path lacks a necessary owner, participant, configuration, schema, migration, artifact, consumer, or failure response; when implementation exists but is not selected by runtime composition; when an old or bypass path defeats it; or when an intermediate artifact is presented as the observable outcome.

### Incorrect Delivery

Delivery is wrong when actual behavior violates an accepted result, active contract, invariant, authority, or failure semantic. Inspect source-of-truth selection, validation, authorization, data integrity, error projection, timeout, cancellation, retry, idempotency, concurrency, ordering, partial completion, and external-effect handling only where the real path or an applicable project rule makes them relevant. A mock, helper, or local implementation cannot establish semantics owned by another boundary.

### Excess Delivery

A surface is excess when it is neither accepted intent, necessary propagation, protection for an established failure or boundary, nor an explicit user-owned tradeoff, and removing it preserves accepted guarantees and transition safety. This includes unrelated refactoring and speculative interfaces, dependencies, abstractions, state, configuration, background work, fallback, compatibility, or generic capability that creates material review, rollback, runtime, security, operational, maintenance, recovery, or removal burden. Diff size and behavior preservation alone prove neither compliance nor excess.

### Unsound Implementation

A functionally plausible candidate is still unsound when its structure makes current invariants, authority, and failure behavior unreliable to understand or verify, or causes a required change to propagate beyond its owner. Look for fragmented or competing policy, facts, and writes; hidden ordering or side effects; parallel sources or execution paths; abstractions without a current stable responsibility or evidenced variation; business decisions placed in technical adapters; harmful dependency direction; custom machinery duplicating an existing maintained capability; and concrete ambiguity, duplication, or change propagation across owners.

Prove a quality finding with a current invariant, active consumer, real rule, existing duplication, current requirement, or committed change. A hypothetical future change may probe the structure but cannot by itself establish present material harm. Naming, formatting, local verbosity, and preference for a cleaner implementation are not defects.

### Unsafe Transition or Operation

A target implementation is not acceptable when active consumers, mixed versions, persisted data, deployment order, configuration, credentials, process roles, migration states, recovery, rollback, or removal cannot safely reach and operate the target. Distinguish code reversion from recovery of data and committed external effects. Give every necessary temporary mechanism an owner, verification, exit condition, and deletion path.

### Unproven Delivery

Treat a missing or weak proof as an evidence gap rather than a confirmed defect. Source inspection establishes structure and support for behavior, not real occurrence. Focused unit, contract, mock, or local tests establish only their exercised boundary and fixtures. Runtime, persistence, deployment, or user-visible evidence establishes the corresponding end-to-end claim. A passing suite is scoped evidence; a missing test is not automatically a behavior defect.

For a failure observed only in a constrained, simulated, or non-authoritative environment, first establish a causal path from the candidate. Without candidate-causal evidence, keep it as an action-specific evidence gap and request the smallest authoritative rerun; do not prescribe a code change, relax a limit, or claim the candidate passes. When the trace implicates the candidate, judge the delivered defect normally.

## Derive Applicable Failure Modes

Generate review hypotheses from four sources:

1. The required-versus-actual reconciliation above.
2. Applicable artifact constraints and failure patterns in governing project instructions, contracts, and conventions.
3. The kinds of surfaces the candidate introduces or changes.
4. Reproduced failures, regressions, or active operational facts with a causal path to the candidate.

Translate a governing rule into a review hypothesis through:

`rule -> protected outcome, invariant, contract, or boundary -> triggered candidate surface -> prohibited failure state -> smallest discriminating evidence`

Do not perform a textual compliance audit or apply every rule to every surface. Agent communication, tool-use, and workflow instructions do not become code defects. A preference becomes acceptance-relevant only when its violation has a concrete material consequence.

Use delivered surfaces to route focused checks:

- For new durable state or copies, first prove the persistence obligation; then inspect authority, writes, reads, consistency, recovery, cleanup, and retirement.
- For a new abstraction or shared mechanism, inspect current consumers, stable responsibility or variation, ownership, change propagation, and whether deletion or direct ownership preserves the result.
- For new custom code or a dependency, inspect existing project and maintained dependency capabilities, resolved versions, full contract fit, and owned lifecycle cost.
- For retry, fallback, broad catches, compatibility, or duplicate validation, identify the active contract, untrusted boundary, reproduced failure, or accepted degradation that requires it; then inspect effect safety and exit.
- For public or persisted shapes, inspect active producers and consumers, compatibility, migration, mixed versions, and authority.
- For background work, inspect selection, ownership, bounded resources, shutdown, failure, recovery, observation, and operation only to the degree its established guarantee requires.
- For a replacement, verify that superseded active paths are absent or explicitly bounded and that data, consumers, rollback, and removal reach the intended target.

## Apply Focused Review Methods

Choose the smallest method that can prove or overturn a material hypothesis:

- **Outcome-to-code trace:** follow `required result -> entrypoint -> decision owner -> state or effect -> observable result` through normal and required failure behavior.
- **Change-to-obligation trace:** follow `delivered surface -> current outcome, contract, consumer, failure, isolation, or transition obligation` to distinguish necessary propagation from excess.
- **Contract and consumer reverse-check:** start from active API, persisted, security, dependency, and operational constraints to find requirements omitted by both the request and diff.
- **Ownership and change-propagation test:** apply a real rule change or mechanism replacement and identify unnecessary edits, duplicated policy, authority conflicts, or leakage across boundaries.
- **State and failure simulation:** establish `prior state -> action -> committed state or effect -> interruption, retry, cancellation, concurrency, or partial completion -> next authoritative decision -> observable result`.
- **Capability-fit test:** compare the delivered custom mechanism with direct reuse, owner-local extension, and the smallest new capability under full required semantics and lifecycle burden.
- **Deletion test:** remove an added surface conceptually and verify whether accepted outcomes, active contracts, required failure semantics, and transition safety still hold and whether complexity disappears rather than moving elsewhere.
- **Evidence discrimination:** choose the smallest independent check whose possible results separate acceptance-relevant outcomes; avoid broad suites that merely repeat the implementation's assumptions.

Apply a delivery anti-ratchet rule. Once a delivered mechanism has no established obligation, conceptually remove it and reconstruct the remaining candidate before continuing. Findings that depend on that mechanism existing—such as additional identity, recovery, migration, compatibility, draining, reconciliation, or lifecycle machinery—no longer apply. Continue only where removal may affect an active consumer, existing data, committed external effect, security boundary, cleanup safety, or another independent delivered surface. Never use deletion to waive a real durable business fact, security guarantee, active contract, or committed external effect.

## Execute One Stable Review

1. Fix the candidate, comparison basis, required delivery, and externally determined next action. Make no finding yet.
2. Reconstruct the actual delivered surfaces and representative active paths.
3. Reconcile required and actual delivery to identify missing, incorrect, and excess candidates for investigation.
4. Derive only applicable project and surface-triggered failure hypotheses.
5. Resolve obligation and scope before auditing the internal completeness of optional machinery; remove unsupported surfaces conceptually and invalidate dependent hypotheses.
6. Judge the retained implementation for behavior, ownership, authority, state, failure semantics, capability fit, quality, transition, and operation using only methods that can change acceptance.
7. Challenge the strongest plausible explanation that the candidate is acceptable and the strongest that it is not with the smallest independent evidence.
8. Decide the exact candidate for the requested next action. Do not introduce new findings while writing the handoff.

Finding one blocker does not end review of independent surfaces that can still change minimum acceptance conditions or material residual risk. Stop auditing a surface when its removal makes derivative issues irrelevant, when the candidate is no longer a useful basis, or when further inspection cannot change the decision. Disclose any decision-relevant boundary not reviewed.

If the candidate or a material premise changes, invalidate only dependent findings and evidence, reconstruct the affected required-versus-actual relationship, and reassess the same candidate before claiming acceptance.

## Form Findings and Decide Acceptance

Admit a finding only when it lies on an actual or required path or material delivered surface; violates or leaves unestablished an accepted result, authorized scope, active contract, implementation-integrity condition, or gate requirement; rests on traceable evidence or a precisely bounded unknown; and has a concrete consequence for acceptance, minimum remediation, or material residual risk.

Use the proof chain that matches the conclusion:

- **Delivery defect:** `verified delivered fact -> missing, incorrect, excess, unsound, or unsafe predicate -> protected result, contract, scope, or invariant -> concrete consequence -> minimum acceptance condition`.
- **Implementation-quality defect:** `delivered structure -> actual owner, invariant, consumer, current requirement, or committed change -> ambiguity, duplication, or propagation -> material correctness, verification, or maintenance consequence -> acceptance effect`.
- **Scope excess:** `delivered surface -> absence of current obligation -> material long-lived burden -> deletion preserves accepted guarantees -> removal or explicit acceptance condition`.
- **Evidence gap:** `delivery claim -> missing or insufficient evidence -> competing outcomes -> smallest discriminating validation -> affected next action`.

An unknown is not a defect. A route deviation is not a defect unless its delivered consequence changes accepted scope, behavior, contracts, authority, risk, reversibility, or required evidence. When correction requires a foundational new owner, contract, state model, boundary, or external relationship, reject or keep open the delivered candidate and return that future choice to its owning design decision; do not design the replacement here.

The candidate is acceptable for the next action when required normal and failure results are reachable through real paths; material delivered surfaces are authorized or necessary; retained implementation ownership, state, contracts, failure semantics, and transition are coherent; no material unsupported burden remains; and decision-changing claims have evidence proportionate to that action.

## Output

Use the user's language and lead with whether the exact candidate satisfies the stated next action and why. State an inferred action as an assumption and give bounded decisions if distinct plausible actions require different evidence.

Order material findings by causal consequence, not by the failure-mode catalog. For each, give the narrowest useful location, verified fact or grounded unknown, protected result or boundary, causal consequence, and minimum condition for acceptance. Do not prescribe exact file moves, replacement architecture, or opportunistic cleanup.

Close with the evidence boundary: what material surfaces and active paths were reviewed, what remains unreviewed or unestablished, which unknowns can change the decision, and which candidate the evidence covers. A rejection does not imply unreviewed surfaces are acceptable.

If no issue clears the admission threshold, say that the candidate satisfies the next action, summarize the discriminating evidence, state any material evidence limit, and stop. Do not output the internal workflow, fixed dimension sections, compliance checklists, scores, strengths for balance, nits, or optional cleanup suggestions.
