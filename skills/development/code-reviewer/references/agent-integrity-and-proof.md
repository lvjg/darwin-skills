# Coding-Agent Integrity and Verification Honesty

Apply this lens when a candidate adds or modifies tests, mocks/fakes, fixtures, snapshots, test/compiler/linter configurations, production stubs/hardcoded branches/swallowed errors, or type/error escape hatches, when author verification claims accompany the change, or when requested as a test/proof audit.

## 1. Reject Fake Completeness, Hardcoding, and Escape Hatches

Coding agents under test or compiler pressure often silence errors rather than fixing root causes. Trace every suppression or shortcut to its underlying contract:

- **Stubs and narrow special-casing:** reject placeholder production branches, fake success returns, silent fallback defaults, swallowed partial/batch errors, and hard-coded input branches tailored strictly to sample fixtures.
- **Type, lint, and schema escape hatches:** inspect `any`, unsound casts (`as unknown as`), `@ts-ignore`, `@ts-expect-error`, `# type: ignore`, `eslint-disable`/`nolint`, and loosened validation schemas against the real bound types in source to check whether they mask an actual contract break.

## 2. Falsify Test Suites Against Mutation and Over-Mocking

Run supplied safe local tests when authorized and audit whether the tests can actually fail when production behavior breaks:

- **Tautological and weakened assertions:** check whether tests copy buggy implementation formulas/constants into expected values, assert only call counts or shallow shapes while ignoring corrupted outputs, accept unverified snapshots, or `skip`/`todo` decisive failure cases.
- **Mock boundary and schema fidelity:** reject mocks or in-memory doubles that replace the exact boundary under test or drift from the real producer's schema, nullability, error codes, or async timing. For fault/recovery tests, verify proof that the fault was armed and hit the target branch before recovery assertions run.
- **Async and configuration honesty:** check for missing `await` on async assertions, order/timing flakiness, excluded changed files, or weakened `tsconfig`/test-runner/linter flags hiding failures.

## 3. State the Exact Proof Boundary

Reconcile every reported build, typecheck, or test claim against actual commands and selected source bindings (for example, Node type-stripping execution is not a TypeScript compiler typecheck). Separate what local source and controlled doubles proved from unproven guarantees owned by persistent storage, concurrent execution, or live external systems, recording material unproven obligations as bounded `[EVIDENCE GAP]`s rather than invented defects or unrequested E2E mandates.
