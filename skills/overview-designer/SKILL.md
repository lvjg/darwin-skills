---
name: overview-designer
description: Use only when the user explicitly invokes $overview-designer to create, complete, or rewrite a system-level target architecture or design artifact. Do not use for current-state explanation, descriptive overview, local implementation planning, read-only review, code review, debugging, or delivery acceptance.
---

# Overview Designer

## Purpose and Boundaries

Form the target system design the user needs and express it as a coherent design artifact. Start from the observable result and the obligation behind it, establish the evidence-backed task model, explore and deepen viable system directions, form the smallest complete target design, challenge both the task model and the design, and draft only after the judgment converges. Explain the current system only when it establishes a fact, problem, preservation obligation, constraint, or evolution condition that changes the target design.

Keep decision categories separate. Accountable authorities establish intent, scope, constraints, allowed degradation, route adoption, and delegated choice. Fact owners, active contracts, implementation, runtime evidence, and tests establish different kinds of current-system evidence; none alone silently establishes another category. The task model organizes these inputs but does not become a new authority. Design adoption does not prove implementation, deployment, external validation, publication authority, or another downstream action.

Use the five stages as one revisable reasoning chain and as the only process model. Each stage owns a distinct judgment and may be reopened only by an issue that belongs to it. Unless the user authorizes a broader artifact set, modify only the requested design artifact or artifacts; do not implement, independently review, or accept delivery. Read `references/overview-standard.md` only after Stage 4 converges. It controls expression, not design formation, and the method must not become the document structure.

## Stage 1: Frame the Design Intent and Authority

### Purpose

Establish the target-design judgment, its authorization, and the boundary within which a route may be formed or revised.

### Work

Define the result a user, consumer, operator, or responsible party must be able to rely on; the behavior to create or preserve; allowed degradation; relevant participants and environments; scope and non-goals; material constraints; decision horizon; requested artifact set; and authorized mutation boundary. Separate desired results, symptoms, causal claims, inherited decisions, proposed means, and implementation preferences. A requested technology or mechanism is not automatically the goal. Test any premise that can change scope, guarantee strength, or the need for system-level design. Stop using this Skill when a current-state explanation or local implementation change is the actual task.

Identify who owns intent, external commitments, facts, and route adoption, and whether route selection or redesign has been delegated within fixed outcome, scope, constraint, and risk bounds. Any route may be challenged, but finding that an adopted route is invalid does not itself authorize selecting a replacement. Without route-change authority, preserve a valid adopted route; if evidence invalidates it, stop extending it, expose the conflict and viable alternatives, and leave the route decision to its authority.

For completion or rewrite, establish the revision anchor from the latest applicable authority and evidence: required judgment, outcomes and preserved behavior, scope and non-goals, constraints and allowed degradation, adopted route, acceptance meaning, current evidence, still-material design content, and the source of each consequential item. Applicable means governing for this scope and authority, not merely the newest text. Define the classifications here but do not decide the final revision record yet:

- An **intent change** alters the required result, scope, constraint, allowed degradation, or acceptance.
- An **evidence correction** changes what can be claimed about current behavior without changing the design.
- A **route change** replaces an adopted design direction or another authority-owned choice.
- A **within-route design revision** materially changes the operating model, an independently significant mechanism, a responsibility boundary, or a consequential choice while preserving the adopted intent and route.

Evidence gathering, feedback rounds, wording, structure, and formatting are not design revisions when the design is unchanged. A review event is neither required nor sufficient for a revision.

### Exit

Proceed when the target result, scope, preservation obligations, constraints, authority, route-change permission, revision anchor when applicable, and judgment-changing unknowns can be stated independently of the repository or module layout.

## Stage 2: Establish the Evidence-Backed Task Model

### Purpose

Establish the smallest task-specific representation of the system and design problem that can govern target-design formation.

### Work

Plan the smallest investigation that can change the result, obligation, responsibility boundary, viable direction, acceptance, or major risk. When an existing path matters, trace a representative end-to-end scenario through initiator, participants, original facts, business decisions, state changes, effects, result handoff, and applicable failure response. Locate the responsible boundary for every material fact, rule, decision, state change, effect, and recovery action. Dependencies, reuse, proximity, and call order show collaboration, not ownership.

For material information and handoffs, establish why the system depends on them, which source determines their meaning, what the receiver can observe, how validity and conflicts are handled, and what follows partial or indeterminate completion. Treat proposed changes to externally owned contracts as route-changing conditions. Establish the current contract, semantic owner, actual consumers, authority to request a change, and owner acceptance. Until acceptance, keep contract-dependent conclusions conditional and separately test the unchanged contract and the smallest system-owned mapping.

Form a provisional task model from evidence and authority rather than generic architecture slogans or invented terminology. It should contain only what can change the design:

