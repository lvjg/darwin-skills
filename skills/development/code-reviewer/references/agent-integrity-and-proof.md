# Coding-Agent Integrity and Verification Honesty

Apply this lens when a candidate adds or modifies tests, mocks/fakes, fixtures, snapshots, test/compiler/linter configurations, production stubs/hardcoded branches/swallowed errors, or type/error escape hatches, when author verification claims accompany the change, or when requested as a test/proof audit.

## 1. Reject Fake Completeness, Hardcoding, and Escape Hatches

Coding agents under test or compiler pressure often silence errors rather than fixing root causes. Trace every suppression or shortcut to its underlying contract:

- **Stubs and narrow special-casing:** reject placeholder production branches, fake success returns, silent fallback defaults, swallowed partial/batch errors, and hard-coded input branches tailored strictly to sample fixtures.
- **Type, lint, and schema escape hatches:** inspect escape hatches—such as `any`, type-erasing casts (`as never`, `as unknown as`), `@ts-ignore`, `@ts-expect-error`, `# type: ignore`, `eslint-disable`/`nolint`, and loosened validation schemas—across production and test code against the real bound types to check whether they mask a contract break.

## 2. Audit Test Ownership, Boundary Fidelity, and Falsifiability

Run supplied safe local tests when authorized and verify that suites specify real domain contracts and fail when production behavior breaks:

- **Domain-owned suite organization:** verify that tests live in the suite owning the capability and execution boundary rather than spawning change-scoped files per patch or self-testing test-only scaffolding that owns no production or gate contract.
- **Boundary and double fidelity:** reject doubles or type-erased collaborator stubs that stand in for boundaries the suite can exercise directly, sever static contract checks, or drift from the real producer's schema, nullability, error codes, or async timing—as well as tests that bypass the real entrypoint pipeline to assert downstream outputs on hand-crafted intermediate state.
- **Fault-path activation proof:** for fault and recovery tests, verify proof that the fault was armed and hit the target branch before recovery assertions run.
- **Tautological and weakened assertions:** check whether tests copy buggy implementation formulas/constants into expected values, codify unapproved regressions or misleading error semantics, assert only call counts, internal collaborator calls, or shallow shapes while ignoring corrupted outputs or authoritative state, accept unverified snapshots, or `skip`/`todo` decisive failure cases.
- **Async and configuration honesty:** check for missing `await` on async assertions, order/timing flakiness, excluded changed files, or weakened `tsconfig`/test-runner/linter flags hiding failures.

## 3. State the Exact Proof Boundary

Reconcile every reported build, typecheck, or test claim against actual commands, final candidate HEAD (including post-simplification commits), and selected source bindings (for example, Node type-stripping execution is not a TypeScript compiler typecheck). Separate what local source and controlled doubles proved from unproven guarantees owned by persistent storage, concurrent execution, or live external systems, recording material unproven obligations as bounded `[EVIDENCE GAP]`s rather than invented defects or unrequested E2E mandates.
