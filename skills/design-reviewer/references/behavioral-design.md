# Behavior-Dependent Design Review

Read this reference after the core review has retained a pivotal commitment whose result depends materially on behavior produced by a model, human, runtime instruction, autonomous component, UI or channel, workflow, or tool-mediated path. The review object remains the proposed design, not an exact delivered candidate.

The standard is:

> At the proposal's claimed level and for any use named by the user, each required behavior is defined enough to avoid materially different interpretations, assigned to an actor or mechanism with the necessary capability and authority, supported by available and trustworthy inputs, causally connected to an observable result through the smallest sufficient route, explicit about material failure and uncertainty, and paired with any validation needed to distinguish success from a plausible failure.

Do not use this reference to create a new behavioral obligation. The core review decides whether a commitment belongs. This reference judges the design of behavior that remains.

## Define the Required Behavior

Translate abstract claims such as reliable, proactive, adaptive, complete, intuitive, safe, or channel-compatible into behavior that can be reasoned about. At the abstraction claimed by the proposal, reconstruct only the information needed to avoid materially different implementations or judgments:

- the trigger or situation and the responsible actor;
- the actor's authority and the facts, context, instructions, or user input it may rely on;
- the decision or action required and the observable result for the user or consumer;
- the authoritative condition that determines success when presentation or an intermediate action is not the result itself;
- material failure, ambiguity, missing-input, or conflict behavior;
- established constraints, exclusions, and meaningful variants.

These are semantic dimensions for the reviewer, not mandatory headings or a required prompt template. A concise prompt may be sufficient in a well-defined composition; a structured and polished prompt may still specify the wrong behavior. Missing information is a defect or decision-changing unknown only when it can change the implementation, result, safety, or ability to validate the commitment.

A local prompt, Skill, UI, or worker needs to define only its necessary contribution and consumer contract, not pretend to own the end-to-end outcome. Conversely, do not let a local component claim success when the authoritative result is determined elsewhere.

Do not promote an illustrative platform, channel, persona, tool, mock, current workflow, or available capability into a requirement. Keep it as an example or scoped fact unless the core obligation trace gives it normative force. Do not generalize away a named behavior or surface when an authorized outcome or active consumer actually requires it.

## Choose the Responsible Mechanism

Assign each material interpretation, decision, action, user interaction, and result confirmation to an actor or boundary with the capability and authority to own it. Compare the actual maintained capability, deterministic enforcement at the owning boundary, a necessary human decision, and model- or instruction-mediated behavior before accepting new behavioral machinery.

Use a prompt or model for interpretation, judgment, or generation when those properties are needed. Do not use prose as a substitute for permissions, type or schema enforcement, durable state, idempotency, security boundaries, authoritative facts, or confirmation of an external effect. Tool availability establishes feasibility, not a requirement to call it. Reuse is justified only when the existing capability satisfies the retained behavior without distorting its contract, owner, or lifecycle.

Planning artifacts, self-generated theories, criteria, rubrics, task representations, reflection, and memory are intermediate mechanisms rather than outcomes when they are used to condition later behavior. Retain such a mechanism only when a downstream decision actually consumes it and it closes a demonstrated behavioral gap or controls an identified material failure; its generated content is not evidence or authority by itself. When one of these is itself the required consumer-visible result, judge it as that outcome rather than imposing an artificial downstream consumer. Retries, walkthroughs, screenshots, orchestration, evaluators, and multiple agents are also mechanisms rather than outcomes and require the same obligation or identified-failure basis, but need not serve as intermediate representations. Prefer direct behavior and existing enforcement when they satisfy the same obligation.

## Test the Planned Composition and Route

Judge the behavior in the composition the proposal relies on, not from one prompt or file in isolation. Relevant inputs may include system instructions, Skill core and conditional references, user content, prior context, tool descriptions and results, runtime permissions, deterministic validation, UI or channel projection, and the final consumer.

The proposal must specify enough to establish how pivotal instructions and facts become available, how conflicts or precedence are resolved, which capability can act, and which boundary determines the result. Design Review may inspect current composition and behavior as evidence, but deterministic loading and wiring of an exact future candidate belong to Code Review, while acceptance of its effective behavioral composition belongs to Behavior Review.

Trace the shortest applicable route:

`trigger -> obtain facts and constraints -> interpret or decide -> act -> produce effect -> observe authoritative result -> continue, revise, clarify, or stop`

