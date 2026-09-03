# Current system facts

- Audit Service receives audit events from all product services and appends them to a single append-only store partitioned by `tenant_id` and event day. It owns event meaning and the append contract.
- Tenant Config Service owns per-tenant settings, including `audit_retention_days`, and emits `TenantSettingChanged(tenant_id, key, old, new, changed_at)` on the durable bus. It already keeps a full change history per setting.
- Audit Service currently applies no retention; the store has grown since launch.
- A nightly maintenance job framework exists and is used by other services to run per-tenant tasks.
- Deletion of a partition is atomic and cheap; deletion of individual events within a partition is not supported by the store.
- Compliance reads are made by a small internal tool that queries Audit Service; there is no external consumer of the retention decision.
- The store, the maintenance framework and the bus are all region-scoped resources. Nothing in the current platform is multi-region.
