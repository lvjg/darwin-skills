---
name: plan-review
description: Use when independently reviewing a current implementation plan, technical design, RFC, migration, refactor, or other proposed technical change before coding or another consequential commitment. Produce a read-only, evidence-backed judgment of whether the route solves the real problem, whether responsibilities and boundaries form the smallest justified long-lived system, what material premises remain unproven, and whether the proposal is ready for the decision it must support. Compare viable alternatives when they can change the judgment, but do not create or rewrite the proposal, review delivered implementation, or modify code.
---

# Plan Review

Review a proposal as a technical change from the real current system to an intended outcome. Judge the problem diagnosis, causal route, system-design quality, affected behavior and transition, evidence, and readiness strongly enough to support the user's next decision. Treat the proposal and prior designs as claims, not authorities. Do not review document formality, complete a template, or maximize findings.

Keep the review technical. Evaluate responsibilities, authority, boundaries, contracts, state, behavior, constraints, quality, failure, migration, and operation, but do not decide business value, staffing, budget, or organizational governance. Expose a user-owned choice only when it changes a required guarantee, allowed degradation, risk tolerance, or scope; make only the dependent conclusion conditional. Review alone authorizes no modification.

Maintain four distinct judgments: whether the route can produce the intended result, whether its long-lived system structure is justified, whether material premises have proportionate evidence, and whether the proposal is ready for the decision it must support. Communicate them as one natural conclusion. A route may work yet be needlessly complex, be preferable but unproven, or be sound while not ready for an irreversible commitment.

Use this reasoning loop:

`frame the decision -> discover actual impact -> model necessary responsibilities and system states -> judge route and design quality -> challenge with failures and simpler counterroutes -> decide readiness and handoff`

Scale investigation to consequence and uncertainty. Reuse evidence while its source, scope, and freshness remain valid. Revisit only conclusions invalidated by a new fact. Stop when further inquiry cannot change the route, design-quality judgment, material risk, readiness, or minimum handoff. Do not expose this process mechanically in the response.

## Frame the Decision

Separate the authorized goal from the proposed means. Establish the actual technical problem or opportunity and its cause; intended observable outcomes and failure criteria; preserved behavior and invariants; active constraints and contracts; allowed degradation; scope and non-goals; material risks; reversibility; and the next decision the review must support. Do not let the proposal define the problem or acceptance criteria on behalf of the original request.

For performance, scale, reliability, or complexity claims, locate the actual work, resource, failure, and dominant end-to-end cost at their owning boundary. A different implementation, available optimization headroom, or plausible complexity claim proves neither a defect nor a benefit.

Identify the proposal version only strongly enough to avoid mixing material revisions. If the proposal changes, reread the affected content and invalidate dependent conclusions only. Do not require a hash, commit, or frozen workspace unless reproducibility is requested or unresolved ambiguity can change the judgment.

Distinguish original requirements, active contracts, verified current facts, reasonable inferences, proposal assumptions, and reviewer-introduced requirements. Obtain decision-changing facts from their owning sources: concrete implementation and consumers for current behavior; configuration and composition for selected runtime paths; tests for their covered scenarios; contracts or official documentation for declared semantics; and runtime or real integration evidence for environment-specific claims. Bound conclusions to the environment, implementation, adapter, scenario, and version actually covered. A declared, injected, referenced, or type-reachable dependency proves only a possible connection; follow selection through concrete consumption. When sources conflict, distinguish the owner of actual behavior from the owner of required semantics and keep the affected conclusion open until the conflict is explained.

Proceed when the problem, current state, intended result, judgment criteria, and supported decision can be stated independently of the proposal narrative.

## Discover Actual Impact

Distinguish authorized intent scope, proposed edit scope, propagated impact scope, and validation scope. A non-goal can limit proactive construction; it cannot exclude a consequence caused by the proposal.

Trace outward from proposed changes and inward from outcomes, invariants, and preserved behavior. Follow definitions and calls, producers and consumers, authoritative facts and state readers or writers, configuration and assembly, interfaces and events, trust boundaries, background lifecycles, migration and deployment, runtime paths, and external contracts only while they can change a pivotal choice, design-quality judgment, material risk, or readiness.

