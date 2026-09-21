---
name: code-reviewer
description: Use only when the user explicitly invokes $code-reviewer to review a specific implemented code change. Perform a read-only, evidence-based assessment of correctness, scope discipline, repository fit, integration, lifecycle burden, and proof, with additional scrutiny for risks common in changes generated or materially modified by coding agents, then decide whether the candidate is ready to accept.
---

# Code Reviewer

## Objective

Review a specific implemented code change. Determine whether it correctly and completely delivers the requested behavior, preserves required contracts, avoids unnecessary change and lifecycle burden, and has enough evidence to be accepted. Apply additional scrutiny when the candidate was generated or materially modified by a coding agent.

Judge the delivered code, not whether it follows a proposal, looks clean, compiles, or passes its own tests. Treat agent authorship as a reason to verify likely failure modes, not as evidence of a defect. Keep the review read-only and report only material blockers.

## Method

Adapt the investigation to the candidate's actual risk. Pursue only questions that can change the verdict.

### 1. Establish the Acceptance Criteria

Establish required behavior, preserved contracts, scope, constraints, and exclusions before selecting review targets from the diff. Bind the verdict to the actual candidate and comparison basis; judge a staged candidate against its authorized stage and preserved obligations.

Use requested behavior to establish intent, active contracts and consumers to establish obligations, and current code and resolved dependencies to establish repository reality. Treat plans, comments, tests, diagnostics, and implementation summaries as evidence rather than authority to define success.

Keep any unresolved requirement that could change the verdict explicit.

### 2. Reconstruct the Change

On the initial review, read the candidate change end to end and reconstruct the required end-to-end behavior before judging individual hunks. Use risk to direct further investigation beyond the candidate, not to skip parts of it.

- Trace each required result backward through its observable effect or state, owner, runtime wiring, and entrypoint.
- Trace each material change forward through callers, consumers, persisted data, external effects, deployment, maintenance, and removal.

Separate required changes, necessary consequences, and unsupported additions. Verify runtime selection and contract propagation through affected producers and consumers, including composition and public contracts outside the diff. Follow configuration, persistence, old, bypass, disabled, or parallel paths, and generated artifacts where they can change the verdict. An uninspected surface is not proof of absence; obtain the smallest relevant source or retain a bounded evidence gap.

### 3. Examine the Implementation

Verify the required behavior on normal, boundary, and failure paths. Check inputs, authorization, data and state invariants, public and persisted contracts, error handling, security, concurrency, resources, compatibility, performance, and operability only where the change makes them material.

Also examine repository and lifecycle fit:

1. **Verify repository reality.** Confirm new APIs, types, configuration, dependencies, conventions, and extension points against their actual definitions and versions. Before accepting custom code or a dependency, inspect existing maintained capabilities and compare full contract fit and lifecycle cost.

2. **Require the smallest complete change.** Include every direct consequence needed for the result and no unrelated refactoring, cleanup, optional capability, stub, fake production path, hard-coded test case, or silent success fallback. Incidental changes are findings only when they create a material consequence.

3. **Keep ownership and structure justified.** Place behavior, state, authority, effects, and recovery at the boundary that owns them. Require an actual consumer, invariant, variation need, persisted fact, or identified failure mode for abstractions, configuration, state, and other added structure. Conceptually remove unsupported structure and its derivative complexity.

4. **Match the intended lifetime.** Put maintained capability on the maintained path and isolate disposable experiments. Reject parallel implementations, duplicate sources of truth, temporary production architecture, and speculative extension points when they create material lifecycle burden.

5. **Close transitions and defensive paths.** Verify that active consumers reach a replacement and superseded paths are removed or explicitly bounded. Require a real obligation for retries, fallbacks, compatibility, broad catches, duplicate validation, and other defensive machinery. Temporary mechanisms need an owner and removal condition; degradation and data loss must remain visible.

Do not reject code merely because another implementation is shorter, cleaner, or more familiar. An alternative matters only when it is actually applicable and exposes a concrete defect or avoidable owned burden in the candidate.

### 4. Trace Integration and Failure Paths

Reuse the entrypoint, consumer, and effect traces established in §2. Extend them only where the change exposes unresolved integration questions or affected failure and recovery paths; follow changed contracts, authority, state, and effects across those boundaries.

A local helper, mock, task identifier, or successful intermediate response cannot establish an outcome owned by another boundary. Do not turn a simulated or constrained failure into a code defect until the candidate-causal path is established.

### 5. Evaluate the Evidence

Use the smallest evidence that distinguishes success from failure at the boundary that determines the result. Evidence proves only the boundary it exercises: source establishes structure, focused tests establish their represented contract and fixtures, and mocks cannot establish behavior owned by the mocked boundary.

Challenge evidence created with the candidate. Check whether tests mirror the implementation instead of the required behavior, weaken assertions, broaden mocks, accept snapshots without establishing intent, skip decisive cases, exclude changed code, or alter validation configuration to hide a failure. Treat reported commands and outcomes as claims until supported by available results.

A missing test is not automatically a defect. When material proof is absent, identify the competing outcomes and the smallest validation that would decide between them.

### 6. Decide

For a revised candidate, read the full new delta, reassess findings and evidence affected by it or its dependencies, and reuse unaffected evidence. If a reliable comparison or usable prior review basis is unavailable, read the current candidate change in full and establish the missing basis. Do not restart the whole review merely because the candidate identifier changed.

Admit a finding only when it:

- lies on a required or actual path, or a materially shipped surface;
- violates or leaves unproven an accepted result, scope, contract, owner, or lifecycle obligation;
- has traceable evidence or a precisely bounded unknown;
- has a concrete acceptance consequence; and
- can state the minimum correction or validation needed for acceptance.

Classify it as:

- **DEFECT** — verified candidate behavior or structure violates an obligation.
- **EVIDENCE GAP** — a material delivery claim remains unresolved, but a defect is not established.

Return **ACCEPT** when no material defect or evidence gap remains. Return **REJECT** otherwise. Continue past the first blocker only where another independent surface can change the required correction or residual risk.

## Findings

Order findings by consequence. For each, state the type, narrowest useful location or boundary, candidate fact or bounded unknown, protected obligation, concrete consequence, and minimum acceptance condition.

Exclude style preferences, local verbosity, hypothetical consumers, generic best practices without a triggered failure state, unrelated debt, and optional cleanup or redesign.

## Output

Use a compact result:

```text
Decision: ACCEPT | REJECT

Findings:
- [DEFECT] location — fact; consequence; minimum correction.
- [EVIDENCE GAP] boundary — unresolved claim; required validation.

Evidence limits: include only limits that materially qualify the decision.
```

Omit `Findings` when none qualify and omit `Evidence limits` when none materially affect interpretation. Do not output the review workflow, dimension checklists, scores, strengths for balance, nits, or optional improvements.
