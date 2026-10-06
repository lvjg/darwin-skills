# Design Output Standard

Apply this standard to the design itself, whether delivered directly in the conversation or as a document, and whether it is a complete proposal, a local design, or a revision. A short direction needs only enough mechanism and reasoning to support the requested decision; a complete design must not collapse into a list of recommendations. Do not expand a bounded request to fill sections.

Write for the people who must understand, choose, implement, or maintain this design, using the user's language and established project terms. Make its background and goals, overall solution, and key designs recognizable and connected in the actual explanation. Respect the user's required structure; otherwise choose a small structure, allowing these content layers to share a section. They are not mandatory headings. Do not organize the output around the Skill's process or give every module equal space. Delivery format and location follow the main Skill's delivery rules.

## Overall Design

Open with the problem and intended result, what counts as completion, the proposed approach, and the principal reason it fits. Develop only the background and material constraints needed to understand that choice. The merits of a preferred technology do not establish the need. Keep proposed behavior distinguishable from current implementation where that distinction matters.

Establish enough overall context for the requested scope, then explain the details on which its result depends. Return from an important detail to its effect on the whole, especially when it changes another decision or assumption.

For a whole-system design, explain how the main mechanisms cooperate and trace a representative input or use to its visible result. Make the important responsibilities, information dependencies, and effects understandable. Use a relationship or flow diagram when it clarifies the mechanism. A module diagram or tool-call list alone cannot explain the decisive work.

For a local design, state its result and relationship to the adopted surrounding design, then develop that mechanism directly. Do not reconstruct the entire system merely to fill an overview structure.

## Key Mechanisms and Choices

Give a key design its own explanation when its internal choices materially determine the outcome or a major quality or cost. Name it for the problem or result it addresses. Open with the mechanism selected and the reason for that choice.

Explain how the relevant input becomes the result. Include the representation, operation, selection rule, interaction, or feedback that performs the decisive work, together with only the contracts and state needed to understand it. Interfaces, named owners, and statements of required behavior do not replace this strategy. Use a worked case, diagram, decision table, or pseudocode when it makes the mechanism easier to inspect. No particular form is required.

Keep the strongest material alternative, selection basis, costs, and reconsideration condition beside the choice they explain. Describe research at the point where it supports or limits the mechanism; distinguish a source's method and evidence from the adaptation proposed here. A literature survey is not required unless requested.

Allocate detail by design significance. Preserve a difficult internal strategy even if it belongs to one module. Leave ordinary code organization and interchangeable implementation details to implementation.

## Conditions, Validation, and Change

Place assumptions and unresolved conditions with the affected design. State what they can change and what evidence or decision is needed. A final open-issues list is useful only for matters that affect the overall next step; omit an empty list.

Explain the few checks or experiments that can establish the important behavior or discriminate among remaining alternatives. Clearly distinguish actual results from proposed validation. Formal validity, intended meaning, and practical quality may require different evidence.

Include transition, compatibility, rollout, or recovery details only where an active obligation or the chosen mechanism makes them material. Use the existing owners and paths where they suffice. Do not add a roadmap for hypothetical requirements.

For revisions, make the current text internally consistent and preserve still-valid content. Use existing project conventions for status and change history when needed by the reader. Do not invent version identifiers, revision tables, or approval claims. A historical note cannot substitute for updating the design itself.

## Final Reading

Read the actual final reply or saved document as its intended reader, using the text, diagrams, and cases present in it. For a local revision, include the affected passages and their dependencies; expand the reading if the change affects the overall argument. Resolve these questions proportionately to scope:

- From the opening and relevant body, can the reader identify the problem, intended result, material constraints and completion criteria, explain the whole or local operating idea, and understand why its key mechanisms matter?
- Can the decisive mechanisms be applied to concrete material without supplying an unstated strategy? Are the selection basis, strongest material alternative, accepted costs, evidence, and conditions understandable beside the choices they explain?
- Do the mechanisms compose into the intended result using information available at each point, with important state, action and failure behavior resolved? Do the prose, diagrams, cases, and existing contracts describe that same design?

Remove repeated governance statements and text that adds no understanding. When a mechanism is missing, repair the design instead of adding a heading, responsibility declaration, or surrounding implementation detail.
