---
name: delivery-review
description: Use when the user requests a read-only acceptance judgment of a delivered or partially delivered implementation, including a patch, diff, branch, commit, pull request, migration, refactor, configuration change, or follow-up after fixes. Trigger for final implementation acceptance, pre-merge, pre-integration, pre-staging, pre-migration, or pre-release readiness, and questions about whether a candidate is complete, in scope, implementation-sound, or safe to accept, merge, deploy, or release. Reconstruct the accepted outcome, authorized delivery boundary, material delivered surfaces, active system, implementation quality, and gate-specific evidence; report the candidate's decision, verified delivery defects, unresolved acceptance conditions, and evidence limits. Keep the verdict on the delivered candidate here even when remediation requires a new design choice. Reviewing alone authorizes no edits; modify only when the user also explicitly authorizes implementation.
---

# Delivery Review

Decide whether the exact delivered candidate is an acceptable implementation for its explicit or contextually implied next gate. Treat defect discovery as evidence for that decision, not as the purpose of review. Acceptance requires more than functional agreement with a plan: the candidate must produce the accepted normal and failure outcomes, stay within the authorized delivery boundary, preserve active contracts and behavior, form a complete and maintainable implementation, introduce no material unsupported surface or risk, and have evidence proportionate to the gate.

Do not reject a candidate merely because another implementation would be shorter or more elegant. Do not accept it merely because its own tests pass or because it faithfully follows an approved plan.

`acceptance frame -> delivered surfaces and system -> integrated delivery judgment -> discriminating challenge -> gate decision`

## Establish the Acceptance Frame

Identify the candidate, relevant comparison basis, next gate, dirty state, and intentional deferrals strongly enough to avoid mixing materially different revisions. Do not require a hash, full worktree inventory, or frozen workspace unless reproducible auditability is requested or unresolved identity can change the verdict. Distinguish what is present in the working tree from what is tracked, built, migrated, deployed, or otherwise deliverable.

Separate four scopes:

- Accepted intent: the outcomes and changes the user authorized.
- Necessary propagation: additional surfaces that must change to complete those outcomes or preserve contracts.
- Delivered surface: every material code, dependency, public interface, configuration, stored shape, migration, background process, compatibility path, artifact, or operational obligation included in the candidate.
- Validation boundary: unchanged behavior or external facts that require evidence without authorizing modification.

When the user does not name a gate, infer the narrowest immediate decision supported by the artifact and requested action, and state the assumption with the verdict. Do not silently judge a partial increment against a later gate. Give bounded conditional decisions when plausible gates require materially different evidence and context cannot resolve them.

Build the frame from sources with different roles:

- Use the user's current accepted outcome, scope, preserved behavior, quality expectations, and explicit acceptance decisions to define the result and delivery boundary.
- Use active public, persisted, security, operational, dependency, and project contracts or conventions to constrain what may change and the implementation quality required at the gate. Treat a convention as binding only when its owning source and material consequence are established.
- Use an approved plan, design, RFC, or checklist as evidence of intended scope, route, risks, and proof obligations while it still describes the candidate; it does not override actual behavior or make a changed route acceptable by itself.
- Use code, tests, comments, history, diagnostics, and the author's account as evidence of delivery, not as authority to define their own success.

Resolve conflicts by the owner of required semantics, the owner of actual behavior, scope, and freshness rather than by source count or a universal priority order. Keep any decision-changing conflict or assumption open and narrow the verdict accordingly.

Express acceptance as observable success and failure outcomes, authorized and necessary change, preserved contracts, implementation integrity, material residual risk, and evidence required by the gate. Calibrate depth to consequence, reversibility, reach, uncertainty, and cost of failure.

## Reconstruct the Delivered Candidate

Read the change end to end before judging individual hunks. Form one coherent model of the delivered system and trace at least one representative active path through entrypoint, decisions, owners, state, effects, and observable result.

Close causal scope in both directions:

- Work backward from each required outcome and preserved guarantee to the owners, wiring, contracts, state, configuration, migration, runtime participants, and evidence needed to make it true.
- Work forward from each material delivered surface to callers, consumers, public exposure, stored data, external systems, asynchronous work, operations, recovery, rollback, maintenance obligations, and user-visible effects.

