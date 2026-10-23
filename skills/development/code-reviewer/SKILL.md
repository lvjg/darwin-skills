---
name: code-reviewer
description: Use only when the user explicitly invokes $code-reviewer to review a specific implemented code change. Perform a read-only, evidence-based assessment of correctness, scope discipline, repository fit, integration, lifecycle burden, and proof, with additional scrutiny for risks common in changes generated or materially modified by coding agents, then decide whether the candidate is ready to accept.
---

# Code Reviewer

## Objective

Review a specific implemented code change and decide whether it is ready to accept for the requested target gate (such as a local commit, merge, or release). Determine whether the candidate correctly and completely delivers the requested behavior, preserves required contracts, keeps responsibilities cohesive and decoupled, avoids unnecessary lifecycle burden, and has sufficient evidence. Apply additional scrutiny for failure modes common in code generated or modified by coding agents.

Judge the delivered code and its actual runtime effect, not whether it follows a proposal, looks clean, compiles, or passes its own tests. Treat agent authorship as a reason to verify likely failure modes, not as evidence of a defect.

Keep the review read-only: do not modify candidate files, repository state, or live external systems. Within the task's authorization, run safe, isolated, non-mutating local checks (such as supplied focused tests, typechecks, or read-only probes) when needed to verify unproven claims or distinguish competing outcomes.

## Method

Adapt the investigation to the candidate's actual risk. Pursue only questions that can change the verdict or minimum acceptance conditions, and stop expanding discovery once the evidence suffices for the target gate. Do not invent requirements for hypothetical future callers, distributed environments, or external integrations absent from the accepted contract.

### 1. Pin Down the Candidate and Obligations

1. **Locate the exact candidate and gate.** Identify the target files, commit range, or staged/unstaged working-tree diff and comparison base, separating unrelated dirty files. Judge a staged candidate against its authorized stage and preserved obligations.
2. **Establish required behavior and obligations.** Read the user request and active contracts to determine required normal and failure behavior, preserved public or persisted interfaces, constraints, and explicit exclusions (such as E2E or live external calls). Read current repository code and resolved dependencies to establish repository reality.
3. **Treat author artifacts as claims, not authority.** Do not let implementation summaries, plans, comments, diagnostics, or candidate-authored tests define what counts as success. Keep any unresolved requirement or contract conflict that could change the verdict explicit as a blocking prerequisite rather than inventing acceptance criteria or redesigning the architecture.

### 2. Trace End-to-End Wiring and Contracts

On the initial review, read the candidate change end to end and reconstruct its actual end-to-end behavior before judging individual hunks. Follow connections outside the diff when runtime selection or contracts cross file boundaries:

1. **Verify production wiring.** Trace each required outcome backward through its authoritative state or effect, semantic owner, configuration, and real runtime entrypoint. Confirm that changed handlers, helpers, tool bindings, config keys, and build artifacts are registered and selected in production rather than reached only by direct test imports or dead code.
2. **Reconcile producers and consumers side by side.** Trace each material change forward through wrappers, decoders, callers, and public or persisted contracts on both sides. Check whether intermediate wrappers drop required fields, union or capability catalogs omit accepted cases, mismatched limits cause a downstream consumer to reject data after upstream state has mutated, or unversioned breaking changes break active consumers or mixed-version rollouts.
3. **Close sibling, bypass, and replacement paths.** Check whether old, disabled, maintenance, batch, or retry paths bypass a new rule or remain half-migrated. When replacing an existing path, verify that active consumers reach the replacement and superseded paths are removed or explicitly bounded. Confirm that rewrites did not silently drop existing authorization, tenant isolation, idempotency, cancellation, or boundary (`>=` vs `>`) guards.

Separate required changes, necessary consequences, and unsupported additions. An uninspected surface outside the diff is not proof of absence; read the smallest relevant source or retain a bounded evidence gap.

### 3. Audit Ownership, Structure, and Lifecycle Burden

Before auditing internal details of added machinery, verify that the candidate's structure and dependencies belong in the repository:

1. **Check existing capabilities and dependencies.** Confirm APIs, types, configuration, error semantics, and extension points against their actual definitions and installed versions. Before accepting custom code, a new retry/fallback mechanism, or a new dependency, search existing maintained capabilities in the repository and compare full contract fit (such as error predicates, attempt bounds, return values, and final-error behavior), runtime compatibility, lockfile consistency, and lifecycle cost.
2. **Verify responsibility placement, cohesion, and decoupling.**
   - **Responsibility ownership:** Verify that business rules, state transitions, permissions, effects, and recovery live in the module boundary that owns them rather than leaking into callers, controllers, UI, or transport wrappers.
   - **Cohesion:** Keep logic governing the same decision, invariant, or state lifecycle together so a single rule is not duplicated across files; do not bundle unrelated responsibilities that change for different reasons or have different trust/lifecycle boundaries.
   - **Decoupling and change containment:** Check that module boundaries do not leak low-level storage shapes, third-party implementation details, hidden call-order requirements, or shared mutable state across contracts. Do not mistake pass-through interfaces, extra files, or ceremonial wrappers for decoupling when they still leak the underlying contract.
3. **Apply a deletion and anti-ratchet test.** Keep maintained capability on the maintained path and isolate disposable experiments. Reject parallel implementations, duplicate sources of truth, unbounded in-memory operational state, unused public compatibility exports, and retries, fallbacks, or defensive machinery that lack a real obligation, owner, and removal condition. Ask what required outcome, active consumer, established invariant, boundary isolation, or reproduced failure mode would fail if an added abstraction, class, state store, configuration, or alias were deleted and the caller used the existing owner directly:
   - If none fails, conceptually remove the unsupported structure, require its deletion, and discard derivative findings about fixing or hardening its internal implementation unless removing it still affects an active consumer, persisted data, security boundary, or independent surface.
   - Incidental changes are findings only when they create a material consequence or burden. Do not reject code merely because another implementation is shorter, cleaner, or more familiar; accept a focused local helper or thin adapter when it centralizes an established invariant or isolates a real boundary without adding unnecessary state, config, or public surface.

