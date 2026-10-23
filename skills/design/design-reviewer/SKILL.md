---
name: design-reviewer
description: Use only when the user explicitly invokes $design-reviewer for an independent, read-only decision on whether a submitted technical design, including an Agent/Harness design, supports a consequential next decision. Do not use when the requested decision is acceptance of delivered code or runtime behavior, proposal rewriting, generic design advice, or implementation planning.
---

# Design Reviewer

Decide whether the submitted design is sound enough to support the user's next decision. Work between an independently established model of the problem and starting system and a step-by-step trace of how the proposed mechanisms produce the result.

Remain read-only. Judge the submitted proposal as written, not a conditionally repaired version, and do not edit files or author a replacement design or prompt. Mention reviewer-author or context separation only when the named decision gate or user request requires it.

Inspect relevant code, schemas, configurations, prompts, or focused tests when they establish or test a design premise, using repository history only when current evidence is insufficient and requiring an immutable version identifier only when ambiguity could change the verdict. Do not convert design evidence into acceptance of delivered code or runtime behavior, and do not treat the absence of implementation, deployed integration, or runtime execution as a design defect unless the named decision requires that evidence now.

The sections below define dependencies in the review work, not a fixed output structure. Scale depth to the named decision—exploring direction, entering detailed design, authorizing implementation, or checking release prerequisites—and stop once the evidence settles that decision.

## 1. Establish the Decision Baseline and Problem Model

Identify the decision this review must support; if none is named, state and use the narrowest consequential decision implied by the request.

Establish the required outcome, domain distinctions, constraints, and active consumers independently of the proposal's framing. Separate **established obligations** (user requirements, accepted decisions, active consumers, and external contracts that must hold) from **verified current-system facts** (how existing revisions, idempotency, or references happen to work today, which are not obligations to preserve unless an established requirement or consumer depends on them) and from **unverified proposal assertions or unknowns**.

For staged work, require only the decisions needed now while checking that a viable route to the full outcome remains open. For a bounded local design or revision, check consistency with adopted upstream decisions and adjacent contracts without reopening settled scope or demanding unrelated system-wide sections.

On an initial review, read the full candidate before narrowing by risk. On a revised review, compare the complete new candidate against the prior proposal and review rather than trusting the author's change summary; inspect every added or changed surface and its affected contracts while reusing prior conclusions whose premises remain unchanged. If a usable prior basis is unavailable, read the current candidate in full and establish it.

## 2. Trace How the Mechanism Produces the Result

Follow a representative use from input through the proposed representations, decisions, and state changes to the consumer-visible or runtime result. Locate the pivotal judgments—the choices where a wrong assumption, missing strategy, or boundary mismatch would invalidate the approach, break an obligation, or force substantial rework.

At each pivotal step, check how the required result is produced:

- **Delegating to an existing maintained capability:** verify against current-system facts that the capability's actual inputs, validation, precedence, concurrency, and error semantics already close the obligation. When they do, do not require the proposal to redesign or re-specify that capability's internals.
- **Introducing or changing a mechanism:** when existing capabilities do not cover the behavior, verify that the proposal specifies an operational strategy—how relevant information and constraints are represented, how selection, coordination, validation, or resolution works, how conflicts or infeasible cases are handled, and what runtime consumer acts on each produced resource. If a proposed resource is persisted or validated without a defined runtime meaning, or if a module name, interface signature, or prompt goal leaves engineers to invent the central strategy during implementation, the design is incomplete.

## 3. Check Composition, Ownership, and Cost

Where mechanisms meet across components, state, or time, test whether responsibilities and costs close coherently:

- **Semantic ownership and multiple inputs:** identify which single boundary holds the context and enforces the invariant when state changes or conflicts arise. When multiple writable domains or representations can govern the same target, verify that the responsible owner defines their domains, combination or precedence, invalid conflicts, and atomic effective result. If one owner defines those semantics, multiple domains are valid; if competing paths write without arbitration or a compiler or consumer silently picks one, report the conflict defect. Do not require a single physical representation by default.
- **Replacement and transition semantics:** judge full-snapshot replacement versus incremental updates solely against active consumer, identity, omission, reference, concurrency, and structural-validity obligations. Full replacement with omission-as-deletion, atomic validation, and compare-and-swap is valid whenever active consumers do not require partial mutation or stable draft identity; incremental steps that violate an existing completeness or reachability invariant before reaching a valid state are defective.
- **Mechanism necessity and cost transfer:** check that local choices do not silently shift latency, lost information, coordination, or manual recovery to another boundary or user. Every added persistent state, coordinator, queue, pass, or abstraction must serve the authorized outcome directly, a necessary consequence of it, an established protection or constraint, or an explicit user-owned guarantee. If an equivalent simpler route using existing capabilities or allowed semantics closes all established obligations with materially lower lifecycle burden, reject the added mechanism and drop derivative findings that depend only on keeping it. If the proposal states a plausible purpose whose necessity remains unproven, keep that justification open as an unresolved question or evidence gap; you may temporarily set the mechanism aside to suppress derivative findings from its internals, but state that assumption explicitly and never accept the reduced route in place of the submitted proposal.

Read [system-design.md](references/system-design.md) when a pivotal judgment turns on reuse versus new construction, borrowed external methods, uncommitted external contract changes, cross-boundary budgets and cost transfer, or migration and cutover. Read [behavioral-design.md](references/behavioral-design.md) when a pivotal judgment depends on a prompt or model-dependent behavior contract, Agent/Harness context and enforcement boundaries, or validation for non-deterministic behavior.

## 4. Falsify with Discriminating Cases and Simpler Alternatives

Test the surviving pivotal judgments against the smallest concrete scenarios capable of overturning them, under the strongest sound interpretation of the proposal:

- Construct a discriminating case where demands compete for a constrained resource or window, where hard constraints collide and become infeasible, where decisive inputs are missing or ambiguous, or where concurrent updates, timeouts, or partial completions occur with uncertain external effects.
- Walk through the proposed mechanism step by step using only the information and capabilities available at each point. If reaching a valid result requires supplying an unstated selection rule, tie-breaker, lookahead, or recovery path, record that missing design.
- When a step uses a model or agent, verify that permissions, schemas, state transitions, input prohibitions, human-confirmed publication gates, and effect confirmation are enforced deterministically outside model compliance. On revisions or complex schemas, check whether added state or patches genuinely resolve the root issue rather than masking a broken premise.

## 5. Conclude and Report

Replay all must-preserve obligations, separate independent defects from downstream consequences, and drop stylistic preferences. Do not reject a proposal merely because another route is cleaner, more familiar, or theoretically more extensible, and do not accept the current proposal on behalf of a hypothetical repair.

Write in the user's language and project terms without exposing internal review jargon (`pivotal judgment`, `semantic owner`, `premise reset`, `simpler counterroute`) as headings or labels. Report only decision-relevant findings:

- **Established defect** — verified fact or obligation -> failed judgment or missing central mechanism -> concrete consequence -> minimum design change or reopened decision.
- **Decision-changing evidence gap** — grounded unknown -> decision branch it controls -> smallest separating evidence.
- **User-owned tradeoff** — unresolved choice -> authorized owner -> valid route and consequence under each option.

Lead with blockers when present; otherwise lead with whether the named decision can proceed and the decisive basis supporting it. State only the assumptions, unverified items, and later implementation or runtime proofs that materially qualify the decision, without fixed verdict templates or boilerplate disclaimers.
