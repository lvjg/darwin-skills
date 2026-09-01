# Proposed route

- Save the catalog item and an outbox row in one database transaction.
- Run a worker that retries the search-service refresh until it succeeds.
- Persist attempt history, move exhausted work to a dead-letter queue and add a reconciliation job.
- Treat a successful catalog save as complete in the interface while hiding transient refresh failures.
- Promise eventual index refresh for every accepted request.
