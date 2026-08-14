# System Overview Design Drafting Standard

Use this standard only to organize judgments completed in `SKILL.md`. Do not decide the goal, route, key-design eligibility, ownership, state, or failure semantics while drafting. Return an exposed gap to the stage that owns it instead of inventing a mechanism through document structure.

Write in the language the user requests; otherwise follow the primary language of the current request. Preserve established project terms, identifiers, code symbols, interface names, and quoted contracts unless translation is requested. Treat reasoning terms in `SKILL.md` as concepts, not required vocabulary: describe the concrete project owner, rule, state, boundary, and failure behavior instead of forcing labels such as “authority,” “invariant,” or “material state” into the prose.

## Select the Document Mode

Use a current-state overview to explain an existing system. Cover the understanding goal, scope and evidence boundary, overall operation, key designs, and only material current conflicts or evidence gaps. Do not add target proposals, future migration, or acceptance sections.

Use a target design to describe a system-level change. Cover the goals, scope and constraints, overall design, key designs, applicable evolution and compatibility, acceptance, and only material unresolved matters. Adapt section names to project language, but do not organize the document around modules, files, implementation tasks, or investigation steps.

Do not create a document-wide “Conclusion” or “Key Decisions” chapter by default. An executive summary may index conclusions already established in the Overall Design and each Key Design, but cannot be their only location. When a project template requires a decision list, index each choice and its owning design.

## Information Before the Design

Near the title, include only information readers need to interpret the document. For a target design, show the design status determined in `SKILL.md` and the basis when confirmed. State implementation status or a material evidence limitation only when it changes how the document may be used. Follow an existing design-version convention; otherwise omit version metadata.

Show a next decision point only when an unresolved condition changes the overall route or blocks the next design decision. Keep local conditions with their owning design. Do not re-decide status during drafting or add empty and ceremonial fields.

Keep background to what establishes purpose and boundary. For a current-state overview, state the behavior to understand, scope, and evidence boundary. For a target design, state the observable outcomes to change, impact, preserved behavior, allowed degradation, scope, and constraints. Do not turn an implementation preference into a goal.

Preserve the fact, constraint, inherited decision, new choice, consequence, assumption, risk, and unresolved-condition categories established in `SKILL.md`. Identify a source only as precisely as needed to judge a conclusion's strength. Do not repeat alternative analysis here.

## Overall Design

Lead with a paragraph that can independently restate the operating model. In current-state mode, explain who collaborates, who owns key facts and decisions, and how the result is produced and handed off. In target-design mode, explain the selected overall approach, its main changes from the current system, and how they jointly achieve the goal.

Then trace one representative end-to-end flow using actual project objects and actions across initiation, facts, decisions, state, side effects, outcome handoff, and cross-mechanism failure takeover. Make responsibility boundaries and dependency direction visible where they determine the flow. State what each key design delivers, how the designs produce the result together, and the global constraints; leave internal mechanisms, local alternatives, and detailed recovery to their owning key designs.

Use one minimal relationship diagram when multiple responsibility boundaries are materially clearer visually. When the outcome depends on order, branches, state, recovery, or cutover, place a flow, sequence, or state diagram after the corresponding prose judgment. A diagram does not replace the operating outcome, responsibility, or tradeoff.

## Key Designs

Put the key-design skeleton formed in `SKILL.md` in a dedicated Key Designs chapter. Name sections after business outcomes or operating responsibilities, not numbers, repositories, modules, interfaces, tables, or implementation tasks.

Lead every section with a design that stands on its own: the mechanism, owner, responsibility and change boundary, material contract and dependency direction, input from and result returned to the overall flow, observable result, and key limits. In current-state mode, include only evidenced mechanisms and gaps material to the explanation; do not turn the section into a quality audit. In target-design mode, also state the new choices or inherited decisions shaping the mechanism and the evidenced gap served by a non-obvious mechanism or abstraction. Keep each choice with its mechanism rather than duplicating it in a decision chapter.

After the opening, include only facts and inputs, state and handoffs, key branches, failure, and recovery needed to make the mechanism hold. For a real tradeoff, state the viable alternative, basis, cost, and reconsideration condition; do not manufacture a comparison. Other sections may reference the result and impact but must not repeat the internal rule.