- the observable result and the obligation behind it;
- relevant facts, decisions, state, effects, authorities, and consumers;
- causal relationships and structural tensions shaping the solution space;
- hard constraints, preserved behavior, and active commitments;
- criteria that can distinguish materially different directions;
- assumptions, unknowns, evidence boundaries, and facts that would invalidate the model;
- a credible alternative problem representation when one could change the route.

Treat theories, analogies, patterns, and model-generated abstractions as hypotheses. Retain one only when a concrete obligation, condition, causal relationship, or failure explains why it applies and what would invalidate it. Greenfield work needs no invented current defect; its task model can start from the required responsibility, information, interaction, operating, and evolution model. The task model is a temporary reasoning aid, not a required artifact, schema, permanent state, stage of the delivered system, or document section.

### Exit

Proceed when relevant current-system claims are evidence-bounded, the design problem and causal model are explicit, and direction-changing conditions are visible. Every remaining unknown must be immaterial to the next design judgment, explicitly conditional, or assigned to its fact or decision owner; no identified in-scope question remains whose answer can change the task model or a major plausible direction class.

## Stage 3: Explore, Deepen, and Form the Target Design

### Purpose

Use breadth and depth together: discover genuinely different system directions, deepen only viable ones, and form the best-supported smallest complete target design.

### Work

Derive directions from the task model before selecting one. Consider direct change, reuse of an existing responsible boundary or maintained capability, deletion of unnecessary machinery, reassignment of responsibility or information authority, and a structurally different route when each is plausible. Treat system restructuring as an ordinary candidate when current responsibility, authority, state, or change boundaries cannot close the result. Include the current route only when it remains viable; do not manufacture a fixed number of alternatives or distinguish interchangeable implementations.

First eliminate directions that violate an established result, preserved behavior, hard constraint, decision authority, or viable responsibility and state semantics. Compare only valid directions using task-specific criteria that distinguish a material obligation, responsibility, failure behavior, lifecycle cost, reversibility, operating burden, risk, or evidence strength. If a direction works only by relaxing the task model, return to Stage 2 instead of adapting the criteria to the preferred route.

Close each plausible direction only far enough to compare its observable result, responsibilities, material contracts, necessary information and state, failure semantics, change propagation, operating burden, evolution, reversibility, and evidence boundary. Challenge a larger direction with the strongest viable direct, reused, or simpler maintained route. Simplicity breaks ties among complete valid routes; it does not erase complexity required by an obligation or evidenced failure.

For a consequential choice with a real alternative, retain a compact selection proof: selected direction, obligations it satisfies, strongest viable alternative, why the simpler route is insufficient, cost bearer, evidence boundary, and reconsideration condition. Do not create a decision record for a fact, constraint, inevitable consequence, or interchangeable implementation. Keep the route conditional when missing evidence or external authority can change it.

Form the selected route's operating model from initiation, collaboration, facts, authorized decisions, necessary state, effects, handoffs, observable result, and failure takeover. Determine which affected responsibilities and paths remain, move, merge, or disappear.

For every material contract or handoff created, replaced, or reinterpreted by the route, design only the guarantees the result depends on. State the sender contract, the receiver's acceptance or validation boundary, and the consumer-visible result of an applicable contract violation. Preserve or explicitly supersede established identity, mutation, concurrency or idempotency, dependency, validation, authorization, and result semantics. Design handling for absent, malformed, stale, conflicting, or unauthorized input only when that condition can prevent or corrupt an established result; do not add a generic defensive layer when the owner contract already closes it.

Add a boundary, abstraction, protocol, state, configuration, cache, extension point, compatibility path, recovery mechanism, or migration only when an established obligation, actual consumer, evidenced failure, or active evolution need requires it and a simpler maintained route cannot close the result. When durable business state or a committed effect is required, close its real lifecycle: authority or arbitration, writes and reads, validity, transitions, conflict handling, failure detection, takeover, observability, and retirement. Account for every new mechanism's indirection, synchronization, operation, transition, and retirement costs.

### Exit

Proceed when invalid directions are eliminated and the selected or conditional route is complete enough to argue end to end: its result, responsibilities, material information and state, contract and handoff guarantees, applicable violation results, failure semantics, lifecycle implications, evidence limits, and strongest real alternative when one exists are explicit.

## Stage 4: Argue, Challenge, and Converge the Design

### Purpose

Determine whether the task model and target design remain valid under evidence, counterexamples, and viable alternatives; then keep, revise, condition, or suspend the judgment without uncontrolled redesign.

### Work

Build a design argument for the overall route and for each independently design-significant mechanism or consequential choice. Its common chain is:

`claim -> established result or obligation -> authoritative basis -> causal responsibilities and mechanism -> observable result -> credible invalidator -> evidence boundary and remaining condition -> judgment`

For the overall route and a consequential choice with a real alternative, append the strongest viable alternative, why it is insufficient, the cost bearer, and the reconsideration condition; do not manufacture an alternative for a fact or inevitable consequence. Use the argument as reasoning, not as document headings. A mechanism is independently design-significant only when it is necessary for a material outcome and has a clear input, result, responsibility, and operating boundary; technical containers and consumer count do not establish significance. The overall operating model owns the global outcome, cross-mechanism constraints, dependency direction, and handoffs.

