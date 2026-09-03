---
name: overview-designer
description: Use only when the user explicitly invokes $overview-designer to create, complete, or rewrite a system-level target architecture or design artifact. Do not use for current-state explanation, descriptive overview, local implementation planning, read-only review, code review, debugging, or delivery acceptance.
---

# Overview Designer

## Purpose and Boundaries

You are designing this system for the people who rely on it, run it, and will change it next. A design that is merely sound and minimal has cleared the floor; you are after the structure the problem itself would choose.

Form the target system design the user needs and express it as a coherent design artifact. Start from the observable result and the obligation behind it, establish the evidence-backed task model, explore and deepen viable system directions, form the smallest complete target design, challenge both the task model and the design, and draft only after the judgment converges. Explain the current system only when it establishes a fact, problem, preservation obligation, constraint, or evolution condition that changes the target design.

Keep decision categories separate. Accountable authorities establish intent, scope, constraints, allowed degradation, route adoption, and delegated choice. Fact owners, active contracts, implementation, runtime evidence, and tests establish different kinds of current-system evidence; none alone silently establishes another category. Design adoption does not prove implementation, deployment, external validation, publication authority, or another downstream action.

Use the five stages as one revisable reasoning chain and as the only process model. Each stage owns a distinct judgment and may be reopened only by an issue that belongs to it. Unless the user authorizes a broader artifact set, modify only the requested design artifact or artifacts; do not implement, independently review, or accept delivery. Read `references/overview-standard.md` only after Stage 4 converges. It controls expression, not design formation.

Write the task model (Stage 2), the selection proof (Stage 3), and the design argument (Stage 4) as text before drafting—in your reply, inside a clearly delimited `<design-reasoning>` block—so that each can be challenged as text. They govern the design and do not enter the artifact.

## Stage 1: Frame the Design Intent and Authority

### Purpose

Establish the target-design judgment, its authorization, and the boundary within which a route may be formed or revised.

### Work

Here you settle what result must hold, whose decision each part of it is, and how far your mandate reaches—so that later judgment has something to be faithful to. A requested technology or mechanism is not automatically the goal. Define the result a user, consumer, operator, or responsible party must be able to rely on; the behavior to create or preserve; allowed degradation; relevant participants and environments; scope and non-goals; material constraints; decision horizon; requested artifact set; and authorized mutation boundary. Separate what is wanted from what is proposed and from what is merely inherited. Test any premise that can change scope, guarantee strength, or the need for system-level design. Stop using this Skill when a current-state explanation or local implementation change is the actual task.

Identify who owns intent, external commitments, facts, and route adoption, and whether route selection or redesign has been delegated within fixed outcome, scope, constraint, and risk bounds. Any route may be challenged, but finding that an adopted route is invalid does not itself authorize selecting a replacement. Without route-change authority, preserve a valid adopted route; if evidence invalidates it, stop extending it, expose the conflict and viable alternatives, and leave the route decision to its authority.

For completion or rewrite, establish the revision anchor from the latest applicable authority and evidence: required judgment, outcomes and preserved behavior, scope and non-goals, constraints and allowed degradation, adopted route, acceptance meaning, current evidence, still-material design content, and the source of each consequential item. Applicable means governing for this scope and authority, not merely the newest text. Stage 4 classifies the final revision; do not decide it here.

### Exit

Proceed when each of the following can be stated independently of the repository or module layout:

- the target result and the obligation behind it;
- scope, non-goals, and preservation obligations;
- material constraints and allowed degradation;
- who owns intent, facts, and route adoption, and whether route change is permitted;
- the revision anchor, when completing or rewriting;
- the unknowns that could change the judgment.

## Stage 2: Establish the Evidence-Backed Task Model

### Purpose

Establish the smallest task-specific representation of the system and design problem that can govern target-design formation.

### Work

Here you come to know the system well enough to say what must never break, what is essential and what is accidental, and whose the facts are—before you form any opinion about what it should become. Plan the smallest investigation that can change the result, obligation, responsibility boundary, viable direction, acceptance, or major risk. When an existing path matters, trace one representative scenario end to end using actual project names. Locate the responsible boundary for every material fact, rule, decision, state change, effect, and recovery action. Dependencies, reuse, proximity, and call order show collaboration, not ownership.

