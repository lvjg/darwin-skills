# Cross-Boundary Closure and Implicit Blast Radius

Apply this lens when a change modifies cross-module or cross-service interfaces, public or persisted schemas, shared unions/enums, entrypoint wiring, handlers/stateful writers/config keys whose production registration or sibling routes must close, business or authority guards with potential bypass routes, or replaces/migrates an existing execution path, or when requested as a closure/integration review.

## 1. Break Out of the Diff Window via Repository Graph Search

An uninspected file outside the diff is not proof of safety. Use deterministic symbol, reference, and text search across untouched files to pull real producers, consumers, configuration bindings, and enum/union switches into scope before judging closure.

## 2. Reconcile End-to-End Wiring and Symmetric Lifecycles

- **Production entrypoint wiring:** trace backward from changed handlers, helpers, tool bindings, schemas, config keys, and build artifacts to confirm they are registered and reachable in active production entrypoints rather than imported only in tests or dead branches.
- **Lifecycle symmetry:** verify that paired paths stay consistent across write/read, encode/decode, serialize/deserialize, allocate/release, and create/cleanup—including early-return, cancellation, and error paths.
- **Side-by-side producer and consumer contracts:** trace material payload, return-value, error-code, nullability, and limit changes across wrappers, adapters, decoders, and callers on both sides. Check for dropped fields, omitted union/capability variants, downstream validation limits stricter than upstream mutating writers, and unversioned breaking changes.

## 3. Close Sibling, Replacement, and Rolling-Coexistence Paths

- **Sibling and bypass routes:** check whether batch, retry, replay, webhook, CLI, admin, maintenance, or fallback paths bypass a newly added rule or silently lose existing authorization, tenant isolation, idempotency, cancellation, or boundary (`>=` vs `>`) guards during a rewrite.
- **Replacement and cutover completeness:** when superseding an old path, verify that active callers reach the new path and obsolete paths are either removed or explicitly bounded with an owner and removal condition.
- **Mixed-version coexistence (`old <-> new`):** when persisted records, cache entries, queue payloads, or wire contracts change, trace `old writer -> new reader`, `new writer -> old reader`, and rollback residue so rolling deployments or destructive DDL do not break active versions.
