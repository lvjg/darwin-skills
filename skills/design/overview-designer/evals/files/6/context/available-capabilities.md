# Available maintained capabilities

- Policy Service can persist an immutable accepted policy by `(tenant_id, policy_revision)` and return it to authenticated regional services.
- The existing regional message bus provides durable at-least-once delivery and can carry `PolicyRevisionAccepted(tenant_id, policy_revision)` to every active region.
- A regional runtime already has a small durable local store suitable for its currently applied policy and revision.
- Regional policy application can be made idempotent by `(tenant_id, policy_revision)`.
- Policy Service records `accepted_at` for each accepted revision. The maintained regional readiness diagnostic compares the latest accepted revision with each active region's applied revision and, no later than five seconds after `accepted_at`, exposes either `policy_ready` for that revision or `policy_lagging`. The regional serving gateway returns policy unavailable rather than present a lagging revision as current while `policy_lagging` holds.
- No second policy authority, global cache, polling controller or additional event system is required by an active consumer or contract.