For every material delivered surface, establish the current accepted outcome, contract, consumer, owner, risk boundary, or transition obligation that requires it. Do not dismiss dormant or disabled code merely because it is not on the current active path when shipping it creates a public, security, dependency, migration, deployment, maintenance, recovery, or removal obligation. Do not treat file count or diff size as scope by themselves.

Go outside submitted files only along paths that can change completeness, attribution, behavior, compatibility, ownership, implementation integrity, failure semantics, material delivered burden, or the gate decision. Search the owning module before calling a capability absent. Separate introduced defects from unrelated debt unless the candidate activates, depends on, expands, or materially worsens that debt.

When a new fact changes the accepted outcome, delivery boundary, candidate model, or evidence basis, revise every dependent conclusion. Before deciding, confirm that materially reviewed content still matches what was inspected; invalidate and rerun only evidence whose artifact, path, environment, configuration, data, or assumptions changed.

## Judge the Delivered System

Derive coverage from the accepted frame, actual changed and delivered surfaces, active contracts, project structure, and material failure mechanisms. Use the following as interacting observation directions, not mandatory passes or report sections.

- **Outcome and completeness:** Verify that each required normal and failure result is reachable through real wiring, all required participants and artifacts are deliverable, old or bypass paths do not defeat it, and no unintended behavior remains active.
- **Scope integrity:** Distinguish necessary propagated work from unrelated change, speculative capability, and opportunistic refactoring. A behavior-preserving change may still violate scope when it materially expands attribution, review, rollback, public, dependency, state, security, operational, or maintenance surface without a current obligation.
- **Responsibility and structure:** Locate the semantic owner of each changed rule, authoritative fact, state transition, side effect, failure response, and recovery policy. Examine competing writes or policies, fragmented decisions, cycles, hidden ordering, internal leakage, harmful dependency direction, and file or module responsibility only when they create a material delivery risk. Do not demand one storage location or executor for all state: local, derived, cached, or replicated state is valid when its authority, lifecycle, reconciliation, and failure behavior are clear.
- **Implementation quality and evolvability:** Determine whether control and data flow make critical invariants and failure behavior reliably understandable and verifiable; whether a required change remains local to its owner; whether abstractions represent current stable responsibilities or evidenced variation; and whether the implementation introduces material ambiguity, duplication, change propagation, or maintenance burden. Do not turn naming, formatting, local verbosity, or personal style into findings.
- **Capability fit and structural economy:** For policy- or lifecycle-bearing machinery, inspect the owning project area, resolved framework, and dependency APIs for an existing capability with the required contract. A new mechanism is unsupported when no current outcome, contract, consumer, owner, isolation boundary, reproduced failure, or transition obligation requires it and its absence would preserve accepted guarantees. Report it only when the delivered surface creates material long-lived cost or risk; similarity or the existence of a cleaner implementation alone is insufficient.
- **Behavior and material risk:** Trace affected contracts, stored shapes, external effects, and failure paths. Examine authorization, validation, data integrity, error propagation, timeout, cancellation, retry, idempotency, concurrency, ordering, latency, load, bounded resources, backpressure, observability, and operational cost only where a real boundary or failure mechanism makes them decision-relevant.
- **Transition and operation:** For persisted or externally visible change, judge compatibility, deployment order, mixed versions, migration states, recovery, rollback, removal of superseded paths, and operational readiness separately from code reversion.

Examine both insufficient and unsupported defenses. Require an untrusted boundary, active contract, reproduced failure, or explicit degradation policy for each new fallback, default, broad catch, retry, compatibility branch, duplicate validation, or data limit. Do not presume generated code lacks necessary defenses or demand hypothetical branches without a causal failure mode. Verify version-sensitive behavior against the resolved version, authoritative documentation or source, or a focused runtime probe when the assumption can change acceptance.

