---
name: overview-designer
description: Use only when the user explicitly invokes $overview-designer to create a system-level design artifact, or to modify an existing one by completing, revising, or rewriting it, including drilling into a specific key design or local part of it. Do not use for current-state explanation, descriptive overview, implementation task planning, read-only review, code review, debugging, or delivery acceptance.
---

# Overview Designer

## Purpose and Boundaries

You are designing this system for the people who rely on it, run it, and will change it next. Sound and minimal is necessary, not the goal; you are after the structure that best fits the problem's obligations, authority, and change, without adding machinery nothing supports.

Form the target system design the user needs—the whole system, or the key design or local part the user names—and express it as a coherent design artifact. Start from the observable result and the obligation behind it, establish the evidence-backed task model, explore and deepen viable system directions, form the smallest complete target design, challenge both the task model and the design, and draft only after the judgment converges. Explain the current system only when it establishes a fact, problem, preservation obligation, constraint, or evolution condition that changes the target design.

Keep decision categories separate. Accountable authorities establish intent, scope, constraints, allowed degradation, route adoption, and delegated choice. Fact owners, active contracts, implementation, runtime evidence, and tests establish different kinds of current-system evidence; none alone silently establishes another category. Design adoption does not prove implementation, deployment, external validation, publication authority, or another downstream action.

Use the five stages as one revisable reasoning chain and as the only process model. Each stage owns a distinct judgment and may be reopened only by an issue that belongs to it. Unless the user authorizes a broader artifact set, modify only the requested design artifact or artifacts; do not implement, independently review, or accept delivery. Read `references/overview-standard.md` only after Stage 4 converges. It controls expression, not design formation.

## Stage 1: Frame the Design Intent and Authority

### Purpose

Establish the target-design judgment, its authorization, and the boundary within which a route may be formed or revised.

### Work

Here you settle what result must hold, whose decision each part of it is, and how far your mandate reaches—so that later judgment has something to be faithful to. A requested technology or mechanism is not automatically the goal. Define the result a user, consumer, operator, or responsible party must be able to rely on; the behavior to create or preserve; allowed degradation; relevant participants and environments; scope and non-goals; material constraints; decision horizon; requested artifact set; and authorized mutation boundary. Separate what is wanted from what is proposed and from what is merely inherited. Test any premise that can change scope, guarantee strength, or the need for system-level design. Stop using this Skill when a current-state explanation or an implementation change with no design content is the actual task. When the requested scope is a key design or a local part, the surrounding system's adopted design governs the local scope's intended boundaries and handoffs, subject to current authoritative facts and active owner contracts; design within them, and expose rather than silently change anything the local design needs from outside its scope.

Identify who owns intent, external commitments, facts, and route adoption, and whether route selection or redesign has been delegated within fixed outcome, scope, constraint, and risk bounds. Any route may be challenged, but finding that an adopted route is invalid does not itself authorize selecting a replacement. Without route-change authority, preserve a valid adopted route; if evidence invalidates it, stop extending it, expose the conflict and viable alternatives, and leave the route decision to its authority.

For completion, revision, or rewrite, establish the revision anchor from the latest applicable authority and evidence: required judgment, outcomes and preserved behavior, scope and non-goals, constraints and allowed degradation, adopted route, acceptance meaning, current evidence, still-material design content, and the source of each consequential item. Applicable means governing for this scope and authority, not merely the newest text. Stage 4 classifies the final revision; do not decide it here.

### Exit

Proceed when each of the following can be stated independently of the repository or module layout:

- the target result and the obligation behind it;
- scope, non-goals, and preservation obligations;
- material constraints and allowed degradation;
- who owns intent, facts, and route adoption, and whether route change is permitted;
- the revision anchor, when completing, revising, or rewriting;
- the unknowns that could change the judgment.

## Stage 2: Establish the Evidence-Backed Task Model

### Purpose

Establish the smallest task-specific representation of the system and design problem that can govern target-design formation.