Use this relationship to derive coverage:

`change or required outcome -> affected object -> changed technical aspect -> participant, state, or operating condition that may observe a different result`

Derive relevant aspects from the actual change, established constraints, and known failure mechanisms. Responsibility, contracts, data, state, behavior, quality, migration, and operation are discovery prompts, not mandatory report sections. Do not form a Cartesian product of dimensions, roles, and scenarios.

For each material consequence, decide whether it needs a proposal change, validation without change, evidence of preserved behavior, or an explicit decision-changing unknown. Stop at a boundary only when an active contract and concrete consumption support the unchanged behavior.

## Model Necessary Responsibilities and System States

Reconstruct only the current, target, and intermediate relationships needed to judge the change. A local reversible change may need one behavior path; a stateful, distributed, or migratory change may require coexistence, failure, recovery, rollback, and exit states. Do not turn a task list into a design or expand a narrow change into a whole-system inventory.

Before accepting the proposal's components, derive the minimum necessary responsibilities from the required outcomes, invariants, authoritative facts, side effects, failure responses, and lifecycle. This is a comparison baseline, not a replacement design. For each material responsibility, identify its semantic owner and any required contract, state, dependency, and transition.

Connect only applicable relationships:

- Responsibility and authority: who owns each business or technical decision, authoritative fact, state transition, side effect, failure response, and recovery.
- Boundaries and dependencies: which responsibilities must change or fail together, and why each dependency exists.
- Contracts and interaction: what producers and consumers exchange, guarantee, reject, and retry.
- State and lifecycle: creation, consistency, transition, invalidation, cleanup, recovery, and deletion.
- Behavior and quality: normal and material degraded outcomes under relevant load, concurrency, trust, or failure conditions.
- Evolution and operation: implementation order, compatibility, mixed versions, observation, rollback, and removal of superseded mechanisms.

Check that these relationships describe one coherent system. Responsibility must agree with authoritative state and failure handling; boundaries with contracts and dependency direction; consistency with transactions and recovery; quality goals with runtime mechanisms; and migration with the intended target.

Identify pivotal choices from consequences, not proposal headings. A choice is pivotal when changing it materially alters ownership, authority, contracts, state semantics, lifecycle, external relationships, critical behavior, tradeoffs, migration, reversibility, acceptance, or risk. If the proposal bundles independent changes, judge each route separately before forming aggregate readiness.

## Judge Route and System-Design Quality

Reason forward through:

`pivotal choice -> owner, contract, state, dependency, and lifecycle -> behavior and transition -> observable result`

Then reason backward from outcomes, invariants, actual impact, and established risks to the responsibilities and mechanisms they require. A complete component or task list does not rescue a broken causal chain.

A good design uses the smallest justified set of long-lived owners, authoritative facts, durable states, contracts, coordination mechanisms, deployment units, and lifecycles that preserves the same required outcomes, invariants, constraints, failure semantics, and transition safety. Fewer components alone is not better; added structure is justified when it owns a necessary responsibility or establishes a required isolation, quality, trust, evolution, or failure boundary.

Judge tradeoffs against the required outcome and accepted degradation; do not require every quality attribute to be maximized. When goals conflict, identify which result must take precedence and which user-owned choice determines it.

Apply these tests only where they can change the judgment:

### Responsibility Closure

Require one semantic owner for each decision, authoritative fact, state transition, side effect, and failure response. Replicas or technical executors may exist, but their authority, consistency, and recovery must remain subordinate to that owner. Treat call order, reuse, dependency injection, data possession, or a `Manager`/`Service`/`Orchestrator` name as no proof of ownership.

Find a responsibility defect when authority is duplicated, missing, or assigned to a boundary that cannot uphold the invariant and failure semantics; when normal execution and recovery have no coherent owner; or when a component adds forwarding and coordination without owning a required decision, state, contract, lifecycle, or isolation boundary.