An approved route does not excuse an unsound delivered result. A route difference is not automatically a defect either: report it when it changes accepted scope, outcomes, contracts, responsibility, risk, reversibility, or invalidates the evidence required by the gate. Keep the candidate's verdict here; if remediation requires choosing a foundational owner, contract, state model, boundary, or external relationship, leave that future design choice to its owning decision.

## Challenge the Acceptance Judgment

Challenge the strongest plausible explanation that the candidate is acceptable and the strongest plausible explanation that it is not. Prefer the smallest check that separates them over a broad suite that repeats the implementation's assumptions.

Reverse-check materially affected boundaries against their authoritative constraint sources so a requirement omitted by both the request and diff does not disappear from review. Combine unknowns only when they share a state, authority, dependency, side effect, or failure domain and can jointly change the gate; do not build a generic risk matrix.

Treat evidence according to what it establishes:

- Source inspection can establish delivered structure, ownership, scope, static integrity, and support for a behavior, not occurrence in the real environment.
- Focused unit, contract, mock, or local tests establish their exercised boundary and fixtures, not an external dependency, persisted environment, or user-visible outcome they replace.
- Real integration, runtime, persistence, deployment, or user-visible evidence establishes the corresponding end-to-end claim; require it only when the next gate depends on that claim.

Independently verify only decision-changing claims whose evidence is absent, stale, self-confirming, environment-sensitive, conflicting, or weaker than the gate requires. Treat a missing test as an evidence question rather than an automatic implementation defect, and a passing suite as scoped evidence rather than complete delivery proof.

## Decide What Belongs in the Review

Admit a finding only when all of the following hold:

1. It lies on an actual causal path, a required path that is missing, a materially affected contract, or a material surface included in the delivered candidate.
2. It demonstrates or leaves unestablished a violation of an accepted outcome, authorized scope, necessary completeness, preserved behavior, active contract, implementation-integrity requirement, or gate requirement.
3. It rests on traceable verified evidence or names the missing evidence and the opposing outcomes that would change the decision.
4. Its consequence is material enough to change acceptance, required remediation, or residual risk.

Handle conclusions according to what they establish:

- Report a verified delivery defect in behavior, integration, scope, ownership, implementation integrity, risk, or transition with its demonstrated causal consequence.
- Report a decision-changing evidence gap as an unresolved acceptance condition, not a confirmed defect.
- When the candidate implements an unsound or unresolved route, report the delivered consequence and keep its gate decision here without selecting the replacement route.
- Omit unrelated debt, non-material implementation preferences, speculative future concerns that added no material delivered burden, and opportunistic refactoring advice.

Do not treat an author's comment, rejected suggestion, or historical choice as accepted risk. Close a concern only when a current authoritative decision or contract accepts its consequence with the relevant scope.

Keep review read-only. State the violated or unestablished result, scope, owner, contract, implementation-integrity condition, failure semantics, or gate requirement. It is valid to require an unsupported delivered surface to be absent, bounded, or justified by a current obligation; do not prescribe exact file moves, refactors, replacement architecture, or implementation steps. If the same request authorizes implementation, finish the verdict on the reviewed candidate before beginning that separate phase, and never use the old verdict as proof of the changed candidate.

Stop when further inspection or testing cannot change the gate decision, required acceptance conditions, or material residual risk.

## Report the Decision

Lead with whether the exact candidate satisfies the stated or inferred gate and what prevents acceptance. Identify scope and gate compactly, mark an inferred gate as an assumption, and give bounded decisions when materially different gates remain plausible.

Order findings by consequence. For each, give the narrowest useful location, verified fact or decision-changing unknown, causal effect on the accepted result, scope, implementation integrity, contract, risk, or gate, and the condition that must become true for acceptance. Do not force severity labels or prescribe the local implementation shape.

Close with the evidence boundary: what was verified, what remains unestablished, which unknowns can change the verdict, and whether the candidate materially changed while evidence was gathered. If it changed, state which candidate the verdict covers and which evidence was invalidated or rerun. Keep internal consistency separate from outcome proof.

If no issue clears the admission threshold, say that the candidate satisfies the gate, summarize the discriminating evidence, state any material evidence limit, and stop. Do not add scores, strengths for balance, fixed dimension sections, nits, or optional cleanup suggestions.
