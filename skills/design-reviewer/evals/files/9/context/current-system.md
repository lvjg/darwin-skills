# Current system

- The access service owns request and approval state.
- `request_access` creates a request and returns `{ request_id, state: "submitted" }`.
- `get_access_request` returns `{ request_id, state: "pending | approved | rejected", decided_at }` from the access service.
- Neither tool grants access directly; a separate policy service enforces approved access.
- No planned prompt, model, or Harness configuration in this review has been deployed or run.
