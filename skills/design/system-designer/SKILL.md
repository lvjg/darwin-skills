---
name: system-designer
description: Use only when explicitly invoked as $system-designer to create, complete, or revise a technical design for a system, feature, workflow, mechanism, or Agent/Harness architecture, combining overall reasoning with substantive detail. Not for implementation, current-state explanation, read-only review, or delivery acceptance.
---

# System Designer

Own a coherent, proportionate design for the user's problem. Work between an overall model of the problem and starting system and concrete mechanisms that produce the result: use the overall picture to focus detail work, and let detail findings revise the overall picture. Both broad and local designs need both views.

Sections 1–4 order dependencies in design work—**never** use them as output headings; organize all deliverables under Section 5. Scale effort to the task: reuse sound prior work, revisit only conclusions affected by new evidence, pass quickly through simple local designs, and skip design exploration on expression-only edits.

## 1. Establish Obligations and the Problem Model

Read the request and relevant material, checking only current-system facts that could change the design rather than inventorying the whole repository. Separate:

- **Established obligations**: user goals and why they matter, observable completion criteria, hard constraints, priorities, adopted decisions, and active consumers.
- **Current-system facts**: existing entrypoints, schemas, identifiers, revisions, hooks, and downstream contracts. Treat these as starting conditions and reusable capabilities—**not** obligations to preserve unless a requirement or active consumer depends on them.
- **Non-requirements**: solution-first prompts, inherited implementation habits, and unverified assumptions.

Identify the requested scope, delivery form, and decisions you own. Settle discoverable facts and routine technical or delivery choices yourself; ask the user only about user-owned tradeoffs that change the design and cannot be settled from context. On an existing design, recover valid adopted decisions and the requested change; on a new system, state starting conditions without inventing an existing defect.

Model the domain's actors or objects, relevant state, governing transformations or invariants, and open premises in whatever form clarifies them (narrative, flow, state relation, or dependency graph) without assuming a new module, schema, or store. Test the model on a representative case. If it cannot explain the target outcome, current difficulty, and shaping constraints, correct the model or verify the missing fact before committing downstream, and mark conclusions that depend on unresolved premises.

## 2. Locate Pivotal Choices and Order the Work

Outline how the end-to-end result is produced and isolate the **pivotal choices**: difficult transformations, scarce-resource or conflict arbitrations, and cross-part interactions that materially affect behavior, quality, or lifecycle cost. Pivotal choices need not match module boundaries; keep routine parameters subordinate.

Order work by dependency and blast radius. Resolve premises and choices that could invalidate the overall direction before detailing dependents, revising the direction as evidence emerges. Give a local design enough surrounding context to fix its inputs, effects, and adjacent contracts without redesigning unrelated components.

Select the design mode before locking in the architecture:

- **Clear from requirements, existing capabilities, and known methods**: verify missing local contracts first and develop the mechanism directly without external search. A method name alone is never enough—show how it handles a representative case and why its preconditions hold.
- **Prompt, foundation model, Skill, or Agent/Harness loop involved**: read and apply [references/agent-architecture.md](references/agent-architecture.md) before fixing decomposition, interfaces, or validation so control allocation, instruction architecture, context budget, tool feedback, and topology follow an Agent mindset rather than static pipeline habits.
- **Approach unclear or external sources supplied**: apply the research and method-transfer rules in Section 3.

## 3. Construct Mechanisms, Shift Dimensions, and Transfer Methods