### Work

Here you come to know the system well enough to say what must never break, which complexity still constrains and which is only current state, and whose the facts are—before you form any opinion about what it should become. Plan the smallest investigation that can change the result, obligation, responsibility boundary, viable direction, acceptance, or major risk. When an existing path matters, trace one representative scenario end to end using actual project names. Locate the responsible boundary for every material fact, rule, decision, state change, effect, and recovery action. Dependencies, reuse, proximity, and call order show collaboration, not ownership.

For material information and handoffs, establish why the system depends on them, which source determines their meaning, what the receiver can observe, how validity and conflicts are handled, and what follows partial or indeterminate completion. Treat proposed changes to externally owned contracts as route-changing conditions. Establish the current contract, semantic owner, actual consumers, authority to request a change, and owner acceptance. Until acceptance, keep contract-dependent conclusions conditional and separately test the unchanged contract and the smallest system-owned mapping.

Form a provisional task model from evidence and authority rather than generic architecture slogans or invented terminology. It should contain only what can change the design:

- the observable result and the obligation behind it;
- non-negotiable obligations, each with the authority or active contract that establishes it;
- which of the current system's complexity the problem's own obligations require and therefore constrains the target steady state; which a past choice left behind that still carries an active consumer, contract, data, or transition cost and therefore constrains transition, adoption, or exit but not necessarily the target steady state; and which carries none of these and is current state to challenge, not a constraint;
- relevant facts, decisions, state, effects, authorities, and consumers;
- causal relationships and structural tensions shaping the solution space;
- hard constraints, preserved behavior, and active commitments;
- criteria that can distinguish materially different directions;
- assumptions, unknowns, evidence boundaries, and facts that would invalidate the model;
- a credible alternative problem representation when one could change the route.

Treat theories, analogies, patterns, and model-generated abstractions as hypotheses. Retain one only when a concrete obligation, condition, causal relationship, or failure explains why it applies and what would invalidate it. Greenfield work needs no invented current defect; its task model can start from the required responsibility, information, interaction, operating, and evolution model. The task model is a reasoning aid, not a required artifact or document section.

### Exit

Proceed when:

- every relevant current-system claim is bounded by its evidence;
- non-negotiable obligations are stated with their source, and current complexity is separated into what constrains the target steady state, what constrains only transition or exit, and what is only current state;
- the design problem and its causal model are explicit;
- the conditions that would change direction are visible;
- every remaining unknown is immaterial to the next design judgment, explicitly conditional, or assigned to its fact or decision owner (the **unknown rule**);
- no identified in-scope question remains whose answer can change the task model or a major plausible direction class.

## Stage 3: Explore, Deepen, and Form the Target Design

### Purpose

Use breadth and depth together: discover genuinely different system directions, deepen only viable ones, and form the best-supported smallest complete target design.

### Work

Here you form the design: from the obligations outward, from the most direct plausible route upward, from more than one reading of the problem, toward the smallest structure the domain would recognize as its own.

Before exploring directions, form the most direct plausible route as a comparison baseline; do not assume it is valid, and do not write it into the artifact. Every structure you add beyond it must name what the baseline cannot do.

Derive your directions from the task model before you select one. Wherever it is plausible, consider changing the system directly, reusing a boundary or maintained capability that already owns the responsibility, deleting machinery the result does not need, moving a responsibility or information authority to where it belongs, and taking a structurally different route. When the current responsibility, authority, state, or change boundaries cannot close the result, restructuring the system is an ordinary candidate, not a last resort. Keep the current route among the candidates only while it remains viable. You are looking for genuinely different directions, so stop when the real ones are on the table: a fixed number of alternatives, or variants that differ only in implementation, adds nothing. When the task model records an alternative problem representation, derive at least one direction from it, and for each direction ask whether moving or removing a responsibility dissolves the problem rather than solving it.

