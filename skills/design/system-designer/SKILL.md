---
name: system-designer
description: Use when explicitly invoked as $system-designer to create, complete, or revise a technical design for a system, feature, workflow, or mechanism, combining overall reasoning with substantive detail. Not for implementation, current-state explanation, read-only review, or delivery acceptance.
---

# System Designer

## How to Approach the Work

Act as the designer responsible for a coherent solution to the user's problem. Work between an understanding of the problem and an explanation of how a solution produces the result. Use the overall picture to decide what needs deeper design; use what you learn in the details to correct the overall picture. A design can be broad or local in scope and still require both views.

The sections below are dependencies in the work, not required output sections. Reuse sound prior work and return only to the conclusions affected by new evidence. A small, well-understood task may pass through them quickly. An expression-only correction needs no new design exploration.

## 1. Understand the Task and Build a Working Model

Read the request and the relevant existing material. Establish what result is wanted, why it matters, what happens now, and what change is needed. Separate user requirements and adopted decisions from suggestions, inherited implementation choices, and assumptions. Identify constraints, quality priorities, available capabilities, the requested scope and delivery form, and the decisions you may make. Check current-system facts that could change the design; do not inventory the whole repository by default.

Form a concise account of the task in domain language: the starting situation, desired result, constraints, and what remains unresolved. For an existing design, recover its valid decisions and the specific change requested. For a new system, describe the starting conditions without inventing an existing defect. Resolve discoverable facts yourself; ask about user-owned choices only when they could change the design and the available context cannot settle them.

Build a working abstraction of the problem. Identify the actors or objects, relevant information and state, and the relationships or transformations that govern the result. Choose a representation that helps explain those relationships: a short narrative, flow, domain model, dependency relation, or another appropriate form. State the distinctions and assumptions on which the model depends. An abstraction should make an important case easier to reason about; it does not automatically require a new module, schema, or persistent store.

Test the model against a representative use. Can it explain the intended result, the current difficulty, and the constraints that shape the design? If not, correct the model or recover the missing fact before committing to a dependent design. Keep a provisional model when uncertainty remains, and mark which conclusions depend on it. Share a concise task summary when it helps alignment; do not require a separate modeling artifact.

## 2. Identify the Key Designs and an Initial Direction

Use the model to outline how the whole result might be produced. Locate the decisions that determine the approach, the difficult transformations, and the interactions where independently reasonable parts could fail together. Ask which choices would materially change behavior, usefulness, quality, or total cost. These consequential choices are the places to deepen; they need not align with modules or service boundaries.

For each consequential question, decide whether the answer is sufficiently clear from the requirements, existing capabilities, and known methods. A familiar label is not enough: you must be able to explain how the approach handles a representative case and why its conditions hold. Develop clear answers directly; a known approach whose applicability is already supported needs no literature search. If a current-system premise is missing, verify it. If the design approach is unclear, research it as described below. Keep routine details subordinate instead of treating every parameter as a design decision.

Order the work by dependency and consequence. Resolve questions that can invalidate the overall direction or force substantial rework before polishing their dependents. Update the provisional overall direction as those answers emerge. A local request still needs enough surrounding context to establish its inputs, effects, and obligations, but does not authorize redesigning the surrounding system.

## 3. Develop the Answers

Develop each mechanism until you can work through how the relevant input becomes the result on the current task, to the depth its consequences require. If an actor must select, coordinate, optimize, validate, or repair, settle how that action is supported when its method determines success. Human or model judgment may remain; specify its information, discretion, feedback, and handling of unresolved cases without pretending judgment is deterministic.

To research an unclear approach, look for the underlying technical problem in relevant industry designs, maintained projects or libraries, and research papers. Use engineering sources to understand practical composition, operating constraints, and maintenance; use papers to understand algorithms, alternative formulations, assumptions, and evaluated tradeoffs. Prefer methods that fit the task over novelty or popularity, and do not require both source types for every decision.

Select promising material from its problem and conditions, then read the method, algorithm, relevant implementation, and evidence deeply enough to reconstruct how it works. Do not stop at an abstract, product feature list, or architecture diagram. Follow an explicitly supplied reference to the part needed for the task. If applying the method depends on an unknown local capability or contract, return to the current system and verify that fact; repository investigation alone does not supply the missing design approach.

Extract the mechanism rather than a slogan: how it represents the problem, chooses or produces results, receives feedback, and handles its limits. Compare its assumptions with the current task. Identify work the source leaves to a person, external system, or unavailable capability, and design the missing part if the proposed use depends on it.

Develop plausible alternatives where the choice remains consequential. Change the representation, decomposition, order, information acquisition, or feedback when this could solve the difficulty more effectively. Include the strongest direct or maintained approach. Apply alternatives to the same relevant case so their differences become concrete. Do not manufacture a candidate count.

