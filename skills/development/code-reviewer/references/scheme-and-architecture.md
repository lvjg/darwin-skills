# Overall Scheme and Key Design Alignment

Apply this lens when an agreed design, ADR, or specification exists, when the change spans module or layer boundaries or alters core domain/state models, or when requested as an architecture review. Complete this lens **before** inspecting line-level implementation details.

## 1. Reconstruct the Implemented Scheme Above the Hunk Level

Step back from file-by-file diffs and reconstruct the mechanism the code actually delivers across entrypoints, module interfaces, core data/state structures, dependency directions, and control flows. Identify what is locked by authoritative baseline contracts versus what internal structure the author chose freely. Hold off on local syntax, null-check, or style scrutiny until the overall structure is judged.

## 2. Check Design-to-Code Fidelity and Silent Omissions (Forward Audit)

Compare the reconstructed code topology directly against the agreed scheme, key design decisions, and repository architecture:

- **Boundary and semantic owner fidelity:** verify that business rules, state transitions, invariants, and authority checks land in the agreed semantic owner rather than drifting into callers, controllers, UI handlers, or transport adapters for convenience.
- **Layering and dependency direction:** check whether cross-layer imports, shared mutable state, or leaked storage/third-party shapes punch through intended module boundaries.
- **Obligation and mechanism completeness:** verify that required normal flows, failure/recovery transitions, and key design invariants were genuinely implemented rather than downgraded into hard-coded special cases, partial happy-path shortcuts, or silent requirement omissions.

## 3. Identify Implementation-Exposed Design Flaws (Reverse Audit)

Do not reopen settled design routes out of personal preference. However, test whether concrete repository reality—actual call graphs, type lifecycles, ownership boundaries, transaction/concurrency semantics, or external contracts—disproves a premise of the agreed design:

- **Recognize structural collision symptoms:** treat cyclic or shotgun cross-module coupling, split state authority, synchronous/transactional assumptions forced onto asynchronous or non-transactional owners, and clusters of brittle local workarounds as evidence of a root design conflict rather than isolated coding mistakes.
- **Audit unprescribed schemes on first principles:** where no prior design locked the internal approach, verify that the chosen mechanism solves the root problem at the boundary that owns it rather than patching a downstream symptom or introducing a broken state/consistency model.
- **Escalate rather than patch:** when concrete code facts prove an agreed design premise cannot hold cleanly, report the proven design-reality conflict and the minimum design or contract decision required from its owner—do not prescribe local hacks to paper over it, and do not author a speculative replacement architecture.
