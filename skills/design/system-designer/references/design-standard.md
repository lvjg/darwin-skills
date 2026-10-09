# Design Output Standard

Apply this standard to the design itself, whether delivered in the conversation or as a document. Write for the people who must understand, choose, implement, or maintain the design, using the user's language and established project terms. Delivery format and location follow the main Skill's rules.

## Required Structure and Scope

For a complete design, use these three explicit top-level sections in this order: **Background and Goals**, **Overall Solution**, and **Key Designs**. Translate these headings into the user's language while preserving their meaning. Keep these layers separate rather than scattering their contents across topic sections. A complete proposal for one feature or mechanism uses the same structure at that scope; it does not require a whole-system architecture.

The user's required structure or an agreed project template takes precedence. Fit the content into that structure and make the three layers easy to locate. For a bounded revision, preserve the existing structure and unaffected text; update the affected explanation and its dependencies. For a short direction or a simple local design with one operating path and no consequential choices to develop separately, the layers may be combined. A request for a complete proposal, or a design combining several consequential mechanisms, keeps the three sections even when the answer is short. Keep each structure within the requested scope.

For a complete design, follow the title with a short lead stating the proposed approach, intended result, and any condition that changes the decision. Develop the explanation in the sections below. Do not organize the design around investigation steps or give every module equal space.

Keep information specific to a mechanism or choice beside it. Add supplementary sections after the three core sections when they serve a distinct purpose across mechanisms or support a design decision, implementation, validation, or maintenance. For information spanning several mechanisms, summarize shared effects, dependencies, and required actions with references to the affected key designs rather than repeating their explanations. Omit sections without substantive content. Existing structure and agreed templates follow the scope rules above.

## Background and Goals

Explain the starting situation, the problem or opportunity, and the result the design must produce. Include the constraints that shape the choice and observable completion criteria. For a new system, describe its starting conditions without inventing an existing defect. The merits of a preferred technology do not establish the need.

Give only the context needed to understand the proposal. Distinguish requirements and adopted decisions from inherited implementation choices or assumptions. Keep proposed behavior distinguishable from current implementation where that affects the reader's decision.

## Overall Solution

State the operating idea and its principal selection reason before detailing its parts. Explain how the main mechanisms cooperate: where work starts, what information is available, how decisions and effects occur, and what result reaches the user or consumer. Make the responsibilities and dependencies understandable in domain language.

Trace a representative input or use through this path. Use a relationship or flow diagram when it clarifies the cooperation, with names consistent with the prose. The reader should understand the path without first studying schemas, API parameters, or failure-state tables. A component inventory or tool-call list cannot supply this explanation.

Identify the few choices that determine the result and point to their explanations under Key Designs. Explain how they affect other choices and any modules or consumers that depend on them. Identify the capabilities or contracts relied on or changed, required dependent adjustments, and consequences of unmet dependencies where they affect the result. For a local proposal, show its input, result, and relationship to the surrounding design; do not reconstruct unrelated parts of the system.

## Key Designs

Give each consequential mechanism a subsection named for the problem or result it addresses. Open with the chosen mechanism and why it fits, then explain how its relevant input becomes the result. Include the representation, operation, selection rule, interaction, or feedback that performs the decisive work, together with the contracts and state needed to understand and implement it. Interfaces, named owners, and statements of required behavior do not replace this strategy.

Use a worked case, decision table, diagram, or pseudocode where it lets the reader inspect the decisive operation. Preserve a difficult internal strategy even if it belongs to one module, and explain how important details affect the overall result. Keep the decisive operation, selection rule, and behavior-changing failure conditions in the main explanation. Place supporting schemas, exhaustive check matrices, and source indexes in a referenced subsection or appendix only when they would interrupt that explanation. Leave ordinary code organization and interchangeable implementation details to implementation.

For consequential choices, keep the strongest viable alternative, selection basis, accepted costs, and reconsideration condition beside the choice they explain. Do not manufacture a comparison for a routine decision. Describe research where it supports or limits the mechanism, distinguishing the source's method and evidence from the adaptation proposed here.

## Conditions, Validation, and Change

Place assumptions and unresolved conditions with the affected design. State what they can change and what evidence or decision is needed. A final open-decisions section is useful only for matters that affect the overall next step; omit an empty one.

Explain the few checks or experiments that can establish important behavior or distinguish remaining alternatives. Clearly distinguish actual results from proposed validation. Formal validity, intended meaning, and practical quality may require different evidence.

Include transition, compatibility, rollout, or recovery details only where an active obligation or the chosen mechanism requires them.

For revisions, update the current explanation and preserve still-valid content. Keep it complete and authoritative; revision records cannot substitute for this update. Records are part of a maintained design artifact. Preserve existing entries and record substantive changes between delivered versions, within the requested scope. Use the existing format, or concise entries stating what changed, why, and which design or dependency is affected. Use actual revision metadata; do not invent past versions, authorship, or approval claims. An initial proposal needs no fabricated history or empty record section.

## Final Reading

Read the actual reply or saved document as its intended reader. For a local revision, include the affected passages and their dependencies; expand the reading if the change affects the overall argument. Check the applicable structure and the explanation separately:

- Does a complete design have the three explicit sections in order, or follow the user's required structure or agreed template? Is a short direction, simple local design, or bounded revision using its exception without omitting needed design or adding unrelated scope? Do supplementary sections serve a distinct purpose without repeating the core explanation? Headings alone do not establish content quality.
- Can a reader understand the problem, intended result, constraints, completion criteria, operating idea, and key choices from the background and overall explanation before reading implementation detail?
- Can the key mechanisms be applied to concrete material without supplying an unstated strategy? Are their reasons, alternatives, costs, evidence, and conditions understandable beside the choices?
- Do the mechanisms compose into the intended result using information available at each point, with important state, action, and failure behavior resolved? Are the current explanation, diagrams, cases, and applicable contracts consistent? Do applicable revision records accurately describe the actual changes?

Repair a missing mechanism in the design itself. Repair an unclear structure or explanation by reorganizing and rewriting the affected text. Remove repetition and bookkeeping that add no understanding; do not substitute extra headings, responsibility declarations, or implementation detail for the missing explanation.
