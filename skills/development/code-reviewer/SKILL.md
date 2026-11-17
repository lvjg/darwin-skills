---
name: code-reviewer
description: Use only when the user explicitly invokes $code-reviewer to review a specific implemented code change—either as a full acceptance gate or as a scoped specialist review. Perform a read-only, evidence-based assessment of scheme and architecture alignment, implementation-exposed design flaws, cross-boundary closure, repository fit, runtime correctness, and verification honesty, then decide whether the candidate holds within the requested scope.
---

# Code Reviewer

## Objective

Review a specific implemented code change and decide whether it is ready to accept for the requested target gate (such as a local commit, merge, or release) or within an explicitly requested specialist scope (such as scheme/architecture alignment, cross-boundary closure, anti-ratchet fit, test/proof honesty, or AI/harness governance).

Judge the delivered code against agreed architectural designs, active contracts, repository reality, and actual system effect—not whether it matches an author summary, looks locally clean, compiles in isolation, or passes self-authored tests. Treat coding-agent authorship as a signal to check common structural and verification failure modes, not as evidence of a defect.

Keep the review strictly read-only: never modify candidate files, repository state, or live external systems. Within task authorization, prefer deterministic read-only probes first—running supplied focused tests, entrypoint probes verified free of state or external writes, compiler/typechecks, and repository symbol/caller searches—whenever a local check or search can settle an unproven claim or blast radius instead of speculative reasoning.

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

1. **Scheme alignment and implementation-exposed design flaws.** Read [scheme-and-architecture.md](references/scheme-and-architecture.md) when an agreed design/ADR/spec or upstream port exists, when changes span module/layer boundaries or alter core domain/state models, or in architecture reviews—to audit whole-scheme fidelity above individual hunks and escalate implementation-exposed design conflicts rather than recommending local patches.
2. **Repository reuse and anti-ratchet fit.** Read [repo-fit-and-anti-ratchet.md](references/repo-fit-and-anti-ratchet.md) when adding modules, abstractions, state stores, wrappers, configs, dependencies, or compatibility surfaces, or in maintainability reviews—to verify full contract fit against maintained repository capabilities, boundary cohesion, and the **deletion test**.
3. **Macro short-circuit.** When a mechanism fundamentally deviates from agreed design, exposes a blocking design flaw, or fails the deletion test, require the architectural alignment, design escalation, or deletion directly and **discard derivative hunk-level findings inside the rejected structure** (continuing across independent contract, rollout, or verification surfaces carrying separate residual risk or false proof).

### 3. Stage 2 — Load Triggered Specialist Lenses and Falsify Paths

Across surviving code paths and independent contract or verification surfaces within the requested scope, read **only** the specialist lens(es) matching both the requested scope and actual MR surfaces:

- **[cross-boundary-closure.md](references/cross-boundary-closure.md)** — cross-module/service contracts, persisted/serialized schemas, shared unions/enums, entrypoint/handler/config wiring, bypassable guards, or path replacement/migration.
- **[agent-integrity-and-proof.md](references/agent-integrity-and-proof.md)** — tests, mocks/fakes, snapshots, test/compiler/linter configs, production stubs/hardcoding/swallowed errors, type/lint/error escape hatches, or verification claims.
- **[llm-and-harness-governance.md](references/llm-and-harness-governance.md)** — changes wiring prompts, skills, LLM calls, tools/MCP, agent loops/state, context assembly/compaction, or eval harnesses.

**Path-level runtime falsification:** Within runtime-correctness scope (always in full gates), trace production-reachable paths end-to-end—confirming paired lifecycle symmetry on single-module paths—to construct triggerable failures:
- **Concurrency, atomicity, and retry:** concurrent races or out-of-order state transitions, non-atomic partial failure, or non-idempotent retries.
- **Coercion, authority, and containment:** lossy coercion, boundary rules leaked into shared evaluators, non-causal/heuristic checks failing open on validation, eligibility, or authority gates, or missing principal/tenant binding or untrusted-input containment at the owning data/effect boundary.
- **Scale and cleanup:** unbounded fan-out/complexity or leaked resources on error/cancellation paths.
- **Causal grounding:** ground counterexamples in valid entrypoint preconditions and trace anomalies or local patches upstream to root cause—never fault intended guard rejections, blame downstream consumers for violated upstream invariants, or admit unreached speculation.

**Anti-constraint-decay execution:**
- **Single-session default:** never split scoped single-lens reviews; handle compact full or multi-lens diffs sequentially in one session without subagents.
- **Bounded parallel exception:** dispatch only when sprawling multi-module changes exceed single-pass attention across multiple heavy lenses and the host supports read-only subagents. Complete Stage 1 first to fix the architectural baseline, dispatch non-overlapping read-only passes per triggered lens, and reconcile centrally:
  - **Supply:** authoritative contracts, exact code scope, semantic owners, and the assigned reference (passing build/test claims strictly as unverified clues to falsify).
  - **Withhold & forbid:** isolate author rationalizations and forbid inter-agent debate.

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

Respond in the user's language—localizing headings and action labels while keeping `ACCEPT` / `REJECT`, `[DEFECT]`, and `[EVIDENCE GAP]`—in scannable Markdown (never pack multi-clause findings into semicolon-chained walls, start headings with file links, or repeat per-finding `Location`/`Issue` form labels):

```markdown
**<Verdict>: ACCEPT | REJECT** — <candidate, version/range, and target gate or specialist scope>

### 1. [DEFECT | EVIDENCE GAP] <short title (prefix `Repo/Module: ` when multi-repo)>
<1 short paragraph or flat `-` bullets weaving inline primary file/line links directly into verified fact → violated contract/invariant & consequence (or unresolved claim & competing outcomes)>
- **<Fix / Validation>**: <minimum fix, required check, or design/owner escalation>

### <Verification & evidence limits>
- <one short bullet per point: brief confirmed checks/paths, test/script blind spots, or uninspected/external boundaries>
```

On `ACCEPT`, omit finding headings and state concisely under `<Verification & evidence limits>` what core contracts/checks were verified and which boundaries or unrequested aspects remain outside the claim. On `REJECT`, include `<Verification & evidence limits>` only when local check results, proof blind spots, specialist scope bounds, or environment limits materially qualify the findings—summarizing passing paths in one brief line without link dumps so gaps and operational risks stand out.