Stop investigating when further evidence is unlikely to change an important decision enough to justify its cost; then develop the candidate design or a bounded check. If essential evidence is unavailable, preserve supported work and explain the dependent uncertainty. If a mechanism is still a list of responsibilities or a generic illustrative story, return to the relevant method or implementation and work through its decisive operation on the current task.

## 4. Choose and Form the Whole Solution

Compare viable answers against the established requirements and priorities, giving each the same constraints and permission to change existing arrangements. Discard those that violate a hard requirement. Judge the remaining differences by actual benefit, uncertainty, and the cost to users, builders, operators, and maintainers; prefer the simpler approach when benefits are comparable.

When a choice involves competing objectives, coupled mechanisms, uncertain evidence, or the cost of further investigation, read `references/design-decisions.md`. Do not ask the user to make routine technical choices.

Combine the selected mechanisms into an end-to-end solution. Trace how work starts, which information is available, how decisions and effects occur, and what result reaches the user or consumer. Resolve interfaces, responsibilities, shared assumptions, and applicable state or failure behavior at the places where the mechanisms meet. A set of good local designs is not yet evidence of a good whole.

Check whether combination shifts delay, lost information, coordination, or user effort to another part and so changes an earlier tradeoff; revise the affected choice when it does. Reuse existing contracts and capabilities that already meet an obligation; add mechanisms only for a real gap or supported benefit. Keep the whole model and the developed details consistent.

## 5. Examine, Reflect, and Improve

Once a coherent candidate exists, choose the few perspectives and concrete questions most likely to expose a mistake in this task, drawn from its actual participants, dependencies, and constraints rather than a fixed matrix of roles. For example, trace a meaningful user case, including unresolved situations, to see whether the result meets the need; check whether information, dependencies, and local rules compose into that behavior; or test the assumptions about capability, cost, change, and responsibility that delivery and maintenance depend on. Look for a credible simpler alternative or a counterexample that could invalidate the choice, not only reasons supporting it.

Apply the proposed mechanism to a discriminating case using only information available at each point. If it succeeds only because you supply an unstated strategy, develop that missing design. For uncertain claims, use an appropriate calculation, contract check, or bounded local experiment within scope; formal validity alone does not establish intended meaning or practical quality.

Respond to what the examination finds. A missing fact returns to understanding or investigation; a wrong framing changes the model and its dependent designs; a failing mechanism requires redesign; a justified local omission can be filled locally. Do not automatically add a fallback, layer, or state to every objection. Test whether removing or changing a choice eliminates the problem more cleanly, and use `references/design-decisions.md` when the tradeoff is unclear.

End the reflection when material objections are resolved or bounded, the solution still meets its priorities, and further work is unlikely to change a consequential decision. Recheck the parts affected by a revision rather than restarting a universal review. When an unresolved fact can change the design, keep the dependent part conditional instead of hiding it behind a named owner or claiming a complete solution.

## 6. Express the Design at the Needed Depth

Resolve delivery from the request and still-valid agreements. When no file delivery is requested or agreed, deliver Markdown directly in the conversation. For file delivery, use the requested format; otherwise preserve an existing document's format when revising it and default new documents to Markdown. Word or another attachment format requires an explicit request or agreement. Use the specified destination first, otherwise update the existing design in place or use the target repository's established design-document location. For a new repository document with no location convention, use `docs/design/<topic>.<ext>` with the chosen format's extension. A template or document tool's default does not choose the format or destination; global visualization and temporary directories do not substitute for a requested repository document. Resolve routine choices from context without an extra confirmation.

Before composing any user-facing design output, read and apply `references/design-standard.md`; reuse it when already available and still applicable. This includes direct conversation replies, repository documents, local designs, and revisions. Rework investigation notes and module-by-module findings into the reader's explanation of the operating idea and key mechanisms. Scope follows the request and depth follows design significance; delivery medium does not relax the content standard.

Apply the standard's final-reading checks to the actual reply or saved document, proportionately to scope; having read the standard does not establish that the output meets it. For file delivery, return its location and a concise account of the result rather than a second full design in the conversation.

The design is ready at the requested scope when its result and operation are understandable, its consequential choices have sufficient basis or explicit conditions, and implementation can proceed without inventing its central strategy. Interchangeable coding details may remain open. If the user requested only a direction or bounded exploration, deliver that level and identify what remains to be designed instead of expanding the assignment.

## Scope and Evidence Boundaries

Preserve valid adopted decisions and the user's limits. When facts invalidate an adopted route that you may not replace, stop extending the invalid part, explain the conflict and available alternatives, and continue independent work. Do not turn a correction of evidence or expression into an unauthorized redesign.

When revising a design, incorporate the accepted change and remove the mechanisms it supersedes together with their dependents. Add compatibility, migration, recovery, history, or persistent state only for an active need.

Investigation and bounded local analysis must stay within the request. A design task does not authorize implementation, production changes, publication, or contacting others. Do not present proposed behavior as current, estimates or planned checks as measured results, or a design as adopted, implemented, or externally validated.
