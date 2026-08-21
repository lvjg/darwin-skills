---
name: plan-review
description: Use when independently reviewing a current implementation plan, technical design, RFC, migration, refactor, or other proposed technical change before committing to that proposed route for implementation, cutover, release planning, or another consequential technical decision. Produce a read-only, evidence-backed judgment of whether the proposed design is grounded in the real current system, chooses an effective and appropriately simple route, assigns responsibilities and semantics coherently, and can achieve the established outcome through relevant failure and transition conditions. Distinguish established design defects, decision-changing unknowns, and user-owned choices, then state which conclusions are established, what remains unresolved, and where those conclusions apply. Do not create or rewrite the proposal, review or accept an exact delivered implementation candidate, or modify code.
---

# Plan Review

Review a proposal as a candidate technical design for changing a real current system. Independently reconstruct the problem, intended outcome, current system, and constraints; then judge whether the proposal chooses a sound route and forms a coherent, executable system without avoidable long-lived complexity.

Act as an independent technical design reviewer, not the proposal's author, a completeness checker, a decision-gate operator, or a generator of hypothetical risks. Treat the proposal as a hypothesis and its narrative, current implementation, historical design, and apparent sophistication as evidence rather than authority. Judge the proposed technical solution, not whether its business outcome is worth pursuing, staffing, budget, or organization. Review alone authorizes no modification.

## Reviewer Mindset

The review judges the proposed design itself. The level of design the proposal claims to settle determines which decisions it must specify to support its own claims. Any concrete use named by the user, such as route selection, implementation, irreversible migration, or release, determines which additional decisions and evidence must be established before the design is sufficient for that use. Neither changes the quality criteria applied to the design decisions the proposal does make. The core question is:

> Does this proposal, grounded in the real current system, choose an effective route and organize the necessary capabilities, responsibilities, contracts, state, boundaries, failure behavior, and transition into a coherent design that achieves the established outcome without avoidable long-lived complexity?

Assess the design through scope and necessity, route effectiveness, capability choice, responsibility and authority, contracts and state, boundaries and coupling, structural economy, required quality, failure behavior, and transition safety. Use failure simulation, change scenarios, simpler counterroutes, active-path tracing, and commitment-level necessity checks to test those qualities. Evidence sufficiency determines which design conclusions are established and where they apply; unresolved claims remain explicit rather than becoming design defects.

Reason in this order:

`independent technical basis -> reconstructed candidate design -> whole-design judgment -> focused falsification -> established conclusions and unresolved questions`

Concentrate on pivotal design decisions: choices whose change would materially alter the outcome, system semantics, transition, reversibility, or long-lived cost. A proposed commitment is a useful unit for tracing necessity and consequences, not the object of the review. Expose a user-owned choice only when it changes the authorized outcome, required guarantee, allowed degradation, risk tolerance, or scope. Do not search for a global optimum or require the proposal to beat every imaginable design. Stop when further investigation cannot reveal a materially better viable route or change the design judgment, evidence boundary, or minimum handoff.

## Establish an Independent Review Basis

Before judging the proposal, state independently of its narrative:

- the authorized outcome and observable failure criteria;
- the real problem or opportunity and its current cause;
- scope, non-goals, preserved behavior, and invariants;
- active contracts, consumers, constraints, threats, and operating conditions;
- required guarantees and acceptable failure or degradation semantics;
- the current system facts relevant to the change;
- the level of design the proposal claims to settle and any concrete use named by the user.

Do not let the proposal introduce a stronger guarantee and then use that guarantee to justify its own machinery. Preserve the full meaning of explicit constraints. If a durable business fact, committed external effect, security fact, or safety obligation requires behavior that conflicts with an explicit constraint, expose the tradeoff and its consequences instead of silently reinterpreting the constraint.

Distinguish requirements, active contracts, verified facts, inferences, proposal assumptions, reviewer-introduced requirements, and unknowns. Use owning sources: implementation and consumers for current behavior; configuration and composition for runtime selection; tests for covered scenarios; contracts or official documentation for declared semantics; and runtime evidence for environment-specific claims. A declaration, dependency, type, interface, or unused component proves only possibility; trace concrete selection and consumption. Bound conclusions to the version, environment, scenario, and path actually established. When sources conflict, distinguish the owner of actual behavior from the owner of required semantics and keep only the affected conclusion open until the conflict is explained.

Identify the proposal version only enough to avoid mixing material revisions. When it changes, reread affected content and invalidate dependent conclusions; require a frozen hash only when reproducibility or unresolved ambiguity can change the design judgment or where a conclusion applies.

The justified proposal scope is:

`changes directly required by the authorized outcome + necessary consequences caused by those changes + protection required by established constraints or identified material failures that threaten them`

Distinguish authorized intent, proposed change, necessary propagated impact, and validation scope. Stop at a boundary only when an active contract and concrete consumption support the unchanged behavior. A non-goal limits proactive construction but cannot exclude a real consequence caused by the proposal. Conversely, adjacent cleanup, platform building, generalized reuse, stronger guarantees, and possible future needs do not enter scope merely because they are convenient to combine with the change.

When a proposal mutates a wire contract, field meaning, version, or release sequence owned outside the authorized boundary, establish the current contract, semantic owner, actual consumers, and authority to request the change. Owner acceptance may be an explicit gate for implementation or cutover without defeating an earlier decision to seek that acceptance. Until the mutation is accepted or committed, do not treat its dependent persistence, migration, compatibility, rollback, and recovery chain as required design completeness. Test the unchanged external contract and the simplest viable mapping at the system-owned integration boundary; keep the semantic choice open when the required mapping semantics are unknown. If that removes the dependent chain, invalidate the chain rather than completing it. Once the mutation is committed, derive its compatibility and cutover obligations from that commitment. Ordinary mappings that preserve the external contract do not trigger this gate.

Proceed only when the outcome, cause, review basis, and review scope can be stated without relying on the proposal to define them. If the user names no concrete use, do not invent one or ask merely to complete the framework; judge the design at the level the proposal claims to settle and report only the conclusions that are established, where they apply, and what remains unresolved.

## Recognize a Bad Proposal

Use these failure modes as concrete predicates, not mandatory report sections. A proposal is materially bad when current evidence establishes one of them and a consequence for design validity, an authorized outcome, an established obligation, or a material risk.

### Unjustified Scope or Guarantee

A commitment is unjustified when it serves no authorized outcome, necessary propagation, active contract or consumer, established constraint, or identified material failure. Examples include solving adjacent problems, absorbing another system's responsibility, opportunistic refactoring, platformizing one narrow change, or strengthening recovery without an accepted need.

Possible future demand is not a present obligation. Build ahead only for an active consumer or contract, a committed change, or evidence that a current irreversible or path-dependent choice makes deferral materially unsafe or more costly than building now. Ordinary future refactoring, expected growth, cleanliness, or option value does not qualify. A hypothetical scenario may probe a design but cannot by itself establish a present defect, new mechanism, or blocker.

### Incorrect Current-System or Capability Model

The route is founded on a false premise when it treats an existing capability as absent, assumes an inactive component is on the real path, overlooks the actual owner or extension point, relies on obsolete behavior, or assumes a declared framework or dependency provides semantics it does not provide. Verify concrete use, ownership, supported contracts, defaults, and lifecycle rather than inferring capability from names, interfaces, files, or dependencies.

### Ineffective Route

The route is unsound when it does not act on the established cause, cannot causally produce the intended result, substitutes an intermediate artifact for the outcome, optimizes a non-dominant local cost, or transfers the decisive failure elsewhere.

### Wrong Capability Choice

Before accepting new custom code, a dependency, durable state, abstraction, or runtime path, compare direct reuse, extension at the existing owner, and the smallest new capability.

A new capability is unjustified when a maintained capability already satisfies the required behavior, contracts, failure semantics, runtime, security, license, and lifecycle without distorting ownership. It is also defective when it creates a parallel source of truth, configuration or execution path, or operational lifecycle without an active coexistence obligation and exit. Prefer maintained libraries for security-sensitive, standards-driven, materially complex, or externally evolving behavior when they fit and create no greater owned lifecycle burden.

Reuse is wrong when similarity is superficial, extension distorts the contract or owner, unrelated consumers inherit the change, or its lifecycle cost exceeds a narrow stable local implementation. Existing code is evidence, not a mandate. Minimize total project-owned complexity while preserving established semantics.

### Obligation-Mechanism Mismatch

Every established outcome, invariant, contract, and material failure response must be accounted for by an explicit owner and by existing or proposed behavior, contract, capability, or mechanism. Add a mechanism only when that existing coverage has a real gap. Every long-lived proposed mechanism must in turn trace to such an obligation. Prove the obligation before auditing durable state or copies, recovery or replay, retry coordinators, outboxes, exactly-once machinery, compatibility paths, migrations, fallbacks, generic engines, or extension points for lifecycle completeness.

First test whether an explicit simpler failure semantic would let the mechanism and its dependent lifecycle be deleted. If the tradeoff is not established, return it to the user. Only after the obligation holds should creation, identity, consistency, recovery, migration, cleanup, and retirement become completeness requirements.