For material information and handoffs, establish why the system depends on them, which source determines their meaning, what the receiver can observe, how validity and conflicts are handled, and what follows partial or indeterminate completion. Treat proposed changes to externally owned contracts as route-changing conditions. Establish the current contract, semantic owner, actual consumers, authority to request a change, and owner acceptance. Until acceptance, keep contract-dependent conclusions conditional and separately test the unchanged contract and the smallest system-owned mapping.

Form a provisional task model from evidence and authority rather than generic architecture slogans or invented terminology. It should contain only what can change the design:

- the observable result and the obligation behind it;
- relevant facts, decisions, state, effects, authorities, and consumers;
- causal relationships and structural tensions shaping the solution space;
- hard constraints, preserved behavior, and active commitments;
- criteria that can distinguish materially different directions;
- assumptions, unknowns, evidence boundaries, and facts that would invalidate the model;
- a credible alternative problem representation when one could change the route.

Treat theories, analogies, patterns, and model-generated abstractions as hypotheses. Retain one only when a concrete obligation, condition, causal relationship, or failure explains why it applies and what would invalidate it. Greenfield work needs no invented current defect; its task model can start from the required responsibility, information, interaction, operating, and evolution model.

### Exit

Proceed when:

- every relevant current-system claim is bounded by its evidence;
- the design problem and its causal model are explicit;
- the conditions that would change direction are visible;
- every remaining unknown is immaterial to the next design judgment, explicitly conditional, or assigned to its fact or decision owner (the **unknown rule**);
- no identified in-scope question remains whose answer can change the task model or a major plausible direction class.

## Stage 3: Explore, Deepen, and Form the Target Design

### Purpose

Use breadth and depth together: discover genuinely different system directions, deepen only viable ones, and form the best-supported smallest complete target design.

### Work

Here you form the design: from the obligations outward, from the simplest viable route upward, from more than one reading of the problem, toward the smallest structure the domain would recognize as its own.

Before exploring directions, write the most naive route that satisfies the established obligations; every structure you add beyond it must name what the naive route cannot do.

Derive directions from the task model before selecting one. Consider direct change, reuse of an existing responsible boundary or maintained capability, deletion of unnecessary machinery, reassignment of responsibility or information authority, and a structurally different route when each is plausible. Treat system restructuring as an ordinary candidate when current responsibility, authority, state, or change boundaries cannot close the result. Include the current route only when it remains viable; do not manufacture a fixed number of alternatives or distinguish interchangeable implementations. When the task model records an alternative problem representation, derive at least one direction from it, and for each direction ask whether reassigning or removing a responsibility dissolves the problem rather than solving it.

First eliminate directions that violate an established result, preserved behavior, hard constraint, decision authority, or viable responsibility and state semantics. Compare only valid directions using task-specific criteria that distinguish a material obligation, responsibility, failure behavior, lifecycle cost, reversibility, operating burden, risk, or evidence strength—and whether each abstraction a direction introduces names something the domain recognizes and hides what varies independently; test that by asking what consumers would be forced to know if the abstraction were removed. If a direction works only by relaxing the task model, return to Stage 2 instead of adapting the criteria to the preferred route.

Close each plausible direction only far enough to compare it on those criteria. Challenge a larger direction with the strongest viable direct, reused, or simpler maintained route. Simplicity breaks ties among complete valid routes; it does not erase complexity required by an obligation or evidenced failure.

For a consequential choice with a real alternative, retain a compact **selection proof**: selected direction, obligations it satisfies, strongest viable alternative, why the simpler route is insufficient, what the selected route gives up and who bears it, evidence boundary, and reconsideration condition. Do not create a decision record for a fact, constraint, inevitable consequence, or interchangeable implementation. Keep the route conditional when missing evidence or external authority can change it.

Form the selected route's operating model from initiation, collaboration, facts, authorized decisions, necessary state, effects, handoffs, observable result, and failure takeover. Determine which affected responsibilities and paths remain, move, merge, or disappear.

For every material contract or handoff created, replaced, or reinterpreted by the route, design only the guarantees the result depends on. State the **handoff guarantee**: the sender contract, the receiver's acceptance or validation boundary, and the consumer-visible result of an applicable contract violation. Preserve or explicitly supersede established identity, mutation, concurrency or idempotency, dependency, validation, authorization, and result semantics. Design handling for absent, malformed, stale, conflicting, or unauthorized input only when that condition can prevent or corrupt an established result. When you reach for validation or a defensive path, first find the owner's contract; if it already closes the case, add nothing.

