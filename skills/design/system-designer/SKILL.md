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

Identify the requested scope, delivery form, and decisions you own. Settle choices resolvable by engineering judgment, discoverable facts, or clear option dominance yourself—without padding dominated alternatives—and ask the user only when a design-changing decision requires user authority (unobtainable facts or genuine competing value or cost-risk tradeoffs). On an existing design, recover valid adopted decisions and the requested change; on a new system, state starting conditions without inventing an existing defect.

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
- **Research and method transfer (only when unclear or sources are supplied)**:
  - Favor task fit over novelty, using one sufficient source (engineering docs or papers); stop searching once evidence cannot change consequential choices.
  - Trace supplied sources to representation, mechanism, feedback, preconditions, and limits—never stop at titles, abstracts, or feature lists.
  - Supply local prerequisites borrowed methods leave to humans or missing capabilities, and explain rejected supplied/candidate methods.
  - Cite only sources actually read; if sources or key evidence are inaccessible, state limits, keep supported work, and bound uncertainty.

## 4. Compose, Falsify, and Simplify

- **Weigh tradeoffs and sensitivity**: Compare viable options under equal constraints and equal freedom to change non-obligatory parts. Discard options that violate hard requirements; if none works, widen the candidate space or revisit constraints rather than picking the least broken option. Judge viable choices by concrete benefit, workload and tail-error shape (not averages alone), reversibility, and lifecycle cost across users, builders, operators, and maintainers. Prefer the simpler option at similar benefit, and state the condition that would flip a close call without inventing numeric scores.
- **Close ownership, failure, and end-to-end budgets**: Trace execution from trigger through available information, decisions, and effects to the visible outcome. Keep each rule, state transition, and effect at the single boundary owning its invariant, reuse existing capabilities where they satisfy an obligation, and try local boundary adaptation before changing an external owner's contract. Where mechanisms meet, close:
  - multi-input or multi-representation precedence, combination, conflict rejection, and atomic effective outcome;
  - state lifecycle, non-retryable failure, retry, and recovery from **uncertain external effects** (timeouts, lost responses, or restarts after a side effect may have committed);
  - **end-to-end budgets**: response SLA vs. synchronous downstream timeouts and fan-out, retry windows vs. deduplication/idempotency TTLs, token or signed-URL expiry vs. consumption time, and input scale vs. payload, memory, or context limits.
  If composition merely relocates delay, polling, data loss, contention, or manual cleanup, revise the design.
- **Deletion test**: For every added dependency, queue, outbox, coordinator, cache, store, parallel path, or compatibility shim, identify which obligation breaks if it is removed in favor of existing capabilities and allowed failure semantics. If none breaks, delete it instead of hardening its internals.
- **Point-in-time witness falsification**: Stress-test the design from the standpoint of actual users, dependencies, failure modes, and maintainers rather than a fixed role checklist. Trace a **discriminating case**—scarce-resource contention, colliding hard constraints, concurrent same-revision writes, timeout/restart with uncertain effects, or ambiguous updates—using **only information available at each step**, supplying any missing strategy or reframing instead of stacking patches.
- **Bounded verification and open premises**: Check uncertain claims with bounded calculations, contract checks, or in-scope local probes (formal validity alone never proves domain fidelity). Re-verify only parts touched by revisions, and keep unresolved premises explicitly conditional rather than parked behind a named owner.

## 5. Deliver to Standard Within Scope

Write for the readers who decide, implement, or maintain the design, using the user's language and project terms. Reply in Markdown in chat unless file output is requested or agreed.

When saving to a file, write directly to the requested path—otherwise update an existing design in place or follow repository convention (`docs/design/<topic>.md` only for a new file with no convention)—without letting tool default or scratch directories override the target. Report the saved path and a brief summary in chat instead of repeating the full document.

Write **prose-first at the domain and contract level**, not as a code-patch plan. Even when source inspection, user notes, or review feedback cite concrete files, classes, or line numbers, use them to verify facts and translate the design into connected paragraphs explaining context, causal reasoning, mechanisms, invariants, and tradeoffs; reserve lists and compact tables for parallel dimensions, comparisons, or state/decision mappings. Anchor ownership on subsystems and governing contracts—omitting internal class/method chains, code statements, line numbers, per-file edit lists, and routine `interface`/`class` blocks, and using short code/DSL/schema excerpts only where prose would be ambiguous.

### Match Structure to the Request

Keep deliverables strictly within the requested scope:

- **User-specified structure or project template**: Follow it first while keeping background, overall solution, and key designs easy to find.
- **Complete design (system, feature, Agent/Harness, or local mechanism with consequential choices)**: Open after the title with a 2–4 sentence prose lead stating the chosen approach, target result, and any decision-changing condition, then follow the **Complete Design Outline** below (localized to the user's language). A complete local feature or mechanism design uses this outline at local scope without inventing whole-system architecture.
- **Short direction or simple local design**: Organize a requested short direction or bounded exploration to the requested depth (noting what remains open), and merge layers concisely for a simple local design with one operating path and no consequential choices to separate—omitting ceremonial sections in both cases.
- **Bounded revision of an existing design**: Preserve existing structure, headings, valid adopted decisions, and unaffected text. Rewrite affected prose to synthesize accepted changes and review fixes—retiring superseded paths and updating or removing affected dependents—without stacking parenthetical patches or turning a targeted fix into an unauthorized redesign. If verified facts invalidate an adopted route you may not replace, stop extending that part, state the conflict and viable options, and finish independent sections.

### Complete Design Outline

Present the three core sections first in this exact order:

1. **Background and Goals**: Starting situation (state starting conditions on greenfield work; technology preference alone is never a need), core problem or opportunity, target outcome and observable completion criteria, shaping constraints, explicit **non-goals / scope boundaries**, and decision-relevant current-vs-proposed differences.
2. **Overall Solution**: Open with the operating idea and primary selection reason.
   - Trace a representative input end-to-end in domain prose before schemas, prompts, or tables—never substituting a component/tool inventory; a diagram may complement, never replace, this trace.
   - Map pivotal choices to *Key Designs*, noting relied-on/changed contracts, dependent updates, and unmet-dependency impact.
   - For multi-module or staged designs, end with a brief subsystem boundary summary: shared contracts, independent subsystem responsibilities, prerequisites, and *Key Designs* references (subsystem topology and contracts, not a task plan).
3. **Key Designs**: Dedicate one subsection to each consequential mechanism:
   - State the chosen mechanism and why it fits, then trace how input becomes output—covering its operational strategy (Section 3), state and contracts, behavior-changing failure or uncertain-effect recovery, and a worked case, decision table, diagram, or pseudocode only where needed to expose hard internal strategy.
   - Beside each pivotal choice, record the strongest viable alternative, selection basis, accepted tradeoffs, source method vs. local adaptation, and reversal condition (Section 4), without inventing comparisons for routine details.

Append only the post-core sections below that carry non-repetitive substance for this task, keeping this relative order (keep local assumptions beside their mechanism, cross-reference *Key Designs* instead of repeating prose, and omit empty sections):

- **Validation and Acceptance** *(include when nontrivial)*: Discriminating checks, calculations, bounded probes, or behavioral evals covering risky assumptions, boundary/failure recovery, and domain fidelity vs. structural validity. Separate verified facts from proposed checks.
- **Rollout, Migration, and Operations** *(include only for live replacement, state/contract evolution, uncertain external effects, or ongoing operational risk; omit on stateless greenfield local designs)*: Coexistence or cutover order, rollback boundary or forward recovery past irreversible steps, **explicit owner and removal condition** for any temporary compatibility or migration path, and essential signals, reconciliation hooks, or cost/capacity guardrails.
- **Risks and Open Decisions** *(include only when unresolved premises, external contract gates, or residual risks affect next steps)*: Open item, dependent design branch, and the evidence or owner decision that settles it.
- **Revision History** *(for cross-version document iterations or when established/requested; omit on initial drafts and chat replies unless requested)*: Preserve existing records and placement. Log concise cross-version entries (outside bounded passage edits) with verified metadata covering what changed, why, and affected mechanisms or contracts—never inventing versions, dates, authors, or approvals, and never substituting changelog notes for updating the main text.
- **Appendix** *(optional — always last, after Revision History when both appear)*: External/wire schemas, complete DSL/config examples, verbatim prompt or tool templates, exhaustive state/check matrices, or read-source indexes needed for completeness without cluttering *Overall Solution* or *Key Designs*.

### Scope Boundaries and Final Reading

Design work never authorizes code changes, live mutations, publication, or external outreach. Never present proposed behavior as current, estimates or planned checks as measured results, or a proposal as adopted, implemented, or externally validated; omit trailing boilerplate disclaimers.

Before returning, read the finished reply or saved file as its target audience to confirm it fits the requested scope and structure, prose leads cleanly under Section 5 without unstated strategy or empty/repetitive sections, and prose, contracts, diagrams, and examples agree. Fix any gap in place.