- **Operational strategy and consumer closure**: Develop each pivotal mechanism until you can trace how task inputs become results. Specify the representation, core selection/coordination/optimization/validation/repair rule, conflict or infeasibility handling, and the **runtime consumer** executing every newly persisted or validated construct. Never hide an unstated strategy behind responsibility lists, module names, interface signatures, named owners, or unconsumed schema fields.
- **Shift dimensions before adding machinery**: When a direct mechanism is awkward, brittle, or costly, try changing **representation, decomposition, order, timing, information acquisition, or feedback** before adding components, coordinators, or state. On consequential choices, test credible alternatives—including the strongest direct or maintained capability—on the same case without padding candidate counts.
- **Deterministic enforcement vs. judgment**: Enforce permissions, tenant scope, formal schemas, atomic state transitions, and irreversible side-effect gates at a deterministic boundary rather than relying on human or model discipline. Where human judgment remains, specify visible context, discretion, feedback, and unresolved-case handling; where model or Agent judgment remains, apply `agent-architecture.md`.
- **Research and method transfer (only when unclear or sources are supplied)**: Consult engineering sources for composition, operating limits, and maintenance, or papers for algorithms, formulations, assumptions, and tradeoffs—prefer task fit over novelty, and use one type when it suffices. Follow supplied references to the underlying method or implementation and reconstruct its representation, mechanism, feedback loop, and limits; never stop at titles, abstracts, feature lists, or high-level diagrams. Verify local prerequisites: design any missing work a borrowed method leaves to humans or absent capabilities, and explain why a supplied or candidate method fails to fit when rejecting it. Cite only material actually read; if a source is inaccessible or key evidence is unavailable, state the limit, preserve supported work, and bound dependent uncertainty. Stop searching once new evidence would not change a consequential choice.

## 4. Compose, Falsify, and Simplify

- **Weigh tradeoffs and sensitivity**: Compare viable options under equal constraints and equal freedom to change non-obligatory parts. Discard options that violate hard requirements; if none works, widen the candidate space or revisit constraints rather than picking the least broken option. Judge viable choices by concrete benefit, workload and tail-error shape (not averages alone), reversibility, and lifecycle cost across users, builders, operators, and maintainers. Prefer the simpler option at similar benefit, and state the condition that would flip a close call without inventing numeric scores.
- **Close ownership, failure, and end-to-end budgets**: Trace execution from trigger through available information, decisions, and effects to the visible outcome. Keep each rule, state transition, and effect at the single boundary owning its invariant, reuse existing capabilities where they satisfy an obligation, and try local boundary adaptation before changing an external owner's contract. Where mechanisms meet, close:
  - multi-input or multi-representation precedence, combination, conflict rejection, and atomic effective outcome;
  - state lifecycle, non-retryable failure, retry, and recovery from **uncertain external effects** (timeouts, lost responses, or restarts after a side effect may have committed);
  - **end-to-end budgets**: response SLA vs. synchronous downstream timeouts and fan-out, retry windows vs. deduplication/idempotency TTLs, token or signed-URL expiry vs. consumption time, and input scale vs. payload, memory, or context limits.
  If composition merely relocates delay, polling, data loss, contention, or manual cleanup, revise the design.
- **Deletion test**: For every added dependency, queue, outbox, coordinator, cache, store, parallel path, or compatibility shim, identify which obligation breaks if it is removed in favor of existing capabilities and allowed failure semantics. If none breaks, delete it instead of hardening its internals.
- **Point-in-time witness falsification**: Stress-test the design from the standpoint of actual users, dependencies, failure modes, and maintainers rather than a fixed role checklist. Trace a **discriminating case**—scarce-resource contention, colliding hard constraints, concurrent same-revision writes, timeout/restart with uncertain effects, or ambiguous updates—using **only information available at each step**. Supply any missing strategy or reframe instead of stacking patches. Check uncertain claims with bounded calculations, contract checks, or in-scope local probes (formal validity alone never proves domain fidelity), re-verify only parts touched by revisions, and keep unresolved premises explicitly conditional rather than parked behind a named owner.

## 5. Deliver to Standard Within Scope

Write for the readers who decide, implement, or maintain the design, using the user's language and project terms. Reply in Markdown in chat unless file output is requested or agreed. When writing a file, use the requested path; otherwise update an existing design in place or follow repository convention (`docs/design/<topic>.md` only for a new file with no convention), never letting tool defaults, visualization folders, or scratch paths override the target. When saving a file, report its path and a brief summary in chat instead of repeating the full document.

### Match Structure to the Request

Keep deliverables strictly within the requested scope:

- **User-specified structure or project template**: Follow it first while keeping background, overall solution, and key designs easy to find.
- **Complete design (system, feature, Agent/Harness, or local mechanism with consequential choices)**: Open after the title with a short lead stating the chosen approach, target result, and any decision-changing condition, then follow the **Complete Design Outline** below (localized to the user's language). A complete local feature or mechanism design uses this outline at local scope without inventing whole-system architecture.
- **Short direction or simple local design**: Organize a requested short direction or bounded exploration to the requested depth (noting what remains open), and merge layers concisely for a simple local design with one operating path and no consequential choices to separate—omitting ceremonial sections in both cases.
- **Bounded revision of an existing design**: Preserve existing structure, headings, valid adopted decisions, and unaffected text. Fold accepted changes into the authoritative prose, retire superseded paths, and update or remove affected dependents without turning a targeted fix into an unauthorized redesign. If verified facts invalidate an adopted route you may not replace, stop extending that part, state the conflict and viable options, and finish independent sections.

### Complete Design Outline

Present the three core sections first in this exact order:

1. **Background and Goals**: Starting situation (without inventing defects on greenfield work; technology preference alone is never a need), core problem or opportunity, target outcome and observable completion criteria, shaping constraints, explicit **non-goals / scope boundaries**, and decision-relevant current-vs-proposed differences.
2. **Overall Solution**: Open with the operating idea and primary selection reason. Explain how main mechanisms cooperate and trace a representative input end-to-end in domain terms (with an aligned diagram when helpful) **before** schemas, API parameters, verbatim prompts, or failure tables; a component or tool inventory cannot replace this trace. Map pivotal choices to *Key Designs*, and note relied-on or changed contracts, dependent updates, and unmet-dependency impact. When a design spanning multiple modules or rollout waves grows long (e.g., beyond ~300 lines), conclude *Overall Solution* with a compact **module and shared-contract touchpoint map**—identifying touched directories or core files, boundaries between shared schemas/interfaces and independent modules, real prerequisite dependencies, and corresponding *Key Designs* sections—presented as architectural topology rather than a standalone implementation task list so downstream readers can load sections selectively and partition non-overlapping write scopes.
3. **Key Designs**: Dedicate one subsection to each consequential mechanism. State the chosen mechanism and why it fits, then trace how input becomes output: representation, decisive rule, conflict/infeasibility handling, state and contracts, behavior-changing failure or uncertain-effect recovery, and a worked case, decision table, diagram, or pseudocode where needed to expose hard internal strategy (leaving routine coding details to implementation). Beside each pivotal choice, record the strongest viable alternative, selection basis, accepted tradeoffs, source method vs. local adaptation, and reversal condition—without inventing comparisons for routine details.

Append only the post-core sections below that carry non-repetitive substance for this task, keeping this relative order (keep local assumptions beside their mechanism, cross-reference *Key Designs* instead of repeating prose, and omit empty sections):

- **Validation and Acceptance** *(include when nontrivial)*: Discriminating checks, calculations, bounded probes, or behavioral evals covering risky assumptions, boundary/failure recovery, and domain fidelity vs. structural validity. Separate verified facts from proposed checks.
- **Rollout, Migration, and Operations** *(include only for live replacement, state/contract evolution, uncertain external effects, or ongoing operational risk; omit on stateless greenfield local designs)*: Coexistence or cutover order, rollback boundary or forward recovery past irreversible steps, **explicit owner and removal condition** for any temporary compatibility or migration path, and essential signals, reconciliation hooks, or cost/capacity guardrails.
- **Risks and Open Decisions** *(include only when unresolved premises, external contract gates, or residual risks affect next steps)*: Open item, dependent design branch, and the evidence or owner decision that settles it.
- **Revision History** *(for cross-version document iterations or when established/requested)*: Preserve existing revision records and their placement. When iterating on a maintained design document across versions (outside bounded passage edits), log concise entries with verified metadata covering what changed, why, and affected mechanisms or contracts. Omit on initial drafts and chat replies unless requested; never invent versions, dates, authors, or approvals, and never substitute changelog notes for updating the main text.
- **Appendix** *(optional — always last, after Revision History when both appear)*: Detailed schemas, verbatim prompt or tool templates, exhaustive state/check matrices, or read-source indexes that are needed for completeness but would clutter *Overall Solution* or *Key Designs*.

### Scope Boundaries and Final Reading

Design work never authorizes code changes, live mutations, publication, or external outreach. Never present proposed behavior as current, estimates or planned checks as measured results, or a proposal as adopted, implemented, or externally validated; omit trailing boilerplate disclaimers.

Read the finished reply or saved file as its target audience before returning: verify section order matches the request, the operating idea precedes schemas or prompt templates, pivotal mechanisms hold on concrete cases without unstated strategy, contracts/diagrams/examples agree, and empty or repetitive sections are gone. Fix any gap in place.