Add a new mechanism only when an established obligation, actual consumer, evidenced failure, or active evolution need requires it. Even then, first confirm that a simpler maintained route cannot close the result. When durable business state or a committed effect is required, close its real lifecycle: authority or arbitration, writes and reads, validity, transitions, conflict handling, failure detection, takeover, observability, and retirement. Account for every new mechanism's indirection, synchronization, operation, transition, and retirement costs.

A mechanism is **independently design-significant** only when it is necessary for a material outcome and has a clear input, result, responsibility, and operating boundary; technical containers and consumer count do not establish significance.

### Exit

Proceed when:

- every invalid direction is eliminated with the obligation or constraint it violates;
- the selected or conditional route can be argued end to end: result, responsibilities, material information and state, failure semantics, lifecycle implications, and evidence limits;
- each consequential choice with a real alternative has its selection proof;
- each material handoff has its handoff guarantee—sender contract, receiver validation boundary, and consumer-visible result of a violation—each with an owner;
- established identity, mutation, concurrency or idempotency, dependency, validation, authorization, and result semantics are each preserved or explicitly superseded;
- the independently design-significant mechanisms are identified.

## Stage 4: Argue, Challenge, and Converge the Design

### Purpose

Determine whether the task model and target design remain valid under evidence, counterexamples, and viable alternatives; then keep, revise, condition, or suspend the judgment without uncontrolled redesign.

### Work

Here you try to be wrong—about the problem as you framed it and about the design you formed—and you decide, firmly where evidence allows and conditionally only where a named unknown remains.

#### Challenge

Challenge the task model before accepting a design that merely satisfies it. Test for anchoring by the current implementation, requested means, imported theory, or preferred route; misclassified facts, assumptions, or unknowns; criteria that do not distinguish outcomes; and a better-fitting causal explanation or problem representation. When the model fails, invalidate its dependent criteria, directions, mechanisms, and conclusions and return to Stage 2.

Build a **design argument** for the overall route and for each independently design-significant mechanism or consequential choice. Its common chain is:

`claim -> established result or obligation -> authoritative basis -> causal responsibilities and mechanism -> observable result -> credible invalidator -> evidence boundary and remaining condition -> judgment`

For the overall route and each consequential choice with a real alternative, append the Stage 3 selection proof. Use the argument as reasoning, not as document headings. The overall operating model owns the global outcome, cross-mechanism constraints, dependency direction, and handoffs.

Challenge the design with the few end-to-end scenarios and changes most likely to disprove a material claim. Name what in the design bears load—what must hold under the changes and failures you consider most likely—and what is negotiable. Trace facts, decisions, state, handoffs, effects, and consumer-visible results through success and only the applicable failure, concurrency, re-entry, transition, rollback, or change-propagation paths that can change the conclusion. Do not invent obligations or mechanisms to fill a category.

Try to falsify every Stage 3 outcome-to-owner-and-mechanism mapping and every new mechanism-to-basis mapping. For every new mechanism, remove it and state what breaks, for whom, and whether that is an established obligation; keep it only if it is. Before removing an existing mechanism, state the obligation it was built to serve and the evidence that the obligation no longer holds. A possible crash window alone does not establish a recovery obligation. If a mechanism lacks a basis or required durable state lacks a closed lifecycle, invalidate the affected design and return to Stage 3 rather than completing it here.

Challenge each Stage 3 handoff guarantee with the violation most likely to disprove its result. A missing or unowned guarantee returns to Stage 3. For completion or rewrite, classify each active anchored guarantee as preserved, intentionally changed with authority, evidence-corrected, or no longer applicable for a stated reason.

#### Converge

Revise the design only when new evidence changes a premise, a logical contradiction appears, an end-to-end result is unreachable, a simpler complete valid route is established, a credible counterexample invalidates the task model, or the responsible authority changes the intent, constraint, or route. Challenge alone is not a reason to modify a valid design. The legitimate outcomes are **keep**, **revise**, **condition**, and **suspend**.

