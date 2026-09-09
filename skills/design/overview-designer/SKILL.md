---
name: overview-designer
description: Use only when the user explicitly invokes $overview-designer to create a system-level design artifact, or to modify an existing one by completing, revising, or rewriting it, including drilling into a specific key design or local part of it. Do not use for current-state explanation, descriptive overview, implementation task planning, read-only review, code review, debugging, or delivery acceptance.
---

# Overview Designer

## Purpose and Boundaries

Form a design that produces the required result across the requested scope and its surrounding handoffs. Make the consequential choices about responsibilities, abstractions, and operation; explain their benefits, costs, and conditions. Satisfy hard constraints first, then compare quality, risk, and construction, operation, and evolution cost. Prefer the simpler design when benefits are comparable. Novelty, layering, and component count are not independent goals.

Form the target design the user needs—the whole system, or the key design or local part they name—and express it as a coherent artifact. Explain the current system only where it establishes a fact, preservation obligation, constraint, or evolution condition that changes this judgment.

Keep decision categories separate. Accountable authorities establish intent, scope, constraints, allowed degradation, route adoption, and delegated choice. Fact owners, active contracts, implementation, runtime evidence, and tests establish different kinds of current-system evidence; none alone silently establishes another category. Design adoption does not prove implementation, deployment, external validation, publication authority, or another downstream action.

Use the five stages as one revisable reasoning chain and the only process model. They describe judgment dependencies, not five ceremonies to repeat: reuse still-valid knowledge and reopen only affected judgments when evidence, a better problem representation, or a material design improvement warrants it. Unless the user authorizes a broader artifact set, modify only the requested design artifacts; do not implement, independently review, or accept delivery. Read `references/overview-standard.md` after Stage 4 settles what can be stated, including a bounded suspension. It controls expression, not design formation.

## Stage 1: Frame the Design Intent and Authority

### Purpose

Establish the target-design judgment, its authorization, and the boundary within which a route may be formed or revised.

### Work

Here you settle what result must hold, whose decision each part of it is, and how far your mandate reaches—so that later judgment has something to be faithful to. A requested technology or mechanism is not automatically the goal. Define the result a user, consumer, operator, or responsible party must be able to rely on; the behavior to create or preserve; allowed degradation; relevant participants and environments; scope and non-goals; material constraints; decision horizon; requested artifact set; and authorized mutation boundary. Separate what is wanted from what is proposed and from what is merely inherited. Test any premise that can change scope, guarantee strength, or the need for system-level design. Stop using this Skill when a current-state explanation or an implementation change with no design content is the actual task. When the requested scope is a key design or a local part, the surrounding system's adopted design governs the local scope's intended boundaries and handoffs, subject to current authoritative facts and active owner contracts; design within them, and expose rather than silently change anything the local design needs from outside its scope.

Separate hard requirements from quality goals worth optimizing and establish their priority from the task and its responsible parties. For a quality goal that could change the architecture, describe the situation, needed response, and acceptance or comparison criterion; do not invent thresholds or scoring weights. If a stronger interpretation of an ambiguous guarantee would require additional authority, state, or coordination, establish that interpretation before selecting the dependent route. While that interpretation remains unresolved, preserve viable routes that do not depend on it. Resolve discoverable facts yourself; expose a material unresolved tradeoff to its decision owner. An explicitly required method remains a constraint unless its authority changes it; challenge conflicts without silently discarding the method.

Identify who owns intent, external commitments, facts, and route adoption, and whether route selection or redesign has been delegated within fixed outcome, scope, constraint, and risk bounds. Make supported choices within that delegation; do not return routine design decisions to the user merely because alternatives exist. Without route-change authority, preserve a valid adopted route; if evidence invalidates it, stop extending it, expose the conflict and viable alternatives, and leave the route decision to its authority.

For completion, revision, or rewrite, establish the revision anchor from the latest applicable authority and evidence: required judgment, outcomes and preserved behavior, scope and non-goals, constraints and allowed degradation, adopted route, acceptance meaning, current evidence, still-material design content, and the source of each consequential item. Applicable means governing for this scope and authority, not merely the newest text. Stage 4 classifies the final revision; do not decide it here.