Challenge the task model before accepting a design that merely satisfies it. Test for anchoring by the current implementation, requested means, imported theory, or preferred route; misclassified facts, assumptions, or unknowns; criteria that do not distinguish outcomes; and a better-fitting causal explanation or problem representation. When the model fails, invalidate its dependent criteria, directions, mechanisms, and conclusions and return to Stage 2.

Challenge the design with the few end-to-end scenarios and changes most likely to disprove a material claim. Trace facts, decisions, state, handoffs, effects, and consumer-visible results through success and only the applicable failure, concurrency, re-entry, transition, rollback, or change-propagation paths that can change the conclusion. Do not invent obligations or mechanisms to fill a category.

Try to falsify every Stage 3 outcome-to-owner-and-mechanism mapping and every new mechanism-to-basis mapping. Attempt to remove the mechanism or guarantee; a possible crash window alone does not establish a recovery obligation. If a mechanism lacks a basis or required durable state lacks a closed lifecycle, invalidate the affected design and return to Stage 3 rather than completing it here.

Challenge each material contract and handoff with the applicable violation most likely to disprove its result. Verify that no Stage 3 guarantee is lost and that the sender, receiver boundary, and consumer-visible result remain owned; missing semantics return to Stage 3. For completion or rewrite, classify each active anchored guarantee as preserved, intentionally changed with authority, evidence-corrected, or no longer applicable for a stated reason.

Revise the design only when new evidence changes a premise, a logical contradiction appears, an end-to-end result is unreachable, a simpler complete valid route is established, a credible counterexample invalidates the task model, or the responsible authority changes the intent, constraint, or route. Challenge alone is not a reason to modify a valid design. The legitimate outcomes are **keep**, **revise**, **condition**, and **suspend**.

Route each failure to its owner: intent, scope, authority, or preservation errors return to Stage 1; fact, responsibility, causal-model, or problem-representation errors return to Stage 2; missing or invalid directions, selection errors, and incomplete mechanism, contract, state, failure, or lifecycle formation return to Stage 3; argument scope, unresolved counterexamples, evidence boundaries, convergence status, and revision classification remain in Stage 4; an expression-only gap belongs to Stage 5. Reopen only dependent conclusions and remove their superseded state, recovery, compatibility, migration, and evolution as one semantic chain.

For completion or rewrite, apply the Stage 1 classifications to the converged design and reconcile it against the revision anchor. Use a working change plan only when several interdependent changes or omission risks require one; it tracks what must be preserved, corrected, changed, or removed and the direct dependent surfaces, but it is not a permanent protocol or the artifact's revision record. Stage 4 is the sole owner of final revision classification.

Set design status only for the proposed design. `Drafting` means the route or key mechanisms remain unformed. `Pending Confirmation` means a complete new route has not been adopted, or a revision changes the adopted route or adds an unadopted authority-owned choice. `Confirmed` requires direct adoption by the actual authority or explicit delegated selection within fixed bounds. Record unresolved external facts, contract conditions, implementation, deployment, and external validation separately; a confirmed conditional design is not an implemented or validated system.

### Exit

Converge when the task model survives the identified relevant counterexamples, the route and significant mechanisms have evidence-bounded design arguments, and no identified valid route is stronger on the established criteria. Every remaining unknown must be immaterial, explicitly conditional, or assigned to its fact or decision owner; no identified in-scope evidence or question remains that can materially change the result, route, responsibility boundary, acceptance, or major risk.

## Stage 5: Draft and Reconcile the Artifact

### Purpose

Express the converged target design without allowing document structure to create, qualify, or change design semantics.

### Work

Read `references/overview-standard.md` in full. Map the overall operating model to Overall Design and independently design-significant mechanisms to Key Designs. Keep consequential choices with their owning mechanism. Include evolution, acceptance, unresolved matters, status, and a revision record only when Stage 4 established that they are material. Do not output investigation steps, abandoned routes, method commentary, review ceremony, or a standalone Key Decisions chapter unless a rejected route still determines a live tradeoff or evolution condition.

For completion or rewrite, compare the finished artifact with the revision anchor, still-material existing content, and the working change plan when used. Confirm that every semantic change is expressed; preserved or reassigned responsibilities have owners; removed mechanisms have a basis and closed consequences; and restructuring did not drop a valid handoff, failure response, compatibility obligation, or acceptance condition. Return any semantic gap to its owning stage instead of concealing it with drafting.

### Exit

Finish when the artifact states one coherent target design, keeps claims within their evidence and authority, distinguishes adoption from implementation and validation, and allows a reader to recover the overall result, responsibility boundaries, significant mechanisms, consequential choices, conditions, and acceptance from the document's design skeleton.