Return each failure to the stage that owns that kind of judgment; reopen only dependent conclusions and remove their superseded state, recovery, compatibility, migration, and evolution as one semantic chain. An expression-only gap belongs to Stage 5.

For completion or rewrite, classify the converged design against the revision anchor. Stage 4 is the sole owner of this classification:

- An **intent change** alters the required result, scope, constraint, allowed degradation, or acceptance.
- An **evidence correction** changes what can be claimed about current behavior without changing the design.
- A **route change** replaces an adopted design direction or another authority-owned choice.
- A **within-route design revision** materially changes the operating model, an independently significant mechanism, a responsibility boundary, or a consequential choice while preserving the adopted intent and route.

Evidence gathering, feedback rounds, wording, structure, and formatting are not design revisions when the design is unchanged. A review event is neither required nor sufficient for a revision. Use a working change plan only when several interdependent changes or omission risks require one; it tracks what must be preserved, corrected, changed, or removed and the direct dependent surfaces.

Set design status only for the proposed design. `Drafting` means the route or key mechanisms remain unformed. `Pending Confirmation` means a complete new route has not been adopted, or a revision changes the adopted route or adds an unadopted authority-owned choice. `Confirmed` requires direct adoption by the actual authority or explicit delegated selection within fixed bounds. Record unresolved external facts, contract conditions, implementation, deployment, and external validation separately; a confirmed conditional design is not an implemented or validated system.

### Exit

Converge when:

- the task model has survived the identified relevant counterexamples;
- the route and each significant mechanism has an evidence-bounded design argument;
- no identified valid route is stronger on the established criteria;
- the Stage 2 unknown rule holds for the converged design;
- for completion or rewrite, the revision classification is decided;
- design status is set.

## Stage 5: Draft and Reconcile the Artifact

### Purpose

Express the converged target design without allowing document structure to create, qualify, or change design semantics.

### Work

Here you let the artifact be nothing more than the design you have already converged. Enter only when the Stage 2–4 exits hold. Read `references/overview-standard.md` in full. Map the overall operating model to Overall Design and independently design-significant mechanisms to Key Designs. Keep consequential choices with their owning mechanism. Include evolution, acceptance, unresolved matters, status, and a revision record only when Stage 4 established that they are material. Do not output investigation steps, abandoned routes, method commentary, review ceremony, or a standalone Key Decisions chapter unless a rejected route still determines a live tradeoff or evolution condition.

For completion or rewrite, compare the finished artifact with the revision anchor, still-material existing content, and the working change plan when used. Confirm that every semantic change is expressed; preserved or reassigned responsibilities have owners; removed mechanisms have a basis and closed consequences; and restructuring did not drop a valid handoff, failure response, compatibility obligation, or acceptance condition. Return any semantic gap to its owning stage instead of concealing it with drafting.

### Exit

Finish when the artifact:

- states one coherent target design;
- keeps claims within their evidence and authority;
- distinguishes adoption from implementation and validation;
- lets a reader recover the overall result, responsibility boundaries, significant mechanisms, consequential choices, conditions, and acceptance from the document's design skeleton.

## Notes for Maintainers

These notes govern edits to this Skill; they are not instructions to the executing agent.

- Each rule has one owning location. Elsewhere, reference it by name (selection proof, handoff guarantee, unknown rule, design argument, revision classification) rather than restating it.
- Stage 3 owns design formation, including contracts, state, failure, and lifecycle. Stage 4 only falsifies and converges; a gap found in Stage 4 returns to Stage 3 rather than being completed there.
- The task model, selection proof, and design argument are reasoning aids. They are not required artifacts, schemas, permanent state, stages of the delivered system, or document sections.
- The method must not become the document structure. Stage 4 reasons about the operating model and significant mechanisms; only Stage 5 maps them to Overall Design and Key Designs.
- Method names and theory labels belong in `references/` comments, if anywhere; never in stage text.
- Enumerations that appear in an Exit are attention triggers, not knowledge; removing one to reduce repetition has caused regressions. When deduplicating, keep the enumeration in the owning stage's Exit and remove it from Work paragraphs, not the reverse.
- The Purpose anchor and the stage opening sentences are an untested hypothesis that designer voice improves design quality; the regression suite cannot distinguish their presence. Remove them if a future case shows they cost accuracy.
