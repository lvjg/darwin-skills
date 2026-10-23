# Agent- and Harness-Dependent Design

Read this reference when a pivotal judgment depends on a prompt or model-dependent behavior contract, an LLM or agent decision, or the Harness composition, enforcement boundary, and validation that make that decision effective.

Derive behavioral requirements from the outcome and obligations established by the core review; do not invent stronger guarantees or convert design-side sufficiency into acceptance of a delivered candidate or runtime population.

## 1. Behavioral Contract and Enforcement Split

Before evaluating prompt wording, examples, or agent topology, verify that the proposal defines the model-dependent behavior closely enough to distinguish success from a plausible wrong result:

- Identify the trigger, the decisive input facts and instructions, the required interpretation or decision, the business invariants that must hold, and the wording or format variation that is allowed.
- Check what the system must do when decisive facts are missing, ambiguous, conflicting, or match multiple rules or records (such as asking for clarification rather than guessing, or keeping eligibility guidance distinct from approval).
- If the proposal relies on vague goals (such as "understand intent" or "answer safely") and happy-path examples without defining how decisive inputs, ambiguity, and invariants govern the visible result, report that behavioral contract gap before auditing downstream mechanisms.

Next, verify the boundary between model discretion and deterministic enforcement. Model use is justified only where interpretation, judgment, or generation cannot be closed by an existing maintained deterministic capability at lower lifecycle cost. Authorization, permissions, schema validation, state transitions, prohibited inputs or actions, and confirmation of external effects must be enforced at a deterministic boundary rather than delegated to prompt compliance. Do not require planning, memory, reflection, retries, evaluators, or multi-agent orchestration unless an established obligation and demonstrated gap require them.

## 2. Context Composition, Action Authority, and Failure Pressure

A generated explanation, classification, recommendation, summary, or plan may itself be the promised consumer-visible result; do not invent an external side effect or execution chain when the required result is the output itself.

Connect and challenge only the links on which the claim depends:

- **Context and state integrity:** check where decisive facts come from, how instructions and tool results take precedence, and what prevents untrusted content, context compaction, stale memory, or intermediate generated artifacts (plans, reflections, rubric scores) from overriding authoritative facts across turns.
- **Action governance and unknown effects:** when the model selects a tool or action, verify that deterministic authority and input validation govern execution, that an invocation, task identifier, acknowledgement, callback, or receipt is kept distinct from completion, and that tool failure, timeout, partial completion, or an unknown external effect triggers safe clarification, refusal, recovery, or stop before another consequential action.

## 3. Discriminating Validation

For each model-dependent pivotal claim, verify that the proposal specifies validation capable of separating the intended behavior from a plausible failure:

`design claim -> plausible wrong behavior -> discriminating scenario -> oracle and observation boundary -> evidence needed for the named decision`

Match validation to the claim: static source or configuration checks establish wiring and omissions; one controlled run proves only that exact scenario and composition; a controlled contrast tests sensitivity to a changed factor; repeated or sampled runs are needed only for reliability or rate claims; authoritative state or rendered output is needed only when the claim depends on an external effect or client presentation. Happy-path fluency or helpfulness ratings cannot validate ambiguity handling or safety invariants. Existing runtime evidence is required now only when the user's named decision cannot safely defer it.

Feed the result back into the core review's finding categories (`Established defect`, `Decision-changing evidence gap`, or `User-owned tradeoff`) with the concrete consequence and minimum contract, enforcement, or validation change required.
