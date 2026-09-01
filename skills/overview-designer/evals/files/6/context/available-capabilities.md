# Available maintained capabilities

- Policy Service can persist an immutable accepted policy by `(tenant_id, policy_revision)` and return it to authenticated regional services.
- The existing regional message bus provides durable at-least-once delivery and can carry `PolicyRevisionAccepted(tenant_id, policy_revision)` to every active region.
- A regional runtime already has a small durable local store suitable for its currently applied policy and revision.
- Regional policy application can be made idempotent by `(tenant_id, policy_revision)`.
- The platform already exposes regional health and revision-lag diagnostics to operators.
- No second policy authority, global cache, polling controller or additional event system is required by an active consumer or contract.