### 4. Verify Runtime Semantics and Agent Integrity

For the required code paths, verify normal, boundary, concurrency, and failure behavior where the change makes them material:

1. **Check state symmetry, ordering, concurrency, and amplification.** When state, cache keys, or persisted schemas change, verify read/write and serialization symmetry, cache invalidation, backward compatibility with existing persisted data, and absence of in-place mutation of caller-owned or shared objects. On multi-step, concurrent, or retryable paths, verify that state mutations and external effects do not commit before validation or decoding succeeds, that atomic/CAS or request-key idempotency guarantees hold, and that partial failures roll back or reconcile cleanly without introducing material I/O amplification (such as N+1 calls in loops or holding locks across external calls) or broken transient/permanent error classification.
2. **Check authority and deterministic enforcement.** Verify that operations bind to authenticated identity and tenant scope. When code wires an LLM, prompt, or agent tool, verify that deterministic rules (permissions, schema validation, and publication or side-effect gates) are enforced in code rather than delegated to prompt prose.
3. **Reject fake completeness, symptom patching, and escape hatches.** Reject stubs, fake production paths, hard-coded test/prompt cases, silent success fallbacks, swallowed batch/partial failures, and leaf null-checks (`?.`) or broad catches that hide upstream contract corruption or data loss instead of fixing the owning boundary. Inspect type, linter, or schema escape hatches (`any`, unsound casts, `@ts-ignore`, `# type: ignore`, lint suppressions, or loosened schemas) against the underlying types to see if they mask a real contract break.

### 5. Challenge Claims and Bound the Evidence

Use the smallest evidence that distinguishes success from failure at the boundary that owns the result. Source inspection establishes structure; focused tests establish only their represented contract and fixtures; a local helper, mock, in-memory double, task identifier, or intermediate acknowledgement cannot establish an outcome owned by another persistence, transport, or external boundary.

1. **Audit candidate tests and reported checks.** Check whether tests mirror buggy implementation logic or constants into assertions (tautological tests), weaken assertions, broaden mocks over the boundary under test, accept snapshots without establishing intent, skip decisive boundary cases (`skip`/`todo`), miss `await` on async checks, exclude changed code, or alter test/compiler configuration to hide a failure. Reconcile reported typecheck and test claims against the actual bound types in source, and run supplied safe local tests when available. Do not turn a simulated or constrained environment failure into a code defect until a candidate-causal path is established.
2. **State the real proof boundary.** Distinguish what local execution proved (such as in-memory cache logic or a mocked transport) from what it did not prove (such as full compiler typechecking, persistent replay/rollback/concurrency at the storage owner, or live external delivery). A missing test is not automatically a defect; when material proof is absent for a required guarantee at its owning boundary, identify the competing outcomes and the smallest validation that would decide between them.

### 6. Decide

For a revised candidate, read the full new delta, reassess findings and evidence affected by it or its dependencies, and reuse unaffected evidence. If a reliable comparison or usable prior review basis is unavailable, read the current candidate change in full and establish the missing basis. Do not restart the whole review merely because the candidate identifier changed.

Admit a finding only when it:

- lies on a required or actual path, or a materially shipped surface;
- violates or leaves unproven an accepted result, scope, contract, owner, cohesion/decoupling boundary, or lifecycle obligation for the target gate;
- has traceable evidence or a precisely bounded unknown;
- has a concrete acceptance consequence; and
- can state the minimum correction, validation, or prerequisite owner decision needed without redesigning the accepted architecture (when multiple valid contract fixes exist and depend on an owner tradeoff, state the conflict and options rather than prescribing one policy).

Combine multiple downstream symptoms caused by one root issue into a single causal finding. Classify each finding as:

- **DEFECT** — verified candidate behavior or structure violates an obligation or adds unjustified lifecycle burden.
- **EVIDENCE GAP** — a material delivery claim, required guarantee, or decision-changing requirement/contract prerequisite remains unresolved at its owning boundary, without establishing a code defect.

Return **ACCEPT** when no material defect or evidence gap remains. Return **REJECT** otherwise. Continue past the first blocker only where another independent surface can change the required correction or residual risk.

## Findings and Output

Order findings by consequence. Exclude style preferences, local verbosity, micro-optimizations, hypothetical consumers, generic best practices without a triggered failure state, unrelated debt, review workflow narration, dimension checklists, scores, strengths for balance, nits, or optional cleanup suggestions.

Respond in the user's language using this compact structure:

```text
Decision: ACCEPT | REJECT (<candidate and target gate>)

Findings:
- [DEFECT] <narrowest location> — <candidate fact>; <violated obligation and concrete consequence>; <minimum correction>.
- [EVIDENCE GAP] <owning boundary> — <unresolved claim, prerequisite, and competing outcomes>; <smallest required validation or owner decision>.

Verification & Evidence Limits:
- <concise summary of verified core paths/checks and any material evidence limits qualifying the decision>.
```

On `ACCEPT`, omit `Findings` and state concisely in `Verification & Evidence Limits` what core contracts/checks were verified and which boundaries remain outside the claim. On `REJECT`, include `Verification & Evidence Limits` only when local verification results or scope limits materially qualify the findings.
