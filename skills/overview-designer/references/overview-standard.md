# Overview Designer Drafting Standard

Use this standard to express the supported design or bounded unresolved result established in `SKILL.md`. Do not decide the goal, quality priorities, route, mechanism significance, ownership, state, failure semantics, adoption, or revision classification while drafting. Return an exposed semantic gap to its owning stage instead of inventing a mechanism through document structure.

A complete or conditional design uses the skeleton appropriate to its scope. A whole-system artifact uses Overall Design and includes Key Designs only for independently significant mechanisms. A local design opens with its scoped judgment, then only the inputs, outputs, responsibilities, handoffs, tradeoffs, and supporting detail needed to understand it; add a flow or subsection only when useful. Reference the surrounding adopted design without rebuilding it. Whole-system chapter rules below do not require local designs to create those chapters. For suspension, state the conflict, affected scope, preserved conclusions, options if known, and required fact or decision; a complete target skeleton is not required. Modify only authorized artifacts and preserve still-valid content.

Write in the requested language, or otherwise the request's primary language. Preserve established project terms, identifiers, code symbols, interface names, and quoted contracts unless translation is requested. Use direct project language rather than the reasoning vocabulary from `SKILL.md`.

## Shape the Document Around the Judgment

Include only what the reader needs to understand or decide. Do not preselect a template or organize the artifact around modules, files, implementation tasks, investigation steps, alternatives explored, or the Skill method. Describe existing behavior only when it establishes the problem, explains the operating model, constrains the design, or makes an evolution decision understandable.

Keep current facts, proposed design, adoption, implementation, and evidence limitations distinguishable wherever confusion would affect a decision. Do not create parallel sections merely to label these states. An executive summary may index conclusions already established by the skeleton's design sections, but cannot replace them.

## Information Before the Design

Near the title, include only information needed to interpret the artifact. Show design status and its authority basis when they affect how the target design may be used. State implementation status or a material evidence limitation only when it changes that use. Follow an existing version convention; otherwise omit version metadata and ceremonial fields.

Keep background to the observable result, impact, preserved behavior, scope, hard constraints, important quality priorities, relevant starting conditions, and evidence limits that shape the judgment. Distinguish required thresholds from preferences and estimates. Show a next decision point only when an unresolved condition can change the route or block the next judgment. Keep local assumptions, risks, and conditions with the design they affect.

## Overall Design

For a whole-system artifact, this chapter expresses the overall operating model; Key Designs express the independently design-significant mechanisms. For a key design or local scope, follow the scope rule above instead of this structure.

Lead with a paragraph stating the operating conclusion: what the system does, how its main responsibilities cooperate to produce the result, and the decisive change, tradeoff, and limits. Then explain any abstractions or dependency boundaries whose rationale matters, including what they enable or hide. Include only material elements; do not pack every proof into the opening. Keep proposed design distinguishable from implementation.

Then trace a representative end-to-end flow using actual project objects and actions across initiation, facts, decisions, information or state changes, effects, result handoffs, and cross-mechanism failure takeover. Add a second flow only when its difference explains a material branch, change, or evolution requirement. Make responsibility boundaries and dependency direction visible where they determine the result. State what each Key Design contributes; leave its internal rules and local failure handling to its own section.

Use one minimal relationship diagram when several responsibility boundaries are materially clearer visually. Add a flow, sequence, or state diagram only when order, branching, state, recovery, or cutover determines the conclusion. A diagram does not replace the operating judgment, responsibility, or tradeoff.

## Key Designs

Include only mechanisms established as independently design-significant in `SKILL.md`, and omit the chapter when none qualify. Name each section for the outcome or responsibility it owns, including a real protocol or platform responsibility; a repository, module, interface, or table name alone does not explain the design.

Open each section with a self-contained design judgment: mechanism, owner, responsibility and change boundary, material contract and dependency direction, input from and result returned to the overall flow, observable result, and key limits. Keep each consequential choice with its owning mechanism. Other sections may reference its result and impact but must not repeat its internal rule.