## Evolution, Acceptance, and Unresolved Matters

When a target changes an existing system, explain each evolution stage as a real operating state: old and new responsibilities, read and write relationships, compatibility and cutover, rollback locations, irreversible points, and old-path exit. Stage names and task lists are insufficient. Do not add future evolution to a current-state overview unless a confirmed migration is already part of current operation.

Give a target design a dedicated Acceptance section. Organize a few end-to-end scenarios around observable outcomes, preserved behavior, constraints, risks, and required evidence. Reference key designs without repeating their mechanisms. For a current-state overview, state evidence scope and unresolved conditions only.

Keep an assumption, risk, or unresolved condition that affects one design in its owning section, with its impact and smallest confirmation method. Use a final Unresolved Matters section only for items with no single owner that can change the overall route or next design decision. Omit the section when empty; when a template requires a consolidated list, use it only as an index.

## Revision Record

Record a revision only when `SKILL.md` establishes that an overall or key-design mechanism, or a decision shaping it, was added, removed, replaced, reassigned, or materially changed. Include its impact and basis. Do not record review or approval rounds, feedback history, evidence collection, editorial changes, or formatting. Omit the section for a first draft or when no substantive revision exists. Use “修订记录” in Chinese and “Revision Record” in English unless a mandatory project template requires another title.

Use one compact table, following an existing project convention when available and inventing no identifiers:

| Design changed | Mechanism or decision change | Impact | Basis and source |
| --- | --- | --- | --- |

Aggregate related changes and point to the owning design. State what the current design now does, the outcomes or boundaries affected, and the change basis. The record does not prove current facts, design confirmation, or implementation, and cannot be the only place where a design or unresolved condition appears. Do not output an empty table.

## Drafting Checks

Perform a skeleton check. Read only the opening paragraph and representative flow of the Overall Design, plus every Key Design title and opening paragraph. A reader must still be able to restate the whole operation, the outcome each design owns, and, for a target, the new or inherited choices shaping it. A current-state overview does not fail because historical rationale is unavailable.

Perform a supporting check. Every later paragraph, list, table, and diagram must prove, explain, or bound its section's opening design. Move a material judgment to the opening, move content to its owning section, or remove it. Do not introduce a route, mechanism, choice, or responsibility after the section that should have established it.

Check content ownership and structural expression. Overall Design owns only the global outcome chain, cross-mechanism constraints, and handoffs; Key Designs own local mechanisms; Evolution owns coexistence and exit. In current-state mode, match boundaries, dependencies, gaps, and coupling to evidence rather than a target standard. In target-design mode, make the established responsibility, material contract and dependency direction, state source and lifecycle, recovery path, business-policy boundary, and justification for non-obvious mechanisms visible where needed. Do not argue the same rule, failure, or choice twice. Prose, diagrams, terminology, state, failures, acceptance, and evolution must describe the same system, including conditional, parallel, and re-entry paths. Return missing judgments to `SKILL.md`.

Check evidence and status. Current-state claims must stay within the evidence. A target design must not read as deployed fact. Use the design status determined in `SKILL.md`, separate it from implementation status, and state genuine conditions rather than hiding them in vague qualifiers. Include a revision record only when substantive revisions exist.

For completion or rewrite work, compare the document with the existing content that still affects goals, responsibilities, contracts, mechanisms, decisions, failure, evolution, or acceptance, and with any working change plan. Confirm that restructuring preserves valid operation and gaps in current-state mode. In target-design mode, confirm that the semantic change surface covers applicable upstream facts and triggers, downstream contracts and consumers, state and data, trust and permissions, side effects, recovery, observability, deployment, migration, rollback, and acceptance. Keywords and a complete table of contents do not prove semantic preservation.

Finally remove content that does not change understanding of system operation, design judgment, evidence boundary, or the next design decision. Use project terminology and direct engineering language. Remove meta-commentary, disclaimers, empty transitions, repeated summaries, and unsupported qualifiers such as generic “may” or “might”; state the actual condition, evidence boundary, or unresolved item instead. Use lists for real enumerations, tables for actual comparisons, and diagrams only when they clarify a relationship. Include code, interface, test, and operational details only when they support system-level understanding or a design judgment.
