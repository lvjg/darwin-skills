# Adopted surrounding design and current contracts

- Export Service owns export completion and the immutable `artifact_ref`, `artifact_digest`, and `export_id`. A completed export is handed to Download Gateway through the adopted surrounding design.
- Access Service owns the authorization decision for `(actor_id, tenant_id, export_id)`. Its active contract returns only `allow | deny`; it has no stable denial reason code. The Access Service owner has not accepted a contract change.
- Download Gateway owns authenticated request handling, validation of the completed-export handoff, bounded projection of the authorization result, and invocation of the object-store signer after an `allow` decision. It does not own export state or authorization meaning.
- The maintained object-store signer accepts an immutable `artifact_ref` and returns a URL that expires after five minutes. The browser never receives object-store credentials.
- No active consumer requires authorization caching, download history, offline authorization, or a second copy of export or access state.
