# Agent and Harness Architecture Design

Use this guide when a design employs a prompt, foundation model, Skill, or Agent/Harness loop to interpret open inputs, plan, call tools, generate domain artifacts, or coordinate work.

Deterministic software pre-compiles control branches, passes state without attention loss, exposes APIs read once by engineers, and relies on binary tests. In an Agent system, **you design a bounded cognitive environment—deterministic Harness guardrails, instruction architecture, working-memory context, tool/feedback ergonomics, and convergence bounds—around a probabilistic model so it exercises judgment where static code cannot while hard invariants stay deterministic**. Address the six dimensions below.

## 1. Allocate Control and Model Fit

- **Pick the lightest control structure matching runtime uncertainty**: Keep fixed rules, calculations, schemas, and known state transitions in deterministic code. Use a single structured model call or fixed workflow when the step sequence is known upfront; introduce an open Agent loop **only** when input ambiguity, runtime discovery, or iterative repair prevents static orchestration.
- **Avoid both control-allocation traps**: Reject *brittle pseudo-agency*—locking open reasoning into rigid prompt chains, fixed FSM states, or ceremonial `plan -> critique -> reflect` stages that break on out-of-order evidence. Equally reject *ungrounded autonomy*—relying on prompt obedience to enforce permissions, schema/compile validity, state invariants, or irreversible side-effect gates that belong in Harness code.
- **Right-size model tiers**: Route ambiguity resolution, complex planning, and cross-source synthesis to stronger models, and assign high-volume classification, extraction, or bounded search to lighter, lower-latency models where quality holds—counting retries and verification in total cost.

## 2. Design Behavioral Contracts and Instruction Architecture

- **Specify the behavioral contract before drafting prompts**: Define triggers, decisive inputs, domain invariants that must hold (quantifiers like `any` vs. `all`, conditional field dependencies, guidance vs. approval semantics), allowed output variance, and required handling of missing, ambiguous, or conflicting inputs (clarify, abstain, or mark drafts explicitly conditional rather than guessing silently).
- **Partition instructions by stability and trigger**: Avoid monolithic system prompts; separate four layers:
  - *Always-on core* (system/global rules): role, authority limits, universal invariants, and routing cues—kept brief because every turn pays its attention cost;
  - *Conditional playbooks* (Skills / on-demand docs): domain workflows loaded only when relevant;
  - *Tool-local contracts*: parameter constraints, preconditions, and return semantics attached to tool definitions rather than duplicated in system prompts;
  - *Delimited runtime context*: authoritative state, user input, and untrusted external text separated by explicit structural boundaries.
- **Calibrate instruction altitude**: State target outcomes, `condition -> action` criteria, conflict priorities, and true causal dependencies. Avoid vague slogans ("handle intent safely"), rigid step scripts where order is arbitrary, and stacked `"Do NOT"` patches that trigger over-refusal or leak defensive disclaimers into deliverables.
- **Use minimal contrastive examples and consumer-matched outputs**: Include short examples only where prose leaves a subtle boundary ambiguous, contrasting valid vs. near-miss invalid cases without inviting template mimicry. Emit enforced schemas or tool calls for code consumers and structured prose for humans; never leak scratchpad or reasoning fields into downstream contracts.

## 3. Engineer Context as a Scarce Attention Budget

- **Prefer progressive disclosure to upfront dumping**: Expose compact indexes, summaries, or handles initially and fetch full documents, schemas, or history on demand. Size worst-case inputs (long source documents, large catalogs) and multi-turn trajectories against context, latency, and token budgets via targeted retrieval, chunking, or structured extraction—never silent truncation.
- **Externalize authoritative state across turns and compaction**: Separate *ephemeral context* (chat history, scratch reasoning, raw tool output) from *authoritative state* (workspace artifacts, versioned drafts, structured task/obligation records). Reconstruct goals, constraints, verified facts, and in-flight or unknown-effect actions from authoritative state on compaction, retry, or handoff; skip persistent checkpoint files on single-turn tasks with no recovery need.
- **Enforce source precedence and trust boundaries**: Maintain `Harness contracts & authoritative state > user instructions > untrusted documents, web content, or tool outputs` so untrusted payloads, compacted summaries, or intermediate model plans cannot override invariants or authorize actions.

## 4. Design the Agent-Computer Interface (ACI) and Diagnostic Feedback

- **Design poka-yoke, intent-aligned tools**: Expose coarse domain operations rather than chatty primitives requiring brittle multi-call sequences. Remove parameters models miscalculate (prefer semantic IDs or text anchors over raw byte/line offsets), separate read-only queries from mutating or external-effect calls, and make retriable writes idempotent.
- **Block receipt-as-completion errors**: Models often treat a queued job ID or dispatched call as finished work. Surface `pending` or **`unknown`** effect states explicitly on async calls, timeouts, or ambiguous failures, and gate dependent mutations until authoritative state confirms the outcome.
- **Return bounded, diagnostic feedback**: Cap or paginate large outputs to protect context. Distinguish **locally repairable formal errors** (schema, syntax, or broken references) from **semantic gaps or capability limits** (missing business facts, conflicting rules, or unsupported constructs that require user clarification or capability extension—never silent lossy fallback to free text).

## 5. Choose Topology by Context Isolation, Not Role Theater

- **Default to a single agent with progressive context and focused tools**: Each agent hop loses context nuance and compounds latency, token cost, and coordination risk. Do not invent role personas (`Planner`, `Author`, `Critic`) when one loop plus deterministic checks suffices.
- **Spawn subagents or workers only for structural gain**: (1) *context isolation* for noisy search, log triage, or broad exploration; (2) *parallel execution* across disjoint state; (3) *privilege or sandbox separation*; or (4) *independent verification* (`executor != verifier`) where unbiased audit matters.
- **Use structured handoffs**: Pass scoped goals, authoritative input refs, permission boundaries, expected outputs with direct evidence, and unknown-effect status—never dump raw parent transcripts or trust unverified upstream claims.

## 6. Close Loop Convergence, Iterative Edits, and Behavioral Evaluation

- **Bound convergence and escalation**: Set observable completion criteria, retry/turn caps, and stall detection that halts repeated attempts without new discriminating evidence. Route non-converging cases to an explicit exit (clarify, surface the exact capability/evidence gap, or escalate) rather than looping indefinitely or inventing parallel shadow state.
- **Preserve untouched semantics on iterative edits**: Anchor updates against the current authoritative artifact, flag conflicting or ambiguous edit batches, and verify that unmodified rules, quantifiers, and references survive unchanged.
- **Combine deterministic gates with behavioral evals**: Schema or compile checks do not prove semantic fidelity, and happy-path runs miss failure modes. Define behavioral evals as `claim -> plausible model failure -> discriminating case (missing/ambiguous facts, subtle quantifiers or conditions, conflicting edits, long inputs, tool timeout/unknown effect) -> observation boundary and oracle`.
- **Place artifacts cleanly (`SKILL.md` Section 5)**: Keep behavioral contracts, instruction layers, context/ACI mechanisms, and convergence rules in *Overall Solution* and *Key Designs*, behavioral evals in *Validation and Acceptance*, and any required verbatim prompt templates or full tool schemas in *Appendix* at the end.