After the opening, include only the facts, authority, state, handoffs, branches, failure, recovery, and lifecycle implications needed to support it. Express Stage 3's material handoff guarantees and the established requirement or quality benefit justifying added lifecycle cost. For a consequential choice, express the selection proof without rederiving it: why this route is preferable, the strongest viable alternative, costs and their bearers, evidence limits, and reconsideration conditions. A selected simple route needs no invented deficiency. Keep supporting detail proportional to what it establishes.

## Evolution, Acceptance, and Unresolved Matters

Keep supported change boundaries with the relevant design: what can change locally, what needs coordination, and what would require reconsideration. Include a dedicated transition account only when coexistence or cutover affects correctness. Describe necessary operating states through responsibilities, reads and writes, compatibility, cutover, rollback locations, irreversible points, and old-path exit. Neither change boundaries nor transition needs justify a roadmap or machinery for uncommitted possibilities.

Include a dedicated Acceptance section when the proposed result must be qualified. Use the few operating and change scenarios and evidence that distinguish whether outcomes, preserved behavior, constraints, important quality goals, and major risks are satisfied. Reference the design sections without repeating their mechanisms. Proposed verification is not evidence that the result already holds.

Keep assumptions, risks, and unresolved conditions with their owning design, including impact, responsible source, and the smallest evidence or authority decision needed. Use a final Unresolved Matters section only for items that can change the overall route or next system judgment and cannot be owned locally; omit it when empty.

## Revision Record

Use the revision classification established in Stage 4; do not rederive it while drafting. Include a revision record only when Stage 4 classified a within-route design revision, route change, or intent change; omit it otherwise. The record reports change, impact, and basis; it proves neither the underlying fact, adoption, nor implementation and cannot be the only place where a design or unresolved condition appears.

Use one compact table, following an existing project convention when available and inventing no identifiers:

| Design changed | Mechanism, responsibility, or choice changed | Impact | Basis and source |
| --- | --- | --- | --- |

Aggregate related changes and point to the owning design. Do not output an empty table. Use `修订记录` in Chinese and `Revision Record` in English unless a mandatory template requires another title.

## Drafting Checks

- **Skeleton:** For a whole-system artifact, from the Overall Design opening and representative flow plus every Key Design title and opening paragraph, a reader can restate the whole judgment, each owned outcome, key responsibility boundaries, and the basis and status of consequential claims. For a local scope, the opening judgment alone, with the inputs, outputs, boundary, and handoffs it names, lets a reader restate the scoped judgment and its basis and status.
- **Suspension:** When no supported authorized target can be selected, the bounded account makes the blocker, affected scope, preserved conclusions, and next required fact or decision recoverable. Apply the design skeleton checks only to design content actually established; do not fill missing mechanisms or assign adoption to a proposed alternative.
- **Support and ownership:** Every later paragraph, list, table, and diagram proves, explains, or bounds its opening judgment. For a whole-system artifact, Overall Design owns the global result, cross-mechanism constraints, and handoffs and Key Designs own their mechanisms; for a local scope, the opening judgment owns the scoped result and the handoffs to the surrounding system. Evolution owns coexistence and exit. A rule, failure, or choice is argued once at its owner.
- **System consistency:** Prose, diagrams, terminology, information, state, contracts, failures, acceptance, and evolution describe the same system across applicable conditional, parallel, and re-entry paths. Factual claims remain within evidence, and proposed design remains distinguishable from implementation.
- **Decision usefulness:** A reader can understand how significant abstractions and responsibilities support the result, why material quality benefits warrant their costs, and which conditions would change the judgment. Express only established tradeoffs and change boundaries; do not create a quality checklist.
- **Revision expression:** For completion, revision, or rewrite, every preserved, corrected, changed, or removed item in the established semantic change surface appears consistently in the artifact. Valid mechanisms and evidence remain; superseded machinery and claims do not. If a design change is missing, return to `SKILL.md` rather than deriving it here.

Finally remove content that cannot change understanding of system operation, design judgment, evidence boundary, or the next decision. Keep depth proportional to the conclusion it can change. Include code, interface, test, or operational detail only when it supports system-level understanding or a design judgment.
