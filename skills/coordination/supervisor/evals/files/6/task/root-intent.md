# Runtime behavior acceptance intent

Decide whether the already implemented `assistant-runtime@r17` composition is
ready for an internal rollout decision based on its exact observed escalation
behavior.

This is not a request to design or rewrite the Agent, accept a code candidate,
prove a product or system journey through a real entry point, review UX, or
simplify implementation. The required result is a bounded runtime evaluation
against `behavior-contract.md` using an offline harness whose tool calls are
intercepted and supplied with fixed receipts.

A later delegated evaluator is authorized to run that local harness and create
only `runtime-evaluation.md`. No product system, external service, code, prompt,
model configuration, tool policy or adapter may be modified. The current atomic
case stops before that Worker is dispatched; only `checkpoint.md` may be updated
now.