### Exit

Proceed when each of the following can be stated independently of the repository or module layout:

- the target result and the obligation behind it;
- scope, non-goals, and preservation obligations;
- material constraints and allowed degradation;
- the quality priorities that distinguish acceptable routes, or the unresolved tradeoff that prevents selecting one;
- who owns intent, facts, and route adoption, and whether route change is permitted;
- the revision anchor, when completing, revising, or rewriting;
- the unknowns that could change the judgment.

## Stage 2: Establish the Evidence-Backed Task Model

### Purpose

Establish the smallest task-specific representation of the system and design problem that can govern target-design formation.

### Work

Start from a concrete use: who needs what result, which choices they must make, and what currently prevents or complicates it. Trace a representative scenario and locate the owners of its facts, decisions, state, effects, and recovery. Use existing modules and capability catalogs to test this model, not to define the target decomposition. Investigate only facts that can change a responsibility, viable direction, quality tradeoff, acceptance, or major risk; stop expanding the inventory when it supports the next choice. Dependencies and call order show collaboration, not ownership.

For material information and handoffs, establish why the system depends on them, which source determines their meaning, what the receiver can observe, how validity and conflicts are handled, and what follows partial or indeterminate completion. Treat proposed changes to externally owned contracts as route-changing conditions. Establish the current contract, semantic owner, actual consumers, authority to request a change, and owner acceptance. Until acceptance, keep contract-dependent conclusions conditional and separately test the unchanged contract and the smallest system-owned mapping.

Form a provisional task model from evidence and authority rather than generic architecture slogans or invented terminology. It should contain only what can change the design:

- the observable result and the obligation behind it;
- non-negotiable obligations, each with the authority or active contract that establishes it;
- which of the current system's complexity the problem's own obligations require and therefore constrains the target steady state; which a past choice left behind that still carries an active consumer, contract, data, or transition cost and therefore constrains transition, adoption, or exit but not necessarily the target steady state; and which carries none of these and is current state to challenge, not a constraint;
- relevant facts, decisions, state, effects, authorities, and consumers;
- causal relationships and structural tensions shaping the solution space;
- domain concepts and distinctions that determine behavior, what changes together, and what must be able to change independently;
- hard constraints, preserved behavior, and active commitments;
- evidence and scenarios supporting the quality priorities and criteria that distinguish directions;
- assumptions, unknowns, evidence boundaries, and facts that would invalidate the model;
- a credible alternative problem representation when one could change the route.

Treat theories, analogies, patterns, and model-generated abstractions as hypotheses. Retain one only when a concrete obligation, condition, causal relationship, or failure explains why it applies and what would invalidate it. Greenfield work needs no invented current defect; its task model can start from the required responsibility, information, interaction, operating, and evolution model. The task model is a reasoning aid, not a required artifact or document section.

Let problem understanding and candidate exploration inform each other. A candidate may reveal a missing distinction, constraint, or better causal representation before the previous model is disproved. Update the affected model and dependent comparisons; do not silently change established intent, quality priorities, or authority to accommodate a favored route.

### Exit

Proceed when:

- every relevant current-system claim is bounded by its evidence;
- non-negotiable obligations are stated with their source, and current complexity is separated into what constrains the target steady state, what constrains only transition or exit, and what is only current state;
- the design problem and its causal model are explicit;
- the conditions that would change direction are visible;
- discoverable facts needed for the next judgment have been recovered within scope; remaining unknowns have explicit effects and sources (the **unknown rule**): proceed on independently supported parts or bounded conditional alternatives, but suspend a choice whose dependence cannot be isolated. Naming an owner does not resolve the unknown;
- the model is sufficient for the next candidate comparison; no unresolved fact or decision is silently treated as settled.

## Stage 3: Explore, Deepen, and Form the Target Design

### Purpose

Use breadth and depth together: discover genuinely different system directions, deepen only viable ones, and form a complete target design with defensible quality and lifecycle tradeoffs.

### Work

Resolve the choices that determine many downstream details before expanding catalogs, field schemas, or parallel documents: which capabilities produce the result, who makes each consequential decision, what information is authoritative, and what consumers must know. Explore these choices with sketches and focused probes as needed; this is a reasoning dependency, not a requirement to finish every design detail before making progress.