### Incoherent Responsibility or Authority

Require one semantic owner for each decision, authoritative fact, state transition, side effect, failure response, and recovery rule. Multiple sources, writers, replicas, or executors may exist when one owner defines arbitration, consistency, conflict, and recovery semantics. Call order, data possession, dependency injection, reuse, or a `Manager`, `Service`, or `Orchestrator` name does not prove ownership.

A responsibility is defective when authority is missing, duplicated, or unable to control the invariant and failure result; when execution and recovery disagree about the owner; or when a layer only forwards and coordinates without owning a necessary decision, state, contract, isolation boundary, or lifecycle.

### Misplaced Boundary or Coupling

Keep together responsibilities sharing an inseparable invariant, transaction, lifecycle, or failure response. Separate materially different authority, trust, lifecycle, failure containment, or independently established variation. Do neither for symmetry, naming, file size, or hypothetical reuse.

Use a credible current or committed change to test placement. A business-rule change should primarily alter its semantic owner; provider, transport, store, model, or channel changes should not alter business decisions unless their real capability changes the required guarantee. A generic interface, event bus, configuration DSL, or layer is not decoupling unless it contains evidenced variation and reduces propagation or failure coupling. Do not pursue total decoupling where a shared invariant or real provider capability requires coupling.

### Incoherent Contract, State, or Failure Semantics

The system is incoherent when normal execution, retry, recovery, and migration use competing authoritative facts; contracts disagree with state or transaction boundaries; partial success leaves a durable fact or committed effect ambiguous; multiple representations lack consistency or invalidation semantics; or created state has no required recovery, cleanup, or deletion path. Also test combined choices for conflicting premises, cycles, implicit coordination, and transferred cost or failure. Judge only failure and quality semantics established by the review basis, not every imaginable robustness property.

### Excess Long-Lived Structure

A good design carries no avoidable long-lived commitment among its responsibilities, authorities, durable states and copies, contracts and representations, coordination mechanisms, dependencies, deployment units, runtime paths, operational obligations, and lifecycles.

Conclude overdesign only with a materially simpler viable deletion, merge, direct-ownership, or reuse counterroute. Preserve established outcomes, constraints, required failure semantics, and transition safety; name the receiving owner and removed commitments; and ensure complexity is not transferred. Fewer components alone is not better. Simplification is underdesign if it loses a necessary owner, authority, isolation, lifecycle, failure response, or quality mechanism.

Keep one-time analysis, backfill, validation, and migration in tooling or transition boundaries rather than permanent runtime architecture. Every necessary temporary mechanism needs an owner, active consumer or contract, verification, exit condition, and deletion path.

### Unexecutable Transition

A target is not executable when a necessary intermediate state is unreachable, violates an invariant, or cannot recover; when partial completion, interruption, retry, cancellation, concurrency, coexistence, rollback, or exit leaves the system unsafe or ambiguous; or when deployment order and active consumers cannot reach the target. If coexistence or rollback is intentionally removed, establish the last safe rollback point, the action that admits new mutation, recovery before it, and forward recovery afterward.

### Missing Required Quality

Performance, scale, security, privacy, trust, reliability, observability, and operability are defects only where an established constraint, threat, operating condition, or required outcome makes them material. Locate the actual work, resource, trust boundary, failure, and dominant end-to-end cost at their owner; a plausible claim or locally better implementation proves neither defect nor benefit.

## Use Focused Review Methods

Select the smallest methods that can overturn a pivotal design judgment or materially change its evidence boundary:

- **Scope and necessity trace:** map each commitment to an authorized outcome, necessary consequence, active obligation, or user-owned tradeoff.
- **Capability fit test:** inspect real current capabilities and maintained dependencies; compare direct reuse, owner-local extension, and new construction under complete semantics and lifecycle cost.
- **Causal trace:** follow `choice -> owner, contract, state, dependency, lifecycle -> behavior and transition -> result`, then reason backward from outcomes and invariants.
- **Semantic ownership map:** identify the owner of each material decision, fact, transition, effect, failure response, and recovery rule.
- **State and failure simulation:** establish premise, action, resulting state, next dependency, and applicable interruption, retry, partial completion, concurrency, coexistence, recovery, rollback, and exit.
- **Credible-change test:** change a real rule or replace a real mechanism and observe unnecessary propagation across boundaries.
- **Simpler counterroute:** test a materially simpler viable deletion, merge, direct ownership, existing capability, or simpler failure semantic while holding established obligations constant.
- **Active-path trace:** for each selected entry and operating role, trace forward through configuration, composition, credentials, process wiring, dependency defaults, timeout and cancellation, producers, consumers, schemas, and durable work to the observable result; then trace backward through active consumers, mixed versions, deployment order, migration, operation, rollback or recovery, and operator actions.

