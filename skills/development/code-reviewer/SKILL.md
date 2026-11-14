---
name: code-reviewer
description: Use only when the user explicitly invokes $code-reviewer to review a specific implemented code change—either as a full acceptance gate or as a scoped specialist review. Perform a read-only, evidence-based assessment of scheme and architecture alignment, implementation-exposed design flaws, cross-boundary closure, repository fit, runtime correctness, and verification honesty, then decide whether the candidate holds within the requested scope.
---

# Code Reviewer

## Objective

Review a specific implemented code change and decide whether it is ready to accept for the requested target gate (such as a local commit, merge, or release) or within an explicitly requested specialist scope (such as scheme/architecture alignment, cross-boundary closure, anti-ratchet fit, test/proof honesty, or AI/harness governance).

Judge the delivered code against agreed architectural designs, active contracts, repository reality, and actual system effect—not whether it matches an author summary, looks locally clean, compiles in isolation, or passes self-authored tests. Treat coding-agent authorship as a signal to check common structural and verification failure modes, not as evidence of a defect.

Keep the review strictly read-only: never modify candidate files, repository state, or live external systems. Within task authorization, prefer deterministic read-only probes first—running supplied focused tests, compiler/typechecks, and repository symbol/caller searches—whenever a local check or search can settle an unproven claim or blast radius instead of speculative reasoning.

## Method

Work top-down from system design and boundaries to concrete paths so hunk-level details never crowd out architectural judgment. Pursue only questions that can change the verdict or minimum acceptance conditions for the requested scope, and do not invent requirements for hypothetical callers, distributed environments, or external journeys outside the accepted contract.

### 1. Pin Down Candidate, Baseline Authority, and Scope

1. **Bind exact candidate and review scope.** Identify the target files, commit range, or staged/unstaged diff and comparison base, separating unrelated dirty files. Determine whether the user requested a **full gate review** or a **scoped specialist review**; in scoped mode, restrict lens loading, path checks, and the verdict to the named aspect(s) after anchoring on the governing repository owner.
2. **Separate baseline authority from author choices and claims.** Distinguish:
   - **Authoritative baseline:** user request, agreed technical design / ADR / spec, active public or persisted contracts, and verified repository architecture and dependencies;
   - **Author-chosen structure:** unprescribed internal mechanisms, module splits, or abstractions introduced by the candidate (fully subject to architecture and deletion audit);
   - **Unverified claims:** implementation summaries, comments, reported diagnostics, and candidate-authored tests (clues to verify, never definitions of success).
   Keep any unresolved requirement or contract conflict that could change the verdict explicit as a blocking prerequisite rather than inventing policy.

### 2. Stage 1 — Audit Scheme Alignment, Exposed Design Flaws, and Structural Fit

Before inspecting line-level runtime details, evaluate the candidate at the whole-scheme and module-boundary level (skipping unrelated lenses only when an explicit scoped specialist request excludes them, while still identifying the existing semantic owner):

1. **Scheme alignment and implementation-exposed design flaws.** Read [scheme-and-architecture.md](references/scheme-and-architecture.md) when an agreed design/ADR/spec exists, when the change spans module or layer boundaries or alters core domain/state models, or when reviewing architecture. Reconstruct the implemented scheme above individual hunks, check **forward design-to-code drift and silent obligation omissions**, and check **reverse implementation-exposed design flaws**—where concrete repository reality disproves an agreed design assumption and requires escalating the design/contract conflict rather than piling on local patches.
2. **Repository reuse and anti-ratchet fit.** Read [repo-fit-and-anti-ratchet.md](references/repo-fit-and-anti-ratchet.md) when the change adds modules, classes, helpers, abstractions, state stores, retry/fallback wrappers, configs, dependencies, or compatibility exports, or when reviewing maintainability/fit. Verify full contract fit against maintained repository capabilities, responsibility placement/cohesion/decoupling, and the **deletion test**.
3. **Macro short-circuit.** When a mechanism fundamentally deviates from agreed design, exposes a blocking design flaw, or fails the deletion test, require the architectural alignment, design escalation, or deletion directly and **discard derivative hunk-level findings inside the rejected structure** (continuing across independent contract, rollout, or verification surfaces carrying separate residual risk or false proof).

### 3. Stage 2 — Load Triggered Specialist Lenses and Falsify Paths

Across surviving code paths and independent contract or verification surfaces within the requested scope, read **only** the specialist lens(es) matching both the requested scope and actual MR surfaces:

- **[cross-boundary-closure.md](references/cross-boundary-closure.md)** — changes touching cross-module/service interfaces, persisted or serialized schemas, shared unions/enums, entrypoint wiring, handlers/stateful writers/config keys whose production registration or sibling routes must close, business/authority guards with potential bypass paths, or path replacement/migration.
- **[agent-integrity-and-proof.md](references/agent-integrity-and-proof.md)** — changes adding or modifying tests, mocks/fakes, snapshots, test/compiler/linter configs, production stubs/hardcoded branches/swallowed errors, type or error escape hatches (`any`, unsound casts, `@ts-ignore`, `# type: ignore`, lint suppressions, broad catches, `?.`), or verification claims.
- **[llm-and-harness-governance.md](references/llm-and-harness-governance.md)** — changes wiring prompts, skills, LLM calls, tools/MCP, agent loops/state, context assembly/compaction, or eval harnesses.

**Path-level runtime falsification:** When runtime correctness lies within the requested scope (always in full gate reviews), trace active production paths—confirming production reachability and paired lifecycle symmetry—and apply native domain reasoning to construct concrete, triggerable failure scenarios where material: concurrent race/interleaving, non-atomic or non-idempotent partial failure and retry replay, missing principal/tenant binding or untrusted-input containment at the owning data/effect boundary, or `O(N^2)`/`N+1`/unbounded fan-out and leaked resources on error or cancellation paths. Drop speculative edge cases that have no real trigger path in the code.

**Anti-constraint-decay execution:** Never split a scoped single-lens review. In a full or multi-lens review, handle compact changes sequentially in one session (do not spawn subagents merely because a small diff matches multiple lenses); only when a sprawling multi-module change genuinely strains single-pass attention across multiple heavy specialist lenses—and the host supports read-only subagents—complete Stage 1 first to fix the architectural baseline, then dispatch bounded, non-overlapping read-only passes per triggered lens (supplying authoritative contracts, exact code scope, ownership baseline, and the assigned reference; withhold author narrative rationalizations, passing reported build/test claims strictly as unverified claims to falsify when auditing proof, with no inter-agent debate) and reconcile centrally.

**Proof boundary:** Even when `agent-integrity-and-proof.md` is not triggered, run safe supplied local checks when helpful and separate what source inspection or local doubles proved from unproven compiler, persistent-storage, concurrency, or external boundaries.

### 4. Synthesize and Decide

For a revised candidate, read the full new delta, reassess affected findings and evidence, and reuse unaffected conclusions from a prior independent review (treating author change summaries strictly as unverified claims); if a usable prior independent review basis is unavailable, review the current candidate in full.

Step back to judge the candidate as a whole against the target gate or requested specialist scope. Merge downstream symptoms or local workarounds caused by one root architectural, contract, or implementation issue into a single causal finding. Never let an early blocker skip auditing an independent contract, rollout/persistence, or authority surface whose failure changes required rework or residual risk. Admit a finding only when it:

- lies on a required or actual path, or a materially shipped surface within scope;
- violates or leaves unproven an accepted obligation, agreed design boundary, contract, semantic owner, cohesion/decoupling rule, or lifecycle constraint;
- has traceable code/tool evidence or a precisely bounded unknown;
- has a concrete acceptance consequence; and
- states the minimum fix, validation, or owner/design escalation needed (when concrete code facts expose a conflict in an agreed design or require an owner tradeoff, state the conflict and decision options rather than prescribing local hacks or authoring an unsolicited replacement architecture).

Classify each finding as:

- **DEFECT** — verified behavior or structure deviates from agreed design/contracts, breaks runtime correctness, exposes an unworkable design assumption in delivered code, or adds unjustified lifecycle burden.
- **EVIDENCE GAP** — a material claim, required boundary guarantee, or decision-changing contract/design prerequisite remains unresolved at its owning boundary without establishing a code defect.

Return **ACCEPT** when no material defect or evidence gap remains within the requested scope; return **REJECT** otherwise.

## Findings and Output

Order findings by consequence (macro scheme/architecture and root contract blockers first). Exclude style preferences, local verbosity, micro-optimizations, hypothetical consumers, untriggered best practices, unrelated debt, workflow narration, checklists, scores, strengths, nits, or optional cleanup.

Respond in the user's language using this compact structure:

```text
Decision: ACCEPT | REJECT (<candidate and target gate, or named specialist scope>)

Findings:
- [DEFECT] <narrowest location or boundary> — <verified fact>; <violated design/contract/invariant and concrete consequence>; <minimum fix or required design/owner escalation>.
- [EVIDENCE GAP] <owning boundary> — <unresolved claim, prerequisite, and competing outcomes>; <smallest required validation or owner decision>.

Verification & Evidence Limits:
- <concise summary of verified paths/checks, any uninspected scopes in specialist mode, and material boundary limits qualifying the decision>.
```

On `ACCEPT`, omit `Findings` and state concisely in `Verification & Evidence Limits` what core contracts/checks were verified and which boundaries or unrequested aspects remain outside the claim. On `REJECT`, include `Verification & Evidence Limits` only when local verification results, specialist scope bounds, or environment limits materially qualify the findings.
