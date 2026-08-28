# System Overview Design Drafting Standard

Use this standard only to express the judgment completed in `SKILL.md`. Do not decide the goal, route, whether a mechanism is independently design-significant, ownership, state, or failure semantics while drafting. Return an exposed gap to the stage that owns it instead of inventing a mechanism through document structure.

Write in the language requested by the user; otherwise follow the primary language of the request. Preserve established project terms, identifiers, code symbols, interface names, and quoted contracts unless translation is requested. Use direct project language rather than importing the reasoning vocabulary from `SKILL.md`.

## Shape the Document Around the Judgment

Include only what the reader needs to understand or decide. Do not preselect a template, mirror existing and proposed structures, or organize the document around modules, files, implementation tasks, investigation steps, or the method in `SKILL.md`. Describe existing behavior only when it establishes the problem, explains the operating model, constrains the design, or makes an evolution decision understandable. Include a proposed change only when the requested judgment requires it.

Keep factual operation, proposed design, adoption, and implementation status distinguishable wherever confusion would affect a decision. This is an evidence rule, not a reason to create parallel document sections. Do not create a document-wide `Conclusion` or `Key Decisions` chapter by default. An executive summary may index conclusions already stated in the Overall Design and Key Designs, but cannot replace them.

## Information Before the Design

Near the title, include only information needed to interpret the artifact. Show design status and its basis only when the artifact proposes a route. State implementation status or a material evidence limitation only when it changes how the artifact may be used. Follow an existing version convention; otherwise omit version metadata and ceremonial fields.

Keep background to the purpose and boundary: the observable result, impact, preserved behavior, allowed degradation, scope, constraints, relevant starting conditions, and evidence limitations. Include only items that shape the judgment. Do not turn an implementation preference into a goal or repeat alternative analysis.

Show a next decision point only when an unresolved condition can change the overall route or blocks the next system judgment. Keep local assumptions, risks, and unresolved conditions with the design they affect.

## Overall Design

Lead with a paragraph that can independently state the solution or operating conclusion: what the system does, who collaborates, who owns the decisive facts and decisions, how the parts produce the observable result, the major change from the relevant starting state, and the governing limits. State only the elements applicable to the judgment; do not force a before-and-after comparison. Make clear when a described route is proposed rather than implemented.

Then trace one representative end-to-end flow using actual project objects and actions across initiation, facts, decisions, information or state changes, side effects, result handoffs, and cross-mechanism failure takeover. Separate two flows only when their difference explains a material change or evolution requirement. Make responsibility boundaries and dependency direction visible where they determine the result. State what each Key Design contributes and how the designs work together; leave internal rules, local alternatives, and detailed recovery to the owning Key Design.

Use one minimal relationship diagram when several responsibility boundaries are materially clearer visually. Add a flow, sequence, or state diagram after the corresponding prose when order, branching, state, recovery, or cutover determines the result. A diagram does not replace the operating conclusion, responsibility, or tradeoff.

## Key Designs

Put only the Key Designs established in `SKILL.md` in a dedicated chapter, and omit the chapter when no mechanism qualifies. Name each section after the business outcome or operating responsibility it owns, not a number, repository, module, interface, table, or implementation task.

Lead every section with a self-contained design judgment: the mechanism, owner, responsibility and change boundary, material contract and dependency direction, input from and result returned to the overall flow, observable result, and key limits. State evidenced gaps when they matter. For a proposed mechanism, include the inherited and new decisions that shape it and justify every lifecycle-expanding mechanism required by `SKILL.md`. Keep each consequential choice with its owning mechanism rather than duplicating it in a decision chapter.

After the opening, include only the facts and inputs, information authority, necessary state and handoffs, key branches, failure, and recovery needed to make the mechanism hold. For a consequential choice with a real alternative, state the strongest viable alternative, selection basis, cost bearer, and reconsideration condition. Do not manufacture comparisons for a constraint, fact, inevitable consequence, or interchangeable implementation. Other sections may reference the result and impact but must not repeat the internal rule.

