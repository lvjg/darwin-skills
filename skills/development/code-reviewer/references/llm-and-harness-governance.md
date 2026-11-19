# LLM, Prompt, and Harness Governance

Apply this lens when the reviewed change implements or modifies prompts, skills, model/LLM calls, tool or MCP bindings, agent loops/orchestrators, context assembly/compaction/memory, or evaluation harnesses, or when requested as an AI/agent governance review.

## 1. Enforce the Deterministic Boundary vs. Model Discretion Split

Model prompts guide interpretation and generation, not security or state invariants. Verify in code that:

- **Deterministic gates own invariants:** authentication, authorization, tenant scoping, input/output schema validation, allowed state transitions, file/network sandbox bounds, and human or policy gates before irreversible external side effects are enforced deterministically in code outside model compliance.
- **Justified orchestration complexity:** reject ungrounded multi-agent loops, reflection passes, memory stores, or rubric scorers unless required by an established obligation that simpler deterministic code or a single bounded call cannot satisfy.

## 2. Audit Context Integrity, Untrusted Inputs, and Execution Loops

- **Prompt-injection and authority separation:** trace how untrusted user inputs, retrieved documents, web content, or tool outputs enter context. Verify they remain structurally isolated from system authority and cannot trigger unvalidated tool calls or data exfiltration.
- **Compaction and capacity resilience:** check whether context truncation, summarization, memory retrieval, or intermediate scratchpads can silently drop or override authoritative constraints, active permissions, or unresolved obligations across turns. When code rewrites, folds, or prunes message history, verify a single compaction/pruning owner, intact pairing across messages, reasoning entries, tool calls, and results, and ordering safety between retries and pruning (without resurrecting pruned state or orphaning in-flight child tasks).
- **Loop bounds and effect confirmation:** verify hard caps on turns, retries, subagent fan-out, and token/time budgets. Confirm that code keeps a tool call, task ID, or queued acknowledgement distinct from a verified external effect, and handles timeout or unknown external state safely without blind non-idempotent retries.
- **Lifecycle isolation and child-task commit ordering:** verify that lifecycle hooks isolate main-loop state from auxiliary model calls, and that state-dependent child work starts only after parent state commits (rather than blocking tool execution while waiting for a pending commit).
- **Failure handling and cleanup:** verify that error and cancellation paths drain durability and cleanup, that model or tool failures are not masked behind silent fallback text, and that invalid model tool calls return recoverable tool errors rather than session-crashing faults.

## 3. Check Evaluation and Behavioral Honesty

When reviewing eval sets, judges, or prompt updates, verify that assertions test generalizable contract invariants and discriminating failure cases rather than overfitting exact wording, leaking benchmark answers into prompts, or counting human-nudged trajectories or mere harness stage completion as proof of autonomous reliability.
