# Overview Designer Drafting Standard

Use this standard only to express the target-design judgment completed in `SKILL.md`. Do not decide the goal, route, mechanism significance, ownership, state, failure semantics, adoption, or revision classification while drafting. Return an exposed semantic gap to the stage that owns it instead of inventing a mechanism through document structure. The task model, selection proof, design argument, and any `<design-reasoning>` block do not enter the artifact.

Write in the requested language, or otherwise the request's primary language. Preserve established project terms, identifiers, code symbols, interface names, and quoted contracts unless translation is requested. Use direct project language rather than the reasoning vocabulary from `SKILL.md`.

## Shape the Document Around the Judgment

Include only what the reader needs to understand or decide. Do not preselect a template or organize the artifact around modules, files, implementation tasks, investigation steps, alternatives explored, or the Skill method. Describe existing behavior only when it establishes the problem, explains the operating model, constrains the design, or makes an evolution decision understandable.

Keep current facts, proposed design, adoption, implementation, and evidence limitations distinguishable wherever confusion would affect a decision. Do not create parallel sections merely to label these states. An executive summary may index conclusions already established by the Overall Design and Key Designs, but cannot replace them.

## Information Before the Design

Near the title, include only information needed to interpret the artifact. Show design status and its authority basis when they affect how the target design may be used. State implementation status or a material evidence limitation only when it changes that use. Follow an existing version convention; otherwise omit version metadata and ceremonial fields.

Keep background to the observable result, impact, preserved behavior, allowed degradation, scope and non-goals, governing constraints, relevant starting conditions, and evidence limits that shape the judgment. Show a next decision point only when an unresolved condition can change the route or block the next system judgment. Keep local assumptions, risks, and unresolved conditions with the design they affect.

## Overall Design

Lead with a paragraph that independently states the operating conclusion: what the system does, who collaborates, who owns the decisive facts and decisions, how the parts produce the observable result, the material change from the relevant starting state, the governing limits, and—when a decision would be affected by a plausible but uncommitted future—what the design deliberately leaves open and what it closes. Include only applicable elements, and make clear when a route is proposed rather than implemented.

Then trace a representative end-to-end flow using actual project objects and actions across initiation, facts, decisions, information or state changes, effects, result handoffs, and cross-mechanism failure takeover. Add a second flow only when its difference explains a material branch, change, or evolution requirement. Make responsibility boundaries and dependency direction visible where they determine the result. State what each Key Design contributes; leave its internal rules and local failure handling to its own section.

Use one minimal relationship diagram when several responsibility boundaries are materially clearer visually. Add a flow, sequence, or state diagram only when order, branching, state, recovery, or cutover determines the conclusion. A diagram does not replace the operating judgment, responsibility, or tradeoff.

## Key Designs

Include only mechanisms established as independently design-significant in `SKILL.md`, and omit the chapter when none qualify. Name each section after the business outcome or operating responsibility it owns, not a repository, module, interface, table, or implementation task.

Open each section with a self-contained design judgment: mechanism, owner, responsibility and change boundary, material contract and dependency direction, input from and result returned to the overall flow, observable result, and key limits. Keep each consequential choice with its owning mechanism. Other sections may reference its result and impact but must not repeat its internal rule.

After the opening, include only the facts and inputs, information authority, necessary state and handoffs, key branches, failure, recovery, and lifecycle implications needed to make the mechanism hold. For each material handoff, express the handoff guarantee established in Stage 3. Express the established obligation and lifecycle justification for any lifecycle-expanding mechanism. For a consequential choice with a real alternative, express the selection proof established in Stage 3; do not rederive or manufacture a comparison here.

## Evolution, Acceptance, and Unresolved Matters

Include evolution only when coexistence or transition affects correctness. Describe each necessary operating state through its responsibilities, reads and writes, compatibility boundary, cutover, rollback locations, irreversible points, and old-path exit. Do not add a roadmap, future phases, or compatibility for inactive consumers or uncommitted possibilities.

Include a dedicated Acceptance section when the proposed result must be qualified. Organize it around the few end-to-end scenarios and evidence that distinguish whether observable outcomes, preserved behavior, constraints, and major risks are satisfied. Reference Key Designs without repeating their mechanisms.

Keep assumptions, risks, and unresolved conditions with their owning design, including impact, responsible source, and the smallest evidence or authority decision needed. Use a final Unresolved Matters section only for items that can change the overall route or next system judgment and cannot be owned locally; omit it when empty.

## Revision Record

Use the revision classification established in Stage 4; do not rederive it while drafting. Include a revision record only when Stage 4 classified a within-route design revision, route change, or intent change; omit it otherwise. The record reports change, impact, and basis; it proves neither the underlying fact, adoption, nor implementation and cannot be the only place where a design or unresolved condition appears.

Use one compact table, following an existing project convention when available and inventing no identifiers:

| Design changed | Mechanism, responsibility, or choice changed | Impact | Basis and source |
| --- | --- | --- | --- |

Aggregate related changes and point to the owning design. Do not output an empty table. Use `修订记录` in Chinese and `Revision Record` in English unless a mandatory template requires another title.

## Drafting Checks

- **Skeleton:** From the Overall Design opening and representative flow plus every Key Design title and opening paragraph, a reader can restate the whole judgment, each owned outcome, key responsibility boundaries, and the basis and status of consequential claims.
- **Support and ownership:** Every later paragraph, list, table, and diagram proves, explains, or bounds its opening judgment. Overall Design owns the global result, cross-mechanism constraints, and handoffs; Key Designs own their mechanisms; Evolution owns coexistence and exit. A rule, failure, or choice is argued once at its owner.
- **System consistency:** Prose, diagrams, terminology, information, state, contracts, failures, acceptance, and evolution describe the same system across applicable conditional, parallel, and re-entry paths. Factual claims remain within evidence, and proposed design remains distinguishable from implementation.
- **Revision expression:** For completion or rewrite, every preserved, corrected, changed, or removed item in the established semantic change surface appears consistently in the artifact. Valid mechanisms and evidence remain; superseded machinery and claims do not. If a design change is missing, return to `SKILL.md` rather than deriving it here.

Finally remove content that cannot change understanding of system operation, design judgment, evidence boundary, or the next decision. Keep depth proportional to the conclusion it can change. Include code, interface, test, or operational detail only when it supports system-level understanding or a design judgment.