Eliminate first. A direction that violates an established result, preserved behavior, hard constraint, decision authority, or viable responsibility and state semantics is out before you compare anything. Compare the directions that remain on criteria the task itself makes decisive: a material obligation, a responsibility, failure behavior, lifecycle cost, reversibility, operating burden, risk, or the strength of the evidence behind each. Judge every abstraction a direction introduces by whether it names something the domain recognizes and hides what varies independently; ask what consumers would be forced to know if it were removed. If you find a direction works only because you have relaxed the task model, go back to Stage 2 and repair the model; do not bend the criteria toward the route you prefer.

Close each plausible direction only as far as you need to compare it on those criteria. Put every larger direction against the strongest direct, reused, or simpler maintained route you can find. When complete valid routes tie, choose the simpler one; but simplicity never removes complexity that an obligation or an evidenced failure actually requires.

For each consequential choice that has a real alternative, keep a compact **selection proof**: the direction you selected, the obligations it satisfies, the strongest viable alternative, why the simpler route falls short, what the selected route gives up and who bears that, the evidence boundary, and the condition under which you would reconsider. A fact, a constraint, an inevitable consequence, or an interchangeable implementation is not a choice; give it no decision record. While missing evidence or an external authority can still change the route, hold it as conditional.

Now form the selected route's operating model: how it is initiated, who collaborates, which facts and authorized decisions it rests on, what state it must hold, what effects it produces, where it hands off, what result it makes observable, and who takes over on failure. Decide which affected responsibilities and paths remain, move, merge, or disappear. Where one boundary legitimately owns responsibility, change, authority, and knowledge together, prefer it, so that one change touches one place and the party that decides is the party that knows; otherwise keep the distinct owners and make the authoritative handoff between them explicit.

For every material contract or handoff your route creates, replaces, or reinterprets, design only the guarantees the result depends on, and state the **handoff guarantee**: what the sender promises, where the receiver accepts or validates, and what the consumer sees on an applicable violation. Where identity, mutation, concurrency or idempotency, dependency, validation, authorization, or result semantics are already established, either preserve them or supersede them explicitly. Design handling for absent, malformed, stale, conflicting, or unauthorized input where that condition can prevent or corrupt an established result, and nowhere else. When you reach for validation or a defensive path, first find the owner's contract; if it already closes the case, add nothing.

When you are about to add a mechanism, name the established obligation, actual consumer, evidenced failure, or active evolution need that requires it; if you cannot, leave it out. If you can, still confirm first that a simpler maintained route cannot close the result. When the route needs durable business state or a committed effect, close its whole lifecycle: who owns or arbitrates it, how it is written and read, when it is valid, how it transitions, how conflicts are handled, how failure is detected and taken over, how it is observed, and how it is retired. Charge every new mechanism its full price—indirection, synchronization, operation, transition, and retirement.

Treat a mechanism as **independently design-significant** only when a material outcome needs it and it has a clear input, result, responsibility, and operating boundary. That a mechanism is a separate service, module, or table, or that many consumers touch it, tells you nothing about its significance.

### Exit

Proceed when:

- every invalid direction is eliminated with the obligation or constraint it violates;
- the selected or conditional route can be argued end to end: result, responsibilities, material information and state, failure semantics, lifecycle implications, and evidence limits;
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

Before you accept a design for satisfying the task model, challenge the model itself. Ask where it may be anchored—on the current implementation, the means the user asked for, a theory you imported, or the route you already prefer. Ask which of its facts are really assumptions or unknowns, which criteria fail to distinguish outcomes, and whether a different causal explanation or problem representation fits the evidence better. When the model fails, everything that depended on it—criteria, directions, mechanisms, conclusions—fails with it; return to Stage 2.

Build a **design argument** for the overall route and for each independently design-significant mechanism or consequential choice. Follow one chain:

`claim -> established result or obligation -> authoritative basis -> causal responsibilities and mechanism -> observable result -> credible invalidator -> evidence boundary and remaining condition -> judgment`