Keep responsibilities together when they share an inseparable invariant, transaction, lifecycle, or failure response. Separate them when they have materially different authority, trust, lifecycle, failure containment, or independently evidenced change requirements. Do not split or merge merely for symmetry, reuse, file size, or layering convention.

### Boundary Fit and Coupling

Use concrete, credible change scenarios to test boundaries. A well-placed change should primarily alter its owning boundary; other boundaries should change only when their active contract or required semantics change. If one business rule must be edited across channels, SDK adapters, prompts, storage mappings, workers, and UI, its ownership is fragmented. If replacing a provider, transport, store, or model changes business decisions without changing business guarantees, technical mechanism has leaked into policy.

Do not pursue total decoupling. Preserve coupling required by a shared invariant, transaction, lifecycle, or a real provider capability that determines the guarantee; make that dependency explicit at the owning boundary. A generic interface, configuration DSL, event bus, or extra layer is not decoupling unless it contains an evidenced variation and reduces change propagation or failure coupling.

### Structural Economy

For a consequential structural choice, compare the proposal with the current system, usable existing capability, and the strongest materially simpler counterroute. A counterroute is admissible only if it preserves the same outcomes, invariants, active constraints, failure and recovery semantics, and required transition. Use it to test the proposal, not to redesign the whole system.

Compare long-lived structural commitments rather than visible component count: semantic owners and authorities, durable state and copies, contracts and data representations, synchronous or asynchronous coordination, deployment and operational units, failure and recovery paths, and lifecycles that must be maintained or later removed.

Before accepting a new abstraction, state, queue, background process, compatibility mechanism, fallback, extension point, or generic engine, ask which confirmed outcome, invariant, variation, isolation boundary, or risk fails without it and why an existing owner cannot carry it. Prefer deletion, direct ownership, or reuse when the answer is absent. Keep one-time analysis, validation, backfill, and migration work in tooling or transition boundaries rather than permanent runtime architecture.

Treat possible future demand as no present requirement. Do not add runtime structure merely to preserve options. Build ahead only for an active consumer or contract, a committed change, or evidence that a current irreversible or path-dependent decision makes deferral materially unsafe or costlier than adding the structure now; ordinary later refactoring, expected code growth, or generalized option value does not qualify. Compare build-now with defer-and-add-later under equivalent guarantees. Otherwise keep today's direct owner and contract, leave the choice open, and add no speculative abstraction, state, protocol, extension point, compatibility path, or operational lifecycle.

Conclude overdesign only with a concrete deletion, merge, or reuse counterexample: identify where the necessary responsibility moves, show that equivalent guarantees and transition safety remain, show which long-lived commitments disappear, and verify that equal or greater complexity is not transferred elsewhere. Conclude underdesign when a smaller structure loses a necessary owner, authority, isolation, lifecycle, failure response, or required quality mechanism.

Check the combined choices for conflicting premises, cycles, competing authoritative facts, implicit coordination, transferred cost or failure, and temporary mechanisms becoming permanent architecture. Give every necessary transitional mechanism an owner, active contract, verification, exit condition, and deletion path.

## Challenge Decision-Changing Links

Try to overturn the current judgment at its weakest material links. Focus on high-impact, hard-to-reverse, weakly evidenced, cross-boundary, or failure-sensitive choices. Do not enumerate hypothetical roles or stylistic alternatives that cannot change the decision.

Simulate only risk-bearing transitions. Establish the premise, action, resulting state, and dependency of the next transition; test applicable interruption, retry, cancellation, partial completion, coexistence, recovery, rollback, and exit. A target is not executable when a necessary intermediate state is unreachable, unsafe, or unrecoverable.

Use deletion, merge, reuse, and realistic-change counterexamples to challenge design quality. Reject a counterexample that weakens a required guarantee, silently changes the problem, ignores migration, or merely moves complexity into an unnamed boundary. Do not require the proposal to beat every imaginable design; require it to avoid a materially better viable route using current evidence.