The route is defective when the actor cannot obtain a required fact, lacks authority or capability, substitutes an action or presentation for the promised result, cannot observe a material failure, or has no safe behavior for an established ambiguity. Apply only the interruption, retry, recovery, cancellation, or escalation semantics required by the retained obligation; route durable state, external contracts, committed effects, concurrency, and recovery ownership through the system-design reference as well.

When visual or interaction quality is required, define the observable consequence rather than a taste preference. Relevant concerns may include comprehension, state visibility, action affordance, error prevention and recovery, accessibility, responsiveness, and cross-surface consistency, but only where they can change task success or an authorized experience.

## Apply Relevant Failure Pressures

These questions expose common failures that the general route may not reveal. They are not a complete taxonomy or mandatory report sections. Answer them for the retained route; an unresolved answer is not the same as no dependency.

### Does success depend on inference without a deterministic guarantee?

This includes language, classification, generation, perception, or interpretation by a model. Test whether the design controls unsupported completion, anchoring on proposal examples, context sensitivity, unstable decisions, untrusted content, and evidence that no longer applies after a material model, configuration, or composition change. When later behavior is conditioned on a self-generated theory, rubric, plan, criterion, or task representation, establish the source it claims, the downstream decision that consumes it, whether materially different representations change the result, and how a plausible but wrong representation is detected before it propagates through downstream decisions. When the required behavior calls for established external knowledge, a generated label or explanation cannot substitute for source-backed identification. Do not turn nondeterminism into a requirement for voting, memory, or repeated runs unless the retained guarantee needs them.

### Can an actor continue or repeat consequential actions without contemporaneous confirmation?

This includes agents, deterministic workflows, scheduled automation, and retrying components. Establish the authorized action range, preconditions, observation before continuation, duplicate-effect risk, and conditions for clarification, escalation, or stopping. Autonomy does not by itself justify persistent plans, recovery state, or orchestration layers.

### Does correctness depend on interpreting and following runtime instructions rather than deterministic enforcement?

This includes Skills, prompts, policies, templates, and human procedures. Test planned activation and loading, authority order, conflicts, salience, example-versus-rule confusion, and exposure to untrusted instructions. The existence or completeness of instruction text does not establish that the required behavior will occur.

### Does the result depend on a person understanding state, choosing correctly, confirming, or handing work off?

Test whether the person can perceive the relevant state and consequence, take the required action, correct or withdraw it where required, and know who owns the next decision. Functional completion does not establish comprehension, and a visible success state does not establish an external effect.

## Design Discriminating Validation

For each pivotal behavioral claim, identify a future validation route that can separate the intended behavior from a plausible wrong behavior:

`retained commitment -> material scenario -> action and observation -> expected visible and authoritative result -> conclusion the evidence can support`

Use paired or contrasting cases when surface similarity could hide a different obligation: example versus active consumer, current behavior versus external guarantee, available capability versus required capability, known absence versus unresolved ownership, or simplification that preserves obligations versus deletion that loses one. For model-dependent decisions, blind cases can expose answer leakage or candidate-frame anchoring. Plan repeated runs only when the required outcome includes material stability, and reserve unseen cases only when they add distinct evidence.

Choose the eventual observation boundary that owns the claim. Source and configuration can establish a planned or current composition within their scope; a rendered client can establish visual behavior; a native API or state read can establish an authoritative effect; a controlled model run can establish only the exercised behavior under its model, instructions, tools, and context. A mock, static validator, authored test, walkthrough, or polished output proves only its direct scope.

Existing behavioral evidence may support feasibility or overturn a design premise, but it does not accept a future delivered candidate. The behavioral validation design is sufficient for the stated use when it names the smallest proportionate validation needed and leaves later qualification open without making the current decision unsafe or irreversible. Do not require a persistent evaluation asset when a bounded acceptance check is sufficient and no maintained consumer exists.

## Form Behavioral Findings

An established behavioral-design defect requires:

`verified design fact -> required behavior the route cannot define, assign, produce, or distinguish -> affected authorized outcome or material risk -> minimum mechanism, responsibility, or decision to remove, change, or reopen`

If the missing fact can change the behavioral route, owner, mechanism, or validation, report a decision-changing evidence gap and the smallest separating evidence. Do not reject a route merely because delivered behavior has not yet been run, and do not accept one merely because its prose, examples, or planned tests look complete. Return deterministic loading and wiring to Code Review, and return exact-candidate behavior plus acceptance of visible or authoritative behavioral results to Behavior Review.
