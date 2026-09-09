# Design Artifact Standard

Write for the people who must understand, choose, implement, or maintain this design. Use the user's language and established project terms. Respect an existing required format; otherwise choose a small structure that makes the operating idea and important choices clear. Do not organize the artifact around the Skill's process or give every module equal space.

## Overall Design

Open with the required result, the proposed approach, and the principal reason it fits. Include only background and constraints needed to understand the design. Keep proposed behavior distinguishable from current implementation where that distinction matters.

Establish enough overall context for the requested scope, then explain the details on which its result depends. Return from an important detail to its effect on the whole, especially when it changes another decision or assumption.

For a whole-system design, explain how the main mechanisms cooperate and trace a representative input or use to its visible result. Make the important responsibilities, information dependencies, and effects understandable. Use a relationship or flow diagram when it clarifies the mechanism. A module diagram or tool-call list alone cannot explain the decisive work.

For a local design, state its result and relationship to the adopted surrounding design, then develop that mechanism directly. Do not reconstruct the entire system merely to fill an overview structure.

## Key Mechanisms and Choices

Give a key design its own explanation when its internal choices materially determine the outcome or a major quality or cost. Name it for the problem or result it addresses. Open with the mechanism selected and the reason for that choice.

Explain how the relevant input becomes the result. Include the representation, operation, selection rule, interaction, or feedback that performs the decisive work, together with only the contracts and state needed to understand it. Use a worked case, diagram, decision table, or pseudocode when it makes the mechanism easier to inspect. No particular form is required.

Keep the strongest material alternative, selection basis, costs, and reconsideration condition beside the choice they explain. Describe research at the point where it supports or limits the mechanism; distinguish a source's method and evidence from the adaptation proposed here. A literature survey is not required unless requested.

Allocate detail by design significance. Preserve a difficult internal strategy even if it belongs to one module. Leave ordinary code organization and interchangeable implementation details to implementation.

## Conditions, Validation, and Change

Place assumptions and unresolved conditions with the affected design. State what they can change and what evidence or decision is needed. A final open-issues list is useful only for matters that affect the overall next step; omit an empty list.

Explain the few checks or experiments that can establish the important behavior or discriminate among remaining alternatives. Clearly distinguish actual results from proposed validation. Formal validity, intended meaning, and practical quality may require different evidence.

Include transition, compatibility, rollout, or recovery details only where an active obligation or the chosen mechanism makes them material. Use the existing owners and paths where they suffice. Do not add a roadmap for hypothetical requirements.

For revisions, make the current text internally consistent and preserve still-valid content. Use existing project conventions for status and change history when needed by the reader. Do not invent version identifiers, revision tables, or approval claims. A historical note cannot substitute for updating the design itself.

## Final Reading

Read the actual final artifact as its intended reader, using the text, diagrams, and cases present in it. For a local revision, include the affected passages and their dependencies; expand the reading if the change affects the overall argument. Resolve these questions proportionately to scope:

- Can the reader explain the whole or local result and how it is produced?
- Can the decisive behavior be applied to a concrete case without supplying an unstated strategy?
- Are the important choices, costs, evidence, and conditions understandable?
- Do the prose, diagrams, cases, and existing contracts describe a consistent design?

Remove repeated governance statements and text that adds no understanding. When a mechanism is missing, repair the design instead of adding a heading, responsibility declaration, or surrounding implementation detail.