Match evidence strength to the claim and derive acceptance from original outcomes and invariants rather than the proposal's own checks. An unknown blocks only the choice, capability, or commitment whose outcome it can materially change. Treat interacting unknowns together only when they share a state, dependency, authority, side effect, or failure domain and can jointly change the outcome. Ask for the smallest validation that distinguishes decision-relevant branches.

## Decide Readiness and Handoff

Derive readiness from the actual decision being supported. Entering detailed design, starting implementation, executing an irreversible migration, and releasing to production require different specificity and proof. Do not demand detail before the next decision depends on it, and do not let missing detail hide a foundational design gap.

A proposal is ready for its next commitment when the route holds; its long-lived structure is justified against materially simpler viable alternatives; decisions required now are made; necessary intermediate states are reachable; material consequences have owners or explicit validation boundaries; and remaining unknowns cannot overturn the commitment or are controlled by reversibility and isolation.

It is not ready when the proposed mechanism does not solve the established cause; a pivotal responsibility, authority, contract, state model, or failure response is incoherent; a materially simpler equivalent route remains unanswered; speculative future demand is the only justification for long-lived structure; obtainable evidence may overturn an irreversible choice; material impact is open; or an intermediate deliverable is presented as the target outcome.

Distinguish route defects, responsibility or boundary defects, overdesign, missing impact, incoherent combinations, unproven premises, and deferrable implementation choices. Reopen the owning design when repair changes a foundational responsibility, authority, contract, state model, boundary, or external relationship. Raise a local implementation choice early only when alternatives change target behavior, an active contract, data integrity, security, reversibility, or material risk.

## Output

Use the user's language and lead with the integrated judgment: whether the route and system structure hold, whether the proposal supports the intended next action, why, and the minimum that must change, be removed, or be proven. Do not organize the answer around this Skill's internal stages or output a scorecard.

Include only material findings. Connect each verified fact or grounded unknown to the broken or weak causal link, its effect on the outcome, pivotal choice, design quality, risk, or readiness, and the proportionate minimum resolution. Treat reviewer preference, a merely cleaner option, or missing detail that cannot change the decision as non-blocking.

Substantiate design-quality findings:

- For overdesign, name the removable, mergeable, or reusable mechanism; its necessary responsibility and receiving owner; preserved guarantees; reduced long-lived commitments; and why complexity is not merely transferred.
- For responsibility defects, name the decision, fact, state, side effect, or failure response; show the duplicate, absent, or misplaced authority; and identify the boundary capable of owning the full semantics.
- For coupling defects, give a credible change that unnecessarily crosses boundaries, identify the misplaced policy or mechanism, and state the minimum boundary correction.
- For anticipatory structure, name the active consumer, contract, committed change, or evidenced cost of deferral and compare building now with adding it when the requirement becomes active. Mere possibility does not justify the structure.
- For a preferred alternative, compare it under equivalent outcomes, constraints, failures, and transition. Do not call an option simpler because it omits required work.

Choose the smallest handoff that follows:

- If the route, design quality, evidence, and readiness hold, state that the proposal may proceed and stop.
- If one isolated issue blocks readiness, give its minimum corrective action.
- If a continuing route needs multiple interdependent material changes, provide a concise dependency-ordered revision plan. Preserve valid goals, facts, choices, and boundaries; connect each finding through the affected outcome, risk, or pivotal choice and owning technical boundary to required behavior and closing evidence.
- If a pivotal premise or comparison remains unproven, give the minimum validation, relevant outcome branches, and their effect on the commitment; do not present a conditional route as approved.
- If the route or owning design is unsound, identify the goal, responsibility, authority, contract, state, or boundary that must reopen and the viable directions to reconsider; do not build a patch plan around it.

Do not expand a handoff into code, test organization, naming, formatting, documentation, or opportunistic cleanup. Once a finding requires reopening the route, omit secondary issues that cannot change the reason, viable directions, material risk, or minimum action. End only with evidence boundaries, revalidation triggers, residual risks, or intentional exclusions that still affect the decision. Remove every sentence whose absence would not change the judgment, evidence boundary, revision path, or remaining material risk. Use concrete project terms and natural engineering language; avoid fixed verdict labels, generic praise, and performative completeness.
