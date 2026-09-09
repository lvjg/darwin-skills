# Current-system snapshot

- The catalog service owns the durable database item.
- The search service owns the index and exposes an idempotent refresh operation.
- The current admin interface can show refresh failure and let an administrator retry manually.
- No active external contract requires eventual index refresh.
- The system has no durable job, outbox, dead-letter queue or reconciliation loop for this path.
