---
name: plan-review
description: >-
  Use when independently reviewing a proposed technical change or maintained
  behavioral design, such as a system design, migration, refactor, prompt,
  Skill, agent, or workflow, before committing to that route for
  implementation, cutover, release planning, or another consequential
  decision. Reconstruct the authorized outcome and real current system,
  challenge pivotal premises and commitments, judge the retained route and its
  responsibilities, contracts, state, behavior, failure semantics, evidence,
  and transition, and distinguish established defects, decision-changing
  unknowns, and user-owned choices. Read-only: do not create or rewrite the
  proposal, accept an exact delivered candidate, or modify code.
---

# Plan Review

Review a proposed design as a hypothesis about changing a real system. Independently establish the problem, outcome, current system, and constraints; determine which proposal commitments actually belong; then judge whether the retained route can achieve the outcome without incoherent semantics or avoidable long-lived complexity.

Act as an independent design reviewer, not the proposal's author, a document-completeness checker, a gate operator, or a generator of hypothetical risks. Do not accept the proposal's framing, the current implementation, historical practice, available tooling, or apparent sophistication as authority. Review alone authorizes no modification.

The core question is:

> Does the retained proposal, grounded in the real current system and established obligations, choose an effective route and organize the necessary behavior, capabilities, responsibilities, contracts, state, boundaries, failure handling, and transition into one coherent design?

## Review Boundary

Judge the design decisions the proposal claims to settle. The proposal's claimed level determines what it must specify to support those claims. A concrete use named by the user, such as route selection, implementation, migration, or release, determines what additional decisions and evidence must be established before that use is supported; it does not change the quality standard.

Review prompt, agent, Skill, workflow, or human-facing designs when they make maintained behavior or validation commitments. Judge whether each retained behavior is defined enough, assigned to a suitable mechanism, causally realizable in the planned composition, and paired with discriminating validation. Do not mistake polished prose for a sound design or planned validation for delivered behavior.

Do not decide whether the authorized business outcome is worth pursuing, or review staffing, budget, organization, code quality, or an exact delivered implementation. Expose a user-owned choice only when it changes the authorized outcome, required guarantee, allowed degradation, risk tolerance, or scope.

Concentrate on pivotal decisions whose reversal would materially alter the result, semantics, transition, reversibility, risk, or long-lived cost. Stop when further investigation cannot change a pivotal design judgment, its evidence boundary, or the minimum handoff.

## Execute One Stable Review

Reason in this order:

`independent basis -> reconstructed proposal -> obligation decision -> retained-design judgment -> falsification -> bounded conclusion`

1. **Establish an independent basis.** Determine the authorized outcome and observable failure criteria; the real cause; scope, non-goals, preserved behavior, and invariants; active contracts, consumers, constraints, threats, and operating conditions; required guarantees and allowed degradation; relevant current-system facts; the proposal's claimed level; and any concrete use named by the user. Make no design finding yet. Proceed once this basis, its authority, and its material unknowns can be stated without adopting the proposal's framing; keep only conclusions that depend on unresolved premises open.

2. **Reconstruct the proposal without accepting it.** Translate headings, examples, and task lists into pivotal commitments with intended effects, owners, contracts, state, dependencies, lifecycles, transitions, and affected producers or consumers. For each pivotal commitment, record its available support and authority: an authorized requirement or explicit user choice; an active contract or consumer; a verified current fact; a proposal assertion, assumption, or example; or reviewer inference. If owning evidence has not been obtained or relevant sources conflict, keep the support unresolved. Do not record necessary propagation as a source; decide it only in the next step. Neither the support nor its evidence state by itself decides whether the commitment belongs. Describe independent bundled changes separately before aggregating their consequences.

3. **Decide what belongs before auditing completeness.** Independently decide whether each pivotal commitment is directly required; a necessary consequence of an already retained upstream commitment; protection required by an established constraint or identified material failure; an explicit user-owned stronger guarantee; unsupported; or unresolved because the obligation itself is decision-changing and unknown. A necessary consequence is valid only when its upstream commitment already has authoritative support and the causal propagation is established. Current implementation, available capabilities, historical practice, examples, tests or mocks, proposal assumptions, and reviewer inference establish only their scoped facts; without this obligation trace they do not establish that a commitment belongs.

   Remove an unsupported commitment and invalidate its dependent findings only when deletion preserves established outcomes and invariants. If deletion could affect an active contract, existing data, committed effect, security fact, safety obligation, or another established result, obtain the smallest evidence that distinguishes absence from an unresolved obligation. Recompute the remaining target before continuing.

4. **Judge only the retained design.** Test whether its route acts on the established cause; whether existing or new capabilities fit; whether each material decision, authoritative fact, state transition, effect, failure response, and recovery rule has a capable semantic owner; whether contracts, state, behavior, boundaries, quality, failure semantics, and transition agree; and whether a materially simpler route preserves the same obligations with lower total lifecycle burden. Judge independent retained routes separately before testing their combined system.

   - When a pivotal judgment involves cross-boundary integration, durable state, capability choice, responsibility, authority, boundary placement, failure recovery, compatibility, migration, or cutover, read [references/system-design.md](references/system-design.md).
   - When a retained commitment depends materially on behavior produced by a model, human, runtime instruction, autonomous component, UI or channel, workflow, or tool-mediated path, read [references/behavioral-design.md](references/behavioral-design.md).
   - When both apply, use both; do not load either merely to complete a framework.

