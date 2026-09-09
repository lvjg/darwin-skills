# Shard-key delivery

Add an internal `formatShardKey(tenantId, documentId)` helper for the next local commit.

Acceptance contract:

- Trim both identifiers and reject either when blank.
- Encode each trimmed identifier with `encodeURIComponent`.
- Join the encoded identifiers with `/`.
- Use the helper in the supplied document lookup.
- No public API, migration, configuration, or external validation is required.