Derive viable directions from the task model, including the strongest direct or maintained route. Consider reuse, deletion, or moving responsibility when it could remove the cause of the problem. Restructuring is an ordinary candidate when current boundaries cannot close the result. If an alternative problem representation is material, derive a direction from it. Compare genuinely different routes, without a fixed count or invented variants.

Eliminate directions that violate required results, preserved behavior, hard constraints, authority, or viable responsibility and state semantics. Compare the rest on established quality priorities, failure behavior, reversibility, risk, evidence, and lifecycle cost. Give alternatives the same authorized latitude to change contracts; do not grant the preferred route new machinery while judging the simpler route only against its unchanged implementation. Unknowns that can change this comparison remain route-selection conditions, not merely rollout prerequisites. Revisit a changed premise at its source rather than bending criteria toward a route.

Shape abstractions around stable responsibilities and independently varying decisions. A boundary may own a domain, protocol, or platform responsibility; a business name alone proves nothing. Each layer must provide a meaningful capability or isolation, not merely forwarding or renaming. Distinguish reusable behavior, consumer-specific choices, and internal representation or deployment details. Expose configuration only where its consumer needs to make a meaningful choice; keep derivable identifiers and intermediate state with their system owner unless an active contract requires exposure. When a concept is confusing, test whether to remove, merge, or relocate it before adding an alias or explanation. Preserve required distinctions even when their names look similar.

Before claiming reuse or simplicity, test the abstraction with a materially different supported use or credible change: what can vary without a new implementation, and what legitimately remains domain-specific? For a proposed layer, determine what required capability or quality would be lost if it were removed. Simplicity never removes complexity required by an established obligation or evidenced failure. Use only comparisons that can change the choice; do not require extra examples or experiments for settled, immaterial details.

For each consequential choice with a real alternative, keep a compact **selection proof**: the selected direction, the requirements and quality priorities it serves, the strongest viable alternative, why the selection is preferable, its costs and who bears them, the evidence boundary, and the condition for reconsideration. When selecting a more complex route, explain why its material benefit warrants the extra lifecycle cost. If the simpler route wins, do not invent a deficiency in it. Facts, inevitable consequences, and interchangeable implementations need no decision record. Keep choices conditional while missing evidence or authority can still change them.

Now form the selected route's operating model: how it is initiated, who collaborates, which facts and authorized decisions it rests on, what state it must hold, what effects it produces, where it hands off, what result it makes observable, and who takes over on failure. Decide which affected responsibilities and paths remain, move, merge, or disappear. Where one boundary legitimately owns responsibility, change, authority, and knowledge together, prefer it, so that one change touches one place and the party that decides is the party that knows; otherwise keep the distinct owners and make the authoritative handoff between them explicit.

For every material contract or handoff your route creates, replaces, or reinterprets, design only the guarantees the result depends on, and state the **handoff guarantee**: what the sender promises, where the receiver accepts or validates, and what the consumer sees on an applicable violation. Where identity, mutation, concurrency or idempotency, dependency, validation, authorization, or result semantics are already established, either preserve them or supersede them explicitly. Design handling for absent, malformed, stale, conflicting, or unauthorized input where that condition can prevent or corrupt an established result, and nowhere else. When you reach for validation or a defensive path, first find the owner's contract; if it already closes the case, add nothing.

Before adding a mechanism, establish the required result, important quality goal, actual consumer, evidenced failure, or active evolution need it serves. For necessary durable business state or committed effects, close the applicable lifecycle: ownership or arbitration, writes and reads, validity, transitions, conflicts, failure detection and takeover, observation, and retirement. Include indirection, synchronization, operation, transition, and exit in the selection proof. A simpler route satisfying basic functionality does not alone defeat an evidenced quality benefit; speculative usefulness cannot justify machinery.

Treat a mechanism as **independently design-significant** only when it materially serves an established outcome or quality goal and has a clear input, result, responsibility, and operating boundary. Being a separate service, module, or table, or having many consumers, does not establish significance.

### Exit

Proceed when:

