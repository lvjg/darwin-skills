# Repository Fit and Anti-Ratchet Audit

Apply this lens when a change introduces new modules, classes, helpers, abstractions, state stores, caches, retry/fallback wrappers, configuration knobs, dependencies, or compatibility exports, or when requested as a maintainability/simplification review.

## 1. Enforce Single Source of Truth and Existing Capability Reuse

Coding agents frequently invent local parallel machinery instead of reusing maintained repository primitives. Before accepting custom infrastructure, a duplicate helper/retry/cache/validation mechanism, parallel operational state, or a new package dependency:

- Search the repository and installed dependencies for existing owners covering the same concern.
- Compare **full contract fit**—inputs, error predicates, execution/locking order, attempt/capacity bounds, return values, final-error semantics, runtime compatibility, lockfile consistency, and operational cost—rather than matching by function name alone.

## 2. Audit Cohesion, Placement, and True vs. Ceremonial Decoupling

- **Cohesion:** keep logic governing one invariant, decision, or state lifecycle together so rules do not duplicate and drift across files; separate unrelated responsibilities that change for different reasons or carry distinct trust/lifecycle bounds.
- **Decoupling vs. wrapper theater:** verify that boundaries contain change and hide low-level storage shapes, third-party specifics, or hidden call-order requirements. Reject pass-through interfaces, extra indirection layers, or single-caller wrappers that mirror the underlying contract while multiplying maintenance surfaces.

## 3. Apply the Deletion Test and Reject Symptom Patching

Ask what required outcome, active consumer, established invariant, real boundary isolation, or reproduced failure mode would break if an added abstraction, unbounded or duplicate state store, fallback, config knob, or unused compatibility export/alias were deleted and callers used the semantic owner directly:

- **Deletion verdict:** if none breaks, require deleting the unsupported structure and **discard derivative findings** about polishing or hardening its internals (unless removing it affects an active consumer, persisted data, or security boundary).
- **Anti-symptom-patching:** reject defensive leaf checks (`?.`), broad fallbacks, ad-hoc adapters, or counterexample-narrow patches (partial whitelists, timing heuristics, or scattered state flags) added solely to mask broken invariants, unmodeled state transitions, or misplaced ownership.
- **Guard against overreview:** do not reject a focused local helper or explicit inline code merely for verbosity or style when it cleanly centralizes an established invariant without adding state, config, or public surface.
