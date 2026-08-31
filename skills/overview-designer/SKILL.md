---
name: overview-designer
description: Use only when the user explicitly invokes $overview-designer to create, complete, or rewrite a system-level architecture or design artifact. Do not use for ad hoc explanation without a requested artifact, local implementation planning, read-only review, code review, debugging, or delivery acceptance.
---

# Overview Designer

## Purpose and Operating Model

Form the system-level judgment the user needs and express it as a coherent design artifact. Start from what the reader must understand or decide and the observable result that matters. Explain the existing system only when it changes that judgment. When a new or changed result is required, establish the real problem, compare viable directions, choose the best-supported smallest complete design, close its necessary mechanisms, and define how the result can be accepted.

Keep evidence, authority, proposed design, adoption, implementation, and external validation distinct. Bound existing-behavior claims by the code, contracts, tests, runtime evidence, or accountable owners that establish them. Unless the user authorizes a broader artifact set, modify only the requested design artifact or artifacts; do not implement, independently review, or accept delivery as part of this task.

Use the five stages as one revisable reasoning chain. The Unified Design Model governs every stage; each stage owns a distinct reasoning responsibility. Read `references/overview-standard.md` only after the judgment converges. It controls expression, not design formation, and the method must not become the document structure.

## Unified Design Model

### Governing Design Mind

Start from the result a user, consumer, operator, or responsible party must be able to rely on. Establish the obligation behind a requested result, guarantee, or constraint before designing state, recovery, compatibility, migration, or another quality mechanism. Separate intent, facts, constraints, inherited decisions, new decisions, assumptions, risks, and unresolved conditions; limit every conclusion to its evidence and authority.

Treat the existing system as evidence and an evolution constraint, not as the boundary of the solution space. Look beyond the current repository when an active external contract, adjacent responsibility, maintained capability, established standard, or mature solution can change the judgment. Investigate only while more evidence can change the result, obligation, responsibility boundary, viable direction, key mechanism, acceptance, or major risk.

Before forming directions, establish a provisional task-specific representation of the actual problem, causal relationships, governing obligations and constraints, distinguishing criteria, and invalidating facts. Derive it from evidence and authority rather than generic principles or invented terminology. It is a reasoning aid, not a required artifact, schema, stage, or document section.

Prefer reuse, direct change, deletion, and clear responsibility before new structure. Seek the smallest complete design, not the smallest diff, fewest boxes, or richest architecture. Challenge the current implementation, requested means, and preferred candidate against the strongest viable simpler or established route. When a premise fails, re-derive only dependent conclusions and delete invalidated machinery. Stop when deeper analysis can only perfect an unrequired mechanism or implementation detail.

### System Design Standard

Use the following as causal tests, not document headings or a scorecard. For a descriptive overview, use them only to expose gaps material to the requested explanation; do not turn an observed gap into an unsolicited target design.

- **Outcome and evidence:** Carry every established outcome, preserved behavior, commitment, allowed degradation, correctness condition, and material constraint through the applicable success, failure, concurrency, and degradation paths. Every mechanism must contribute to a result an actual consumer or responsible party can observe and rely on. Do not substitute local technical completion for that result or invent a guarantee to make the design look complete.
- **Responsibility, authority, and information:** Assign each material fact, policy, decision, state change, effect, and failure response to the boundary able to guarantee its meaning. Distinguish original facts, derived results, durable state, caches, events, projections, and external representations by authority and dependency. Use contracts to bind collaboration without duplicating policy or creating competing decision sources; a subordinate representation must not silently acquire authority.
- **Boundaries and justified structure:** Derive boundaries and dependency direction from responsibility, authority, change drivers, contracts, trust, lifecycle, and failure scope rather than the package tree. Add a boundary, abstraction, protocol, state, configuration, cache, extension point, or compatibility path only when it centralizes a real invariant, serves an actual consumer, contains an evidenced change, or closes an established gap that a simpler maintained route cannot close. Include its indirection, synchronization, operation, migration, and removal cost.
- **Runtime and evolution closure:** Retain cross-operation state only when an established outcome, active contract, actual consumer, durable fact, committed effect, observed failure, or operating responsibility requires it. Then define its source or arbitration, writes and reads, validity, transitions, conflict handling, recovery, and retirement. Carry results through applicable handoffs, partial or indeterminate completion, failure detection, takeover, and observability. Model coexistence, cutover, rollback, irreversible points, and old-path exit only when an established change requires them; infrastructure readiness is not system completion.

