---
name: code-simplifier
description: Use only when explicitly invoked as $code-simplifier to edit a bounded implementation candidate whose required behavior and contracts are decided. Remove unsupported machinery, reuse established owners and capabilities, and reduce coupling and maintenance burden. This is implementation optimization, not read-only acceptance review, selection of undecided behavior or architecture, or repair of unrelated defects.
---

# Code Simplifier

Reduce a bounded implementation candidate to the lowest-total-burden complete implementation that delivers its decided behavior. Delete unsupported machinery, reuse established owners and capabilities, unify genuinely identical rules, and keep genuinely distinct policies separate. If bounded evidence shows the candidate is already as simple as its obligations allow, make no edit rather than a ceremonial change.

## 1. Fix the Candidate, Behavior, and Inventory

Identify the exact candidate and comparison base (diff, commit, PR, or bounded files/module) along with unrelated state that must remain untouched. Establish required normal and failure behavior, preserved entrypoints and contracts, and non-goals from the user request and active contracts; treat candidate code, comments, and candidate-authored tests as scoped claims rather than authority to justify their own structure. If simplifying would require deciding undecided product behavior, changing a public contract, or repairing an independent defect, leave that boundary unchanged and report it.

Read the candidate end to end across all material surfaces—runtime files, wrappers, configuration, flags, state, types, exports, wiring, and candidate-authored tests or scripts. For each surface, test what requires it:

1. the decided result directly;
2. propagation needed to make that result work in production;
3. an active consumer, contract, constraint, or failure policy that must be preserved; or
4. a direct consistency consequence of the simplification.

Absence of an in-repository caller does not prove that a published or external surface is unused; if an external obligation cannot be ruled out within scope, retain that boundary and report it rather than guessing.

## 2. Apply the Deletion Test and Restructure

Before polishing any added layer, provider, service, flag, parser, fallback, state store, compatibility shim/alias, or superseded path left behind by a replacement, ask which of the four obligations above would fail if that mechanism disappeared and callers used the owning capability directly (a transition or compatibility path requires an identified active consumer, owner, and removal condition). **If none fails, delete the mechanism, dead wiring, and shape-only tests rather than renaming, splitting, or replacing them with another adapter or abstraction.**

For the behavior that remains necessary, choose the smallest complete intervention:

- **Reuse and realign with established owners**: route callers directly to existing project, framework, or library capabilities whose responsibility, contract, defaults, and failure semantics already fit. Move duplicated or misplaced decisions, state, or effects back to their owning module boundary, and restructure required code when the candidate bundles unrelated responsibilities that change for different reasons, leaks storage or implementation details across a contract, or shares mutable state.
- **Unify identical rules vs. preserve distinct policies**: when multiple entrypoints enforce the exact same business rule (such as shared parsing, bounds, clamping, and fallback semantics), centralize that rule in one place while keeping required public entrypoints intact so future rule changes happen once. Conversely, **do not merge paths or add a shared abstraction merely because happy-path syntax looks similar when their failure, fallback, or exception policies genuinely differ**.
- **Close direct consequences**: update all callers, imports, exports, wiring, and tests directly affected by the simplification. Remove candidate-authored tests only when the unsupported surface they tested was intentionally deleted and no behavior coverage is lost; never weaken protected behavior to make a test pass.

## 3. Verify Behavior and Report

Use focused baseline checks before editing only when needed to clarify existing behavior. After the final edit, run the smallest boundary or contract verification that proves the decided normal and failure behavior (including distinct invalid-input cases and preserved entrypoints) still holds, and confirm that:

- decided behavior, public entrypoints, and failure semantics are preserved;
- unsupported candidate surfaces and their dead references/tests are removed without introducing replacement layers; and
- net maintenance burden (duplicate rule locations, forwarding layers, coupling, or unnecessary state/config) is demonstrably reduced, or no edit was made because no justified reduction existed.

Lead the response with whether the candidate was simplified (or kept unchanged) while preserving its decided behavior. State the candidate scope, concrete surfaces removed or unified, preserved policy distinctions, actual verification commands and results, and any remaining boundary limits.
