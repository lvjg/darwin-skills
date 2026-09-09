# Shard-key delivery

Document lookup currently constructs cache keys inline; identifiers containing `/` can collide across tenant/document boundaries. The ingestion worker already stores keys using per-segment encoding.

Add an internal `formatShardKey(tenantId, documentId)` helper for the next local commit.

Acceptance contract:

- Trim both identifiers and reject either when blank.
- Encode each trimmed identifier with `encodeURIComponent`.
- Join the encoded identifiers with `/`.
- Use the helper in the supplied document lookup.
- The process-local cache and ingestion key format remain unchanged. This change affects key construction in the lookup only; no migration or external validation is required.

`document-records.ts` is existing context. Review the helper and lookup change; the supplied test runs against the local cache.