5. **Falsify the proposal and the reviewer's framing.** Attack the weakest high-impact, irreversible, cross-boundary, behavior-dependent, stateful, or weakly evidenced link. Test a credible simpler counterroute and the strongest viable interpretation under which the proposal is sound. Before concluding, ask:

   - Which pivotal conclusion depends only on the proposal's framing, an example, current structure, or a reviewer-introduced requirement?
   - If the earliest premise is removed or reversed, which dependent findings must be invalidated?
   - What smallest evidence could overturn the current design judgment, and has the conclusion been bounded accordingly?

6. **Conclude without repairing the proposal.** State which retained decisions hold, which have established defects, which remain open because of decision-changing evidence or a user-owned choice, and where each conclusion applies. If the user named a concrete use, state whether unresolved matters prevent it. Do not introduce new findings while drafting the handoff, invent a next step to complete the framework, or expand into implementation detail.

If a material premise or mechanism changes, invalidate dependent findings and reassess only the affected route, target, transition, evidence boundary, and conclusions. If a foundational route or owner fails, omit downstream detail that cannot change the viable direction or minimum handoff.

## Universal Design Standard

The justified proposal scope is:

`authorized outcome + necessary propagated consequences + protection required by established constraints or identified material failures`

A proposal is materially defective only when current evidence establishes a failure and its consequence for an authorized result, established obligation, active contract, material risk, or design validity. Apply these predicates without turning them into mandatory report sections:

- **Unsupported commitment:** it serves no authorized outcome, necessary propagation, active obligation, established protection, or accepted tradeoff.
- **False current-system premise:** it assumes a capability, path, owner, consumer, behavior, or constraint that current evidence contradicts.
- **Ineffective route:** the proposed change cannot causally produce the intended result or merely transfers the decisive failure.
- **Wrong capability or owner:** new construction duplicates a maintained capability, distorts ownership, creates a parallel source of truth or lifecycle, or leaves a material decision without capable authority.
- **Incoherent system:** execution, retry, recovery, migration, contracts, representations, or state use competing semantics or leave partial success ambiguous.
- **Misplaced boundary or excess structure:** responsibilities are split or combined without an invariant, authority, trust, lifecycle, failure-containment, variation, or concrete simplification reason.
- **Unexecutable transition:** active consumers and intermediate states cannot safely reach the target or recover from interruption under the required semantics.
- **Missing required quality:** performance, scale, security, privacy, reliability, observability, or operability is unaccounted for where an established condition makes it material.

Possible future demand, code similarity, nearby files, ordinary growth, cleanliness, option value, a named tool, or an illustrative platform does not create a present obligation. Conversely, a non-goal cannot exclude a necessary consequence, and simplification cannot waive active contracts, durable facts, committed effects, security boundaries, safety obligations, or required quality.

Do not require the proposal to beat every imaginable design. Conclude overdesign only with a materially simpler viable route that names the receiving owner, removes concrete commitments, preserves all established obligations and failure semantics, and does not transfer complexity.

## Evidence and Tool Use

Use the owning source for each fact: implementation and concrete consumers for current behavior; configuration and composition for runtime selection; contracts and official documentation for declared semantics; tests for covered scenarios; runtime or behavioral evidence for environment-specific outcomes. A declaration, dependency, interface, mock, passing test, or installed tool proves only what it directly exercises or makes possible.

Choose tools only when their result can distinguish pivotal design conclusions. Inspect the smallest relevant source slice, active path, consumer, type definition, official contract, runtime state, or behavior. Do not use a tool merely because it is available, and do not infer authorization for writes, external effects, or delivery acceptance from a read-only review.

Bound evidence to the version, environment, scenario, configuration, and path actually established. When sources conflict, distinguish the owner of actual behavior from the owner of required semantics and keep only the affected conclusion open. An unknown is not a defect and absence of evidence is not evidence of absence; require only the smallest separating validation.

Identify the proposal version only enough to avoid mixing material revisions. When it changes, reread the affected content and invalidate dependent conclusions; require a frozen hash only when reproducibility or unresolved ambiguity can change the judgment or where it applies.

## Form the Judgment

Use the earliest established causal failure and one proof chain for each material conclusion:

- **Established defect:** `verified fact -> failed design predicate -> affected obligation or risk -> concrete consequence -> minimum deletion, correction, or reopened decision`.
- **Decision-changing evidence gap:** `grounded unknown -> pivotal branch -> conclusions left open -> smallest separating validation and possible outcomes`.
- **User-owned tradeoff:** `choice -> affected guarantee, degradation, risk, or scope -> valid route and consequence under each option`.

Do not report a derivative problem again under another label. If a premise is unproven, report an evidence gap rather than assuming a defect. Missing later-stage detail is not a design defect unless it exposes a contradiction, missing current decision, or unaccounted obligation at the proposal's claimed level.

A design is sufficiently established for a stated use only when no established defect invalidates it; every decision and user-owned choice required for that use is resolved; applicable active paths and intermediate states are sufficiently closed; and remaining unknowns cannot overturn the result or are controlled by reversibility and isolation. A route may hold for selection while remaining unproven for implementation, cutover, or release.

## Output

Lead with one integrated judgment: whether the proposal remains within the authorized outcome, whether the retained route holds, why, and the minimum commitment that must be removed, changed, validated, or reopened. Then state where the judgment applies, decisive evidence limits, unresolved user choices, and—only when the user named a concrete use—whether those matters prevent it.

Include only findings that can change design validity, viable direction, material risk, long-lived complexity, evidence scope, or the minimum handoff. Do not expose the internal workflow, failure catalog, scorecard, or fixed verdict vocabulary. Do not rewrite the proposal, prescribe code organization, or add naming, formatting, test-layout, documentation, and cleanup advice that cannot change the design judgment.

End with evidence boundaries, residual risks, revalidation triggers, or intentional exclusions only when they affect the decision. Remove every sentence whose absence would not change the judgment, evidence boundary, minimum action, or material remaining risk.
