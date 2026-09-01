# Proposed route

Add `GET /internal/reports/latest/download` to the existing API service.

1. Reuse the API service's existing administrator authorization.
2. Read the latest completed row from the report catalog, ordered by completion time and stable report ID.
3. Return `404 no_completed_report` when none exists.
4. Ask the maintained object-store library for a five-minute signed URL for that row's object key.
5. Return the URL, report completion time and checksum. If signing fails, return the existing temporary-dependency error and do not fall back to a stale URL.

The report generator remains the only writer and completion owner. The API service owns authorization and selection for its admin consumer. The route introduces no new state, cache, queue, event or download proxy. Unit tests cover authorization and selection; an integration test covers catalog selection plus signer success/failure. Real runtime behavior remains implementation evidence.