### Decision, Adoption, and Revision

First eliminate directions that violate an established outcome, preserved behavior, hard constraint, decision authority, or viable responsibility and state semantics. Compare only valid directions by ownership clarity, change containment, runtime correctness, lifecycle cost, reversibility, operating burden, and evidence strength. Simplicity breaks ties among complete valid routes; it does not erase complexity required by an obligation or evidenced failure.

Derive the design horizon from an active commitment, governing contract, necessary transition, or evidenced change within the system's intended life. A plausible future demand may shape present change containment when it can change the decision, but does not justify delivering future capability, a roadmap, or compatibility path without an active commitment and accountable trigger.

For a mechanism that expands lifecycle—such as new decision authority, authoritative state or representation, cross-boundary coordination, an independent operating owner, an externally owned contract change, migration, an irreversible effect, or material deployment and retirement cost—state the obligation, actual consumer, owner, simplest viable maintained alternative and its evidenced gap, how the mechanism closes it, and its lifecycle cost. If removing it does not break an established result, remove it.

Apply architecture constraints at their declared boundary; do not satisfy them by silently moving a prohibited responsibility elsewhere. If an established obligation conflicts with an explicit constraint, expose the conflict for the responsible party to decide rather than silently changing either. Treat a proposed change to an externally owned contract as a route-changing condition. Establish the current contract, semantic owner, actual consumers, authority to request the change, and owner acceptance. Until acceptance, keep contract-dependent conclusions conditional, do not derive migration, compatibility, persistence, or recovery from the change, and test the unchanged contract and smallest system-owned mapping separately. Owner acceptance closes the contract condition; it does not adopt the system route, which still requires the design authority under the status rules below.

For completion or rewrite, anchor the revision to the latest applicable intent and authority: required judgment, outcomes and preserved behavior, evidence, scope and non-goals, constraints and allowed degradation, adopted route, acceptance meaning, and source of each consequential item. Applicable means governing for this authority and scope, not merely the newest text; leave conflicting authoritative inputs unresolved until their owner decides. Classify changes before applying them:

- An **intent change** alters the required judgment, outcome, scope, constraint, or acceptance.
- An **evidence correction** changes what can be claimed about existing behavior.
- A **route change** alters an adopted design or an authority-owned choice.
- A **within-route design revision** materially changes the operating model, an independently design-significant mechanism, a responsibility boundary, or a consequential choice without changing the adopted intent or route.

Evidence gathering, review rounds, wording, structure, and formatting are not design revisions when the design is unchanged. Feedback, an implementation detail, or a preferred mechanism does not itself authorize an intent or route change. Preserve an adopted route unless its authority changes it or authorizes redesign against established goals and constraints. Reopen only conclusions dependent on changed evidence, intent, constraints, or route; remove their superseded state, recovery, compatibility, migration, and evolution as one chain. Use a working change plan only when several interdependent changes or omission risks require one. It records what must be preserved, corrected, changed, or removed, each item's direct dependent surfaces, and the evidence that closes them; together these form the semantic change surface. The plan is not a permanent protocol or the artifact's revision record.

Use design status only for a proposed design. `Drafting` means the route or key mechanisms remain unformed. `Pending Confirmation` means a complete new route has not been adopted, or a revision changes the adopted route or adds an unadopted authority-owned choice. `Confirmed` requires direct adoption by the actual authority or explicit delegation of route selection within fixed outcome, scope, constraint, and risk bounds, with the design remaining inside those bounds. It remains valid for evidence corrections or necessary technical closure within the adopted intent and route. Design adoption does not establish implementation, external validation, or authorization for publication or another downstream action.