## Evolution, Acceptance, and Unresolved Matters

Include evolution only when the proposed design changes an operating system and coexistence or transition affects correctness. Describe every necessary stage as a real operating state: responsibilities, reads and writes, compatibility boundary, cutover, rollback locations, irreversible points, and old-path exit. Do not add future phases, a roadmap, or compatibility for inactive consumers or uncommitted possibilities.

Include a dedicated Acceptance section when the artifact proposes a result that must be qualified. Organize it around a few end-to-end scenarios covering observable outcomes, preserved behavior, constraints, major risks, and required evidence. Reference Key Designs without repeating their mechanisms. A descriptive overview instead states its evidence boundary and material unresolved conditions where they affect the conclusion.

Keep an assumption, risk, or unresolved condition in its owning section with its impact and smallest confirmation method. Use a final Unresolved Matters section only for ownerless items that can change the overall route or next system judgment. Omit it when empty; when a mandatory template requires a consolidated list, use it only as an index.

## Revision Record

Record a revision only when an Overall or Key Design mechanism, responsibility boundary, or consequential design choice was added, removed, replaced, reassigned, or materially changed, including because of new evidence. Include its impact and basis. Do not record evidence corrections that leave the design unchanged, review or approval rounds, feedback history, evidence collection, editorial changes, or formatting. Omit the section for a first draft or when no substantive design revision exists. Use `修订记录` in Chinese and `Revision Record` in English unless a mandatory project template requires another title.

Use one compact table, following an existing project convention when available and inventing no identifiers:

| Design changed | Mechanism, responsibility, or choice changed | Impact | Basis and source |
| --- | --- | --- | --- |

Aggregate related changes and point to the owning design. State what the design now does, the affected outcomes or boundaries, and the change basis. The record does not prove a fact, adoption, or implementation and cannot be the only place where a design or unresolved condition appears. Do not output an empty table.

## Drafting Checks

**Check the skeleton.** Read only the Overall Design opening and representative flow, plus every Key Design title and opening paragraph. A reader must still be able to restate the whole system judgment, the outcome each design owns, the key responsibility boundaries, and the basis and status of consequential claims.

**Check support and ownership.** Every later paragraph, list, table, and diagram must prove, explain, or bound its section's opening judgment. Overall Design owns the global result, cross-mechanism constraints, and handoffs; Key Designs own their mechanisms; Evolution owns coexistence and exit. Move a material conclusion to the opening, move supporting content to its owner, or remove it. Do not argue the same rule, failure, or choice twice.

**Check system consistency.** Prose, diagrams, terminology, information, state, failures, acceptance, and evolution must describe the same system, including applicable conditional, parallel, and re-entry paths. Make responsibility, contracts and dependency direction, information authority, necessary state lifecycle, recovery, business-policy boundary, and lifecycle-expanding mechanism justification visible where they determine the result. Keep factual claims within evidence, make proposed mechanisms and implementation status unambiguous, and return missing design judgments to `SKILL.md`.

**Reconcile revisions.** For completion or rewrite, compare the artifact with the latest revision anchor, still-material existing content, the semantic change surface established during convergence, and the working change plan when used. Confirm that valid mechanisms and evidence were preserved, superseded machinery was removed, and every established semantic change is expressed consistently. Do not rederive a missing design change while drafting; return it to the stage that owns it. Keywords and a complete table of contents do not prove preservation.

Finally remove content that cannot change understanding of system operation, design judgment, evidence boundary, or the next decision. Keep depth proportional to the conclusion each concern can change. Do not let overdesign concerns, a favored quality attribute, or speculative long-term planning become the document's organizing thread, and do not remove complexity required by an established obligation merely to appear simpler. Use direct engineering language. Remove meta-commentary, disclaimers, empty transitions, repeated summaries, and unsupported qualifiers such as generic `may` or `might`; state the actual condition, evidence boundary, or unresolved item instead. Use lists for real enumerations, tables for actual comparisons, and diagrams only when they clarify a relationship. Include code, interface, test, and operational details only when they support system-level understanding or a design judgment.