- every invalid direction is eliminated with the obligation or constraint it violates;
- the selected or conditional route can be argued end to end: result, abstractions and responsibilities, quality tradeoffs, material information and state, failure semantics, lifecycle implications, and evidence limits;
- each consequential choice with a real alternative has its selection proof;
- each material handoff has its handoff guarantee—sender contract, receiver validation boundary, and consumer-visible result of an applicable violation—each with an owner;
- each applicable established semantic—identity, mutation, concurrency or idempotency, dependency, validation, authorization, result—is preserved or explicitly superseded;
- the independently design-significant mechanisms are identified.

## Stage 4: Argue, Challenge, and Converge the Design

### Purpose

Determine whether the task model and target design remain valid under evidence, counterexamples, and viable alternatives; then keep, revise, condition, or suspend the judgment without uncontrolled redesign.

### Work

Here you try to be wrong—about the problem as you framed it and about the design you formed—and you decide, firmly where evidence allows and conditionally only where a named unknown remains.

#### Challenge

Before accepting a design for satisfying the task model, challenge the model itself. Check anchoring on current implementation, a proposed means, an imported theory, or your preferred route without discarding explicit constraints. Ask which facts are assumptions, which criteria fail to distinguish outcomes, and whether another causal explanation or representation fits better. Return affected premises to Stage 2 and reconsider their dependent criteria, directions, mechanisms, and conclusions; preserve independently supported judgments.

Build a **design argument** for the overall route and for each independently design-significant mechanism or consequential choice. Follow one chain:

`claim -> established result, obligation, or quality goal -> governing basis -> causal responsibilities and mechanism -> observable result or benefit -> credible invalidator -> evidence boundary and remaining condition -> judgment`

Reuse the Stage 3 selection proofs; the argument is reasoning, not a required report template. Judge whether the parts together produce the scoped result, including handoffs to the surrounding system. A locally sound mechanism does not establish the whole-system outcome.

Pick the few end-to-end scenarios and changes most likely to disprove a material claim, and run the design through them. Name what in the design bears load—what must hold under the changes and failures you consider most likely—and what is negotiable. Trace facts, decisions, state, handoffs, effects, and consumer-visible results through the success path, and through only those failure, concurrency, re-entry, transition, rollback, or change-propagation paths that could change your conclusion. If a category has nothing in it, leave it empty; inventing an obligation or a mechanism to fill it is a design error.

Check the whole against its parts and the actual parties' perspectives: does a local improvement shift unacceptable work, delay, or failure elsewhere? For a sensitive choice, vary the decisive assumption within an evidence-supported range and ask whether the preferred route changes. Seek the smallest available evidence or analysis that can settle that difference; distinguish estimates from established guarantees. State which changes the boundaries support and which would require reconsideration, without promising an uncommitted future architecture.

Try to break the Stage 3 mappings from outcomes and quality goals to owners and mechanisms, and from mechanisms to their basis. Remove a new mechanism in the argument: identify which established result or material quality benefit is lost, for whom, and whether retaining it is worth its full cost. Before removing an existing mechanism, identify active obligations, contracts, consumers, or quality goals it still serves; invent no historical justification. A crash window alone establishes no recovery obligation. A mechanism without a basis or an applicable state lifecycle goes back to Stage 3; do not finish its design here.

Hit each Stage 3 handoff guarantee with the most consequential applicable violation—one the owner's contract does not already close. A guarantee you find missing or unowned goes back to Stage 3. When completing, revising, or rewriting, classify each guarantee the revision anchor still holds active as preserved, intentionally changed with authority, corrected by evidence, or no longer applicable for a reason you state.

#### Converge

Revise when evidence, a credible counterexample, or a logical gap changes the judgment; a better-supported problem representation changes the solution space; a valid route offers a material improvement on established quality priorities and total cost; or the responsible authority changes intent, constraints, or route. Mere challenge, novelty, or a renamed abstraction is not a reason to change a valid design. A better route does not grant authority to replace an adopted one. The legitimate outcomes are **keep**, **revise**, **condition**, and **suspend**.

Return each failure to the stage that owns that kind of judgment; reopen only dependent conclusions and remove their superseded state, recovery, compatibility, migration, and evolution as one semantic chain. An expression-only gap belongs to Stage 5.