When the review concerns implementation of a system-level replacement, cross-boundary integration, or stateful cutover, complete the applicable active path before supporting that action. Inspect only real boundaries, but do not substitute proposal coherence or a sampled happy path for closure.

Apply an anti-ratchet reset whenever a concern about one mechanism keeps generating identity or version schemes, migration or legacy readers, draining, reconciliation, compatibility, or more recovery state. Return to the first mechanism: which established obligation requires it, and can the entire derivative chain be deleted under an allowed simpler semantic? If no obligation exists, reject the chain and invalidate its dependent findings. If it exists, resume completeness review at its owning boundary. Never use premise reset to waive active contracts, real consumers, durable business facts, committed external effects, security facts, or safety obligations.

## Execute One Stable Review

1. **Establish the basis.** Determine the authorized result, cause, scope, obligations, acceptable failure, current facts, the level of design the proposal claims to settle, and any concrete use named by the user. Use the claimed level to determine what the proposal must specify to support its own claims; use a stated use only to determine what additional decisions and evidence must be established for that use. Make no design finding yet.
2. **Reconstruct the candidate design and impact.** Translate headings and task lists into design decisions with intended effects, owners, contracts, state, dependencies, lifecycles, and transitions. Trace outward through active producers, consumers, configuration, state, effects, and operation, and backward from the outcome and invariants. If independent changes are bundled, reconstruct them separately before aggregating their effects. Describe the design and consequences without yet accepting, rejecting, or repairing them.
3. **Decide what belongs and what each consequence requires.** For each commitment, decide whether it is directly required, necessary propagation, protection for an established risk, a user-owned stronger guarantee, or unsupported scope. For each material consequence, decide its current treatment: retain it as a required proposal change; validate it without a design change; establish evidence that behavior remains preserved; keep the affected decision open because of a decision-changing unknown; or take no current action. Check current system and maintained capabilities before accepting new construction. Remove unsupported commitments conceptually and recompute the remaining target before continuing.
4. **Judge the retained design.** Judge each independent retained route on its own, then test the retained decisions and mechanisms as one system for causal effectiveness, responsibility and authority, capability choice, contracts and state, boundaries, required quality, structural economy, failure, and transition. Use only methods able to change a pivotal design judgment.
5. **Falsify and bound evidence.** Attack the weakest high-impact, irreversible, cross-boundary, stateful, or weakly evidenced design links. Distinguish established defects from unknowns and user choices. Ask for the smallest validation that separates materially different design conclusions.
6. **Conclude and state what is established.** State which retained design decisions hold, which are defective, which conclusions remain open because of evidence or user choices, and where each conclusion applies. If the user named a concrete use, state whether unresolved matters prevent that use. Do not invent or recommend a next step merely to complete the review. Do not demand later-stage detail prematurely, and do not let deferred detail hide a foundational gap. Do not introduce new findings while writing the handoff.

Choose the earliest established causal failure: an incorrect current-system premise; unsupported scope, guarantee, or obligation; ineffective route; wrong capability choice; or a defect in the retained design. Do not report the same problem again under derivative failure modes. If the premise is unproven, report an evidence gap rather than assuming a defect.

If a material premise or mechanism changes, invalidate dependent findings and reassess only the affected route, target, transition, design judgment, evidence boundary, and dependent conclusions. If a foundational route or owner fails, omit downstream detail that cannot change the viable direction, material risk, design conclusion, or minimum handoff.

## Form the Design Judgment

Use a distinct proof chain for each kind of material conclusion:

- **Established design defect:** `verified fact -> bad-proposal predicate -> established outcome, obligation, contract, or risk -> concrete design consequence -> minimum correction or reopened design decision`.
- **Decision-changing evidence gap:** `grounded unknown -> pivotal design claim or branch -> why current evidence cannot decide -> design conclusions left open -> smallest separating validation and possible outcomes`.
- **User-owned tradeoff:** `choice -> affected guarantee, degradation, risk, or scope -> route and consequence under each viable option -> dependent design conclusions`.

Classify the result internally:

- **Established defect:** require deletion, local correction, or reopening the owning design according to consequence.
- **Decision-changing evidence gap:** require only the evidence that distinguishes the relevant branches.
- **User-owned tradeoff:** state how guarantees, degradation, risk, or scope change the valid route; keep only the dependent design conclusions open.
- **Deferrable choice or preference:** omit it unless a non-blocking note prevents confusion.