## Stage 1: Frame the Required System Judgment

Define what the reader must understand or decide, the observable result, preserved or explained behavior, required change, allowed degradation, relevant participants and environments, scope and non-goals, requested artifact set and authorized mutation boundary, material constraints, decision horizon, authority, delegation, and unresolved conditions that can change the judgment. Identify the primary question and the few concerns capable of changing its answer.

Separate desired results, symptoms or starting conditions, causal claims, constraints, inherited decisions, and proposed means. A requested technology or mechanism is not automatically the goal. Test premises that can change scope, guarantee strength, or route. Do not manufacture a redesign when explanation is sufficient, expand to system design when a local change closes the result, or invent a baseline for greenfield work.

For completion or rewrite, establish the revision anchor and apply the change classification from the Unified Design Model. Match sources to claims: accountable owners establish intent and adoption; contracts establish external commitments; runtime evidence establishes behavior in a specific environment; implementation establishes the present path; tests establish protected expectations. Proceed when the judgment, result, scope, preservation obligations, authority, and judgment-changing unknowns can be stated independently of the module layout.

## Stage 2: Understand the Relevant System and Establish the Problem

Plan the smallest investigation that can answer the material questions. Before deepening a concern, identify which conclusion, obligation, acceptance condition, viable route, or major risk it can change. Trace a representative end-to-end scenario when an existing path matters: initiator, participants, original facts, business decisions, state changes, effects, result handoff, and applicable failure response. Locate the responsible boundary for each material fact, rule, decision, state change, effect, and recovery action. Dependencies, reuse, proximity, and call order show collaboration, not ownership.

For material information and handoffs, establish why the system depends on them, which source determines their meaning, what the receiver can observe, how validity and conflicts are handled, and what follows partial or indeterminate completion. Preserve unknown owners, conflicting sources, invalid transitions, absent recovery, and uncontained change paths as facts instead of inventing structure to complete the model.

Treat theories, analogies, principles, and model-generated abstractions as hypotheses. Retain one only when a concrete obligation, condition, causal relationship, or failure explains why it applies, which decision it can change, and what would invalidate it. When change containment can determine a boundary, trace representative business-rule and technology or integration changes through their owners, contracts, dependent mechanisms, deployment, and tests.

For a new or changed result, establish the design problem: the result to create, obligations and forces that must hold together, relevant starting conditions, and the causal gap or structural tension shaping the solution space. Greenfield work needs no existing failure; its problem is the required responsibility, information, interaction, and operating model. Proceed when existing operation is evidence-bounded where relevant, the problem is explicit, and route-changing conditions are visible. Stop when more evidence cannot change the judgment.

## Stage 3: Form the System Judgment

Build the answer around the required result using only facts, constraints, and causal relationships that can change it. Existing operation may supply the explanation, starting condition, or evolution constraint; it is not a mandatory first step. When no design choice is required, synthesize the evidence-bounded outcome chain, responsibilities or gaps, information and state, handoffs, failure behavior, and limits without inventing a target route.

When design is required, derive genuinely viable directions from the established problem before selecting one. Consider direct change, reuse of an existing responsible boundary or maintained capability, deletion of unnecessary machinery, reassignment of responsibility or information authority, and a structurally different route when each is plausible. Treat system restructuring as an ordinary candidate when current responsibility, authority, state, or change boundaries cannot close the result. Include the current route only when it remains viable; do not manufacture a fixed number of alternatives or distinguish interchangeable implementations.

Use criteria that distinguish a material outcome, obligation, constraint, responsibility, failure behavior, lifecycle cost, or risk. If a direction works only by relaxing the established problem representation, reopen the affected premise instead of adapting the criteria to the preferred route. Close each plausible direction only far enough to compare its observable result, responsibilities, material contracts, necessary information and state, failure semantics, change propagation, operating burden, evolution, reversibility, and evidence. Eliminate invalid routes before comparing tradeoffs.