Keep supported judgments; send revisions to their owning stage; condition only the conclusions that depend on named unresolved facts or decisions. Suspend a blocked choice or invalid route when no authorized supported selection can be made. Stop extending that part and establish its conflict, affected scope, viable options if known, and smallest required fact or authority decision. Suspension need not satisfy the complete-design exits: hand off this bounded result without inventing a target or erasing still-valid design content.

For completion, revision, or rewrite, classify the converged design against the revision anchor. Stage 4 is the sole owner of this classification:

- An **intent change** alters the required result, scope, constraint, allowed degradation, or acceptance.
- An **evidence correction** changes what can be claimed about current behavior without changing the design.
- A **route change** replaces an adopted design direction or another authority-owned choice.
- A **within-route design revision** materially changes the operating model, an independently significant mechanism, a responsibility boundary, or a consequential choice while preserving the adopted intent and route.

Evidence gathering, feedback rounds, wording, structure, and formatting are not design revisions when the design is unchanged. A review event is neither required nor sufficient for a revision. Use a working change plan only when several interdependent changes or omission risks require one; it tracks what must be preserved, corrected, changed, or removed and the direct dependent surfaces.

Set design status only for the proposed design. `Drafting` means the route or key mechanisms remain unformed. `Pending Confirmation` means a complete new route has not been adopted, or a revision changes the adopted route or adds an unadopted authority-owned choice. `Confirmed` requires direct adoption by the actual authority or explicit delegated selection within fixed bounds. Record unresolved external facts, contract conditions, implementation, deployment, and external validation separately; a confirmed conditional design is not an implemented or validated system.

### Exit

For a complete or conditional design, converge when:

- the task model has survived the identified relevant counterexamples;
- the route and each significant mechanism has an evidence-bounded design argument;
- the selection is defensible against identified viable alternatives on established priorities and costs, with decisive uncertainty explicit;
- the Stage 2 unknown rule holds for the converged design;
- for completion, revision, or rewrite, the revision classification is decided;
- design status is set.

For suspension, finish the judgment when the blocker, affected boundary, preserved conclusions, and next required fact or decision are clear. Keep design adoption status separate from this blocked activity; a previously adopted route may now be invalid under current evidence.

## Stage 5: Draft and Reconcile the Artifact

### Purpose

Express the supported design or bounded unresolved result without allowing document structure to create or change design semantics.

### Work

Enter when the applicable complete, conditional, or suspension exit holds. Read `references/overview-standard.md` in full. Express the operating model, abstractions and responsibilities, material quality tradeoffs, and significant mechanisms at the requested whole-system or local scope. For suspension, express the bounded conflict and needed decision instead of manufacturing a complete target. Keep choices and supported change boundaries with their owning design; include transition, acceptance, status, and a revision record only when material. Omit investigation steps, method commentary, review ceremony, and abandoned routes except where an alternative still explains a live tradeoff or unresolved choice.

Propagate settled decisions to the authorized dependent artifacts, using the owning design as their shared basis rather than reforming the decision in each document. For revision, compare the result with the revision anchor and still-material existing content; check each affected complete example and flow for preserved behavior, not only syntax and references. Confirm that semantic changes are expressed, responsibilities have owners, and restructuring did not drop a valid effect, handoff, failure response, compatibility obligation, or acceptance condition. Return semantic gaps to their owning stage.

### Exit

Finish only after reading the actual final artifact and checking it against the applicable Drafting Checks in `references/overview-standard.md`. Correct expression gaps in Stage 5 and return semantic gaps to their owning stage. This applies to creation, completion, revision, and rewrite; a summary or verification of another deliverable does not establish that the design artifact is ready. Finish when the artifact:

- states one coherent complete or conditional target design, or the bounded unresolved result of a suspension;
- keeps claims within their evidence and authority;
- distinguishes adoption from implementation and validation;
- lets a reader recover the scoped result, abstractions and responsibilities, significant mechanisms, quality tradeoffs, conditions, and relevant acceptance or next decision;
- gives each applicable party—consumer, operator, the engineer who changes it next—what they need to act.