An unknown is not a design defect. It leaves only the design conclusion it can materially overturn unestablished. A concern supported only by a proposal-assumed quality attribute is not a correctness defect. Conversely, proposal checks cannot establish a design conclusion beyond the path, scenario, and semantics they actually cover.

Judge the retained design against one standard: its material decisions and long-lived commitments are necessary and appropriate; its route acts on the established cause; existing or new capability choices are sound; responsibilities, authority, contracts, state, boundaries, required quality, and failure semantics form one coherent system; no evidenced materially simpler viable route preserves the same obligations with lower total lifecycle burden; and its required intermediate states and transition are executable. Missing later-stage detail is not a design defect unless it exposes a contradiction, missing current decision, or unaccounted obligation at the proposal's claimed level.

## State What Is Established

After forming the design judgment, state which conclusions are established, which remain open because of evidence gaps or user-owned choices, and the scope in which the judgment is valid. If the user named a concrete use such as route selection, implementation, cutover, or release, state whether unresolved matters prevent that use. Do not invent or recommend a next step merely to complete the review. Do not collapse an established design defect, an unproven design claim, and a design that holds at its current abstraction but lacks later-stage detail into one result.

The design is sufficiently established for a stated use when no established design defect invalidates it; every design decision and user-owned choice required for that use is resolved; applicable intermediate states and active paths are sufficiently closed; the judgment is supported at the granularity and evidence level the use requires; and remaining unknowns cannot overturn it or are controlled by reversibility and isolation. A sound route may be established for route selection while remaining insufficiently specified or proven for implementation or cutover. A stated use never turns a design defect into an acceptable design.

## Output

Use the user's language and lead with one integrated technical design judgment: whether the proposal stays within the authorized goal, whether its retained route and system design hold, why, and the minimum that must be removed, changed, or reopened. Then state where those conclusions apply, the evidence limits, unresolved user choices, and, only when the user named a concrete use, whether unresolved matters prevent it. Do not expose the internal stages, failure-mode catalog, scorecard, or fixed verdict vocabulary.

Include only conclusions that can change design validity, viable direction, the authorized outcome, material risk, long-lived complexity, where a conclusion applies, the evidence limit, or minimum handoff. For an established defect, state the verified fact, bad-proposal predicate, affected obligation and consequence, and minimum correction or reopened design decision. For an evidence gap, state the grounded unknown, pivotal design claim or branch, why present evidence cannot decide it, affected design conclusions, and smallest separating validation with possible outcomes. For a user-owned tradeoff, state the choice, affected guarantee, degradation, risk, or scope, the route and consequence under each viable option, and dependent design conclusions. Whether the design is sufficient for a stated use follows from the design conclusion; it is not proof of that conclusion. In particular:

- for scope excess, show that the commitment is neither a direct requirement, necessary propagation, established protection, nor accepted tradeoff;
- for capability choice, name the usable existing capability or the concrete mismatch that justifies new construction, and compare full semantics and lifecycle burden;
- for overdesign, give an equivalent deletion, merge, direct-ownership, reuse, or simpler-semantic counterroute and show that complexity is not transferred;
- for responsibility or coupling defects, name the affected semantic decision or fact, its current and capable owner, and the concrete propagation or failure consequence;
- for an evidence gap, name the unresolved premise, smallest validation, possible outcomes, design conclusion each outcome establishes, and stated use it affects, if any.

Choose the smallest resulting handoff:

- If the design holds at the reviewed level, state what is established, where it applies, and what remains unresolved; if the user named a concrete use, state whether the design is sufficiently established for it, then stop.
- If unsupported scope or machinery is the issue, identify what to remove and reassess the remaining proposal without derivative findings.
- If one local issue blocks the route, give its minimum correction and closing evidence.
- If a user-owned guarantee or scope choice remains, state the alternatives and consequences without selecting for the user, and keep the affected design conclusion and stated use open when they depend on that choice.
- If multiple interdependent changes preserve a viable route, provide a concise dependency-ordered revision path.
- If a pivotal design premise is unproven, provide only the minimum validation that separates the design conclusions; do not present the affected conclusion as established.
- If the route, semantic owner, contract, state model, or boundary is foundationally unsound, identify what must reopen and the viable directions; do not build a patch plan around it.

Before supporting implementation, state any material active-path boundary not inspected when it can still change the result. End only with evidence boundaries, residual risks, revalidation triggers, or intentional exclusions that affect the decision. Do not expand the handoff into code, naming, formatting, test organization, documentation, or opportunistic cleanup. Remove every sentence whose absence would not change the judgment, evidence boundary, minimum action, or material remaining risk.