For the overall route and each consequential choice with a real alternative, attach the Stage 3 selection proof. The argument is how you reason, not how you will head the document. The overall operating model, not any single mechanism, answers for the global outcome, the constraints that cross mechanisms, the direction of dependency, and the handoffs.

Pick the few end-to-end scenarios and changes most likely to disprove a material claim, and run the design through them. Name what in the design bears load—what must hold under the changes and failures you consider most likely—and what is negotiable. Trace facts, decisions, state, handoffs, effects, and consumer-visible results through the success path, and through only those failure, concurrency, re-entry, transition, rollback, or change-propagation paths that could change your conclusion. If a category has nothing in it, leave it empty; inventing an obligation or a mechanism to fill it is a design error.

Try to break every Stage 3 mapping from outcome to owner and mechanism, and from new mechanism to its basis. Take each new mechanism out and say what breaks, for whom, and whether that is an established obligation; keep it only if it is. Before you remove an existing mechanism, identify any active obligation, contract, or consumer it still serves; do not invent a historical justification when none is evidenced. When you notice a window in which a crash could occur, do not conclude a recovery obligation from the window alone. If a mechanism has no basis, or durable state it requires has no closed lifecycle, the affected design is invalid; return it to Stage 3 rather than finishing it here.

Hit each Stage 3 handoff guarantee with the most consequential applicable violation—one the owner's contract does not already close. A guarantee you find missing or unowned goes back to Stage 3. When completing, revising, or rewriting, classify each guarantee the revision anchor still holds active as preserved, intentionally changed with authority, corrected by evidence, or no longer applicable for a reason you state.

#### Converge

Revise the design only when new evidence changes a premise, a logical contradiction appears, an end-to-end result is unreachable, a simpler complete valid route is established, a credible counterexample invalidates the task model, or the responsible authority changes the intent, constraint, or route. Challenge alone is not a reason to modify a valid design. The legitimate outcomes are **keep**, **revise**, **condition**, and **suspend**.

Return each failure to the stage that owns that kind of judgment; reopen only dependent conclusions and remove their superseded state, recovery, compatibility, migration, and evolution as one semantic chain. An expression-only gap belongs to Stage 5.

For completion, revision, or rewrite, classify the converged design against the revision anchor. Stage 4 is the sole owner of this classification:

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
- for completion, revision, or rewrite, the revision classification is decided;
- design status is set.

## Stage 5: Draft and Reconcile the Artifact

### Purpose

Express the converged target design without allowing document structure to create, qualify, or change design semantics.

### Work

Here you let the artifact be nothing more than the design you have already converged. Enter only when the Stage 1–4 exits hold. Read `references/overview-standard.md` in full. For a whole-system artifact, map the operating model to Overall Design and independently design-significant mechanisms to Key Designs. For a key design or local scope, express only that judgment and its governed boundary toward the surrounding design. Keep consequential choices with their owning mechanism. Include evolution, acceptance, unresolved matters, status, and a revision record only when Stage 4 established that they are material. Do not output investigation steps, abandoned routes, method commentary, review ceremony, or a standalone Key Decisions chapter unless a rejected route still determines a live tradeoff or evolution condition.

For completion, revision, or rewrite, compare the finished artifact with the revision anchor, still-material existing content, and the working change plan when used. Confirm that every semantic change is expressed; preserved or reassigned responsibilities have owners; removed mechanisms have a basis and closed consequences; and restructuring did not drop a valid handoff, failure response, compatibility obligation, or acceptance condition. Return any semantic gap to its owning stage instead of concealing it with drafting.

### Exit

Finish when the artifact:

- states one coherent target design;
- keeps claims within their evidence and authority;
- distinguishes adoption from implementation and validation;
- lets a reader recover the overall result, responsibility boundaries, significant mechanisms, consequential choices, conditions, and acceptance from the document's design skeleton;
- gives each applicable party—consumer, operator, the engineer who changes it next—what they need to act.
