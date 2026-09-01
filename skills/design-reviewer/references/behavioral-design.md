# Agent- and Harness-Dependent Design

Read this reference only when a pivotal design judgment depends on an LLM or agent decision, or on the Harness composition and control that makes that decision effective. Human, UI, workflow, tool, and channel details matter here only when they determine that path.

The submitted proposal remains the review object. The core review establishes the required outcome, the obligation, and the decision this review must support. This reference neither creates a behavioral obligation nor accepts an exact delivered candidate or runtime population.

The standard is:

> The proposal defines the model-dependent behavior precisely enough to judge, uses model discretion only where it is needed, supplies the effective facts and instructions, keeps deterministic constraints and authority at an enforcing boundary, closes the shortest causal route to the promised observable result, and specifies evidence capable of distinguishing the design claim from a plausible failure.

## Define Model-Dependent Behavior and Enforcement

Start from the retained pivotal judgment rather than from the presence of a prompt, model, or agent. Define only the dimensions needed to test that judgment; they are not a required execution sequence:

- the trigger and relevant context;
- the decisive facts and instructions;
- the required interpretation, decision, or generation;
- the allowed variation and required invariants;
- the consumer-visible result or required non-action.

Derive this contract from the outcome and obligation already established by the core review; do not invent a stronger behavioral guarantee here. If the proposal cannot define the required behavior closely enough to distinguish success from a plausible wrong result, report that gap before evaluating its mechanisms.

Then determine:

- what interpretation, judgment, or generation requires model discretion, and why an existing maintained deterministic capability is insufficient;
- which authorization, permission, schema, state transition, validation, idempotency, security, and effect-confirmation rules require deterministic enforcement;
- whether the proposed split allows the model to make the intended judgment without treating prose as enforcement or silently moving authority into the Harness.

Model use is unsupported when the retained result needs no model judgment, when an existing capability already closes it with lower lifecycle cost, or when the proposal delegates a deterministic guarantee to model compliance. Do not require planning, memory, reflection, retries, evaluators, orchestration, or additional agents merely because behavior is model-dependent.

## Reconstruct the Effective Composition

Inspect only composition elements whose presence or change could support or overturn the pivotal judgment:

- decisive facts, their authoritative sources, availability, trust, freshness, and conflict behavior;
- governing instructions, user input, prior context, references, tool results, and their activation and precedence;
- context selection, compaction, memory, or generated intermediate state when later decisions depend on them;
- tool schemas, capability exposure, permissions, runtime policies, model assumptions, and channel projection.

The proposal must specify what happens when a decisive input is missing, ambiguous, stale, conflicting, unauthorized, or untrusted whenever that condition can change an established result. Tool availability establishes feasibility, not an obligation to use the tool.

Exact prompts, model assumptions, tool wiring, configuration, traces, or evaluation results may be inspected when they determine the proposed composition or test one of its premises. Treat them as design evidence at their actual status and scope: planned material does not prove loading or execution, and observed behavior does not by itself accept the submitted design for every composition or scenario.

## Trace Behavior to Its Observable Result

There is no mandatory Agent execution topology. Connect only the causal links on which the behavior claim depends:

- how the effective facts and instructions reach and govern the model-dependent judgment or generation;
- how a model output that is itself the promised result reaches its consumer;
- when the model selects an action, how deterministic authority and valid inputs govern that action and how any claimed external result is established at its owning boundary;
- how an observable condition determines required continuation, clarification, refusal, recovery, or stop behavior.

A generated explanation, classification, recommendation, summary, plan, or other model output may itself be the required result; do not invent an external effect or downstream consumer for it. Require an action, authoritative state, or side-effect path only when the promised result depends on one.

Establish whether:

- the model can obtain the facts needed for its judgment without inventing or substituting them;
- any selected action remains within enforced authority and receives valid inputs;
- the owner of the decisive state or external effect can be observed when the promised result depends on it;
- an invocation, task identifier, acknowledgement, callback, or receipt is kept distinct from completion;
- failure, partial completion, or an unknown effect leads to the required clarification, refusal, recovery, retry, or stop before another consequential action.

Plans, task representations, memories, reflections, rubrics, evaluator outputs, and other generated artifacts are intermediate mechanisms rather than facts or outcomes when they condition later behavior. Retain one only when an established downstream decision consumes it and it closes a demonstrated gap or material failure. When a generated artifact is itself the required consumer-visible result, judge it directly against its behavior contract.

## Apply Material Failure Pressure

Challenge only conditions capable of overturning the pivotal judgment. Depending on the claim, this may include:

- a decisive ambiguity, missing fact, or irrelevant variation changing a required result;
- untrusted content overriding governing instructions or authoritative facts;
- context loss, compaction, generated state, or stale memory changing a decision the proposal claims remains stable;
- tool failure, timeout, partial completion, or an unknown external effect followed by unsafe continuation or repetition;
- a material model, instruction, configuration, permission, tool, or composition change invalidating the premise or evidence on which the design relies.

A single bounded counterexample can disprove an absolute scenario claim. It cannot establish frequency, aggregate reliability, causal sensitivity, or behavior outside the exercised composition and context. Do not turn a possible failure into a required retry, recovery, memory, or evaluation mechanism until an established obligation makes that response necessary.

## Design Discriminating Validation

For each model-dependent pivotal claim, establish the smallest future validation capable of separating the intended behavior from a plausible wrong behavior:

`design claim -> plausible failure -> discriminating scenario -> oracle and observation boundary -> evidence needed for the named decision`

Match evidence to the claim:

- source and configuration can establish an intrinsic omission, conflict, impossible route, or selected composition within their scope;
- one controlled run can establish or disprove only the exercised behavior under its exact model, instructions, tools, context, and scenario;
- a controlled contrast can establish sensitivity or invariance only across the changed condition;
- repeated or sampled runs can establish only the defined population, metric, threshold, and run design;
- native state or an effect-owner read can establish the authoritative fact it owns;
- rendered output can establish what the captured client or channel presented.

Use repeated runs only when the required outcome includes a reliability or stability claim. Use authoritative-state or rendered evidence only when the pivotal judgment depends on the external effect or final presentation they own. Existing runtime evidence may support feasibility or overturn a design premise; its absence is a decision-changing gap only when the user's named next decision requires that evidence now and cannot safely defer it.

## Return to the Core Judgment

Return the result to the pivotal judgment that caused this reference to be loaded:

- the judgment remains supported within stated assumptions and evidence;
- a verified composition, enforcement, or causal-route defect weakens or overturns it to the extent of its established consequence;
- insufficient validation design or missing evidence leaves only the decision that depends on it unsupported, unless it also establishes an intrinsic route defect;
- a grounded unknown controls a material decision branch;
- or the required guarantee remains a user-owned tradeoff.

State the causal consequence and the minimum design change, evidence, or owner decision needed. Do not issue a separate behavioral verdict, conclude on the whole proposal from this reference alone, or convert design-side sufficiency into acceptance of an exact implementation, deployment, or runtime population.