For a consequential choice, retain a compact selection proof: selected direction, obligations it satisfies, strongest viable alternative, why the simpler route is insufficient, cost bearer, evidence boundary, and reconsideration condition. Keep the route conditional when missing evidence or external authority can change it; do not create a decision record for a fact, constraint, inevitable consequence, or interchangeable implementation.

Form the selected route's operating model from initiation, collaboration, facts, authorized decisions, necessary state, effects, handoffs, observable result, and failure takeover. Determine which affected responsibilities and paths remain, move, merge, or disappear. Proceed when either the descriptive judgment is evidence-bounded, or invalid design routes are eliminated and the selected or conditional route is complete enough to challenge end to end.

## Stage 4: Close, Challenge, and Converge the Judgment

Use the overall operating model as the semantic owner of the global result, cross-mechanism constraints, dependency direction, and handoffs. Treat a mechanism as independently design-significant only when it is necessary to explain or produce a material outcome and has a clear input, result, responsibility, and operating boundary. A proposed mechanism must own an otherwise unsupported outcome, correctness condition, or material constraint. Repositories, services, tables, interfaces, stores, or consumer count do not decide significance, and significance here does not preselect document sections.

Map explained behavior to its evidence and environment; map every outcome, preserved behavior, and constraint to an owner, mechanism, and observable result; map every proposed boundary, dependency, abstraction, state, representation, and compatibility path to an established obligation, change-containment need, active evolution need, or named risk. Remove anything without a basis. Derive the affected surface semantically rather than from a file list.

Challenge the few end-to-end scenarios most likely to disprove or change the judgment. Trace applicable facts, decisions, information changes, state transitions, responsibility handoffs, effects, and consumer-visible results through success, failure, partial or indeterminate completion, concurrency, degradation, branches, re-entry, migration, rollback, and change propagation. Inspect only scenarios that can change a material conclusion; leave unsupported behavior unknown.

Challenge both the selected route and the problem representation behind it. Test the most consequential classification, abstraction, imported principle, and causal premise against a credible counterexample or alternative explanation. When one fails, invalidate its dependent criteria, directions, mechanisms, and conclusions before reforming only the affected judgment.

A possible crash window does not establish a recovery obligation. First determine whether removing the guarantee preserves every established result. Once durable business state or a committed effect is required, close its real lifecycle and recovery. Support an external guarantee with evidence from its owner rather than an interface, SDK, or mock alone. Model evolution only when an established change requires coexistence or transition.

Resolve judgment-changing uncertainty, make the affected conclusion conditional, or suspend it. Reconcile completion or rewrite against the revision anchor and working change plan when used; account for anchored outcomes, facts, preserved behavior, non-goals, constraints, adopted route, and acceptance as preserved, evidence-corrected, authority-changed, or no longer applicable for a stated reason. Confirm that a correction did not silently change the goal, add a guarantee, redesign the adopted route, or shift the artifact's purpose. Apply the established status rules rather than redefining them here.

Converge when further evidence, scenarios, or viable alternatives cannot materially change what the reader must understand or decide—not when every implementation detail is known. If a speculative concern dominates without changing an obligation, route, acceptance condition, or major risk, remove it and recenter.

## Stage 5: Draft and Reconcile the Artifact

After convergence, read `references/overview-standard.md` in full. Map the overall operating model and independently design-significant mechanisms into the artifact; do not let desired sections create or qualify mechanisms. Express only the required judgment, keep claims within their evidence, distinguish proposed design from implementation, and omit investigation steps, abandoned routes, review history, approval ceremony, and method commentary unless a rejected route still determines a live tradeoff or evolution condition.

For completion or rewrite, compare the finished artifact with the revision anchor, still-material existing content, and working change plan when used. Confirm that every semantic change is expressed, preserved or reassigned responsibilities have owners, removed mechanisms have a basis and closed consequences, and restructuring did not drop a valid handoff, failure response, or acceptance obligation. Return any semantic gap to the stage that owns it instead of concealing it with drafting.
