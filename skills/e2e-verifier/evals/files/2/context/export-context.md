# Asynchronous export acceptance context

An authorized administrator can request a CSV export from the admin web application. The API creates an export job, a worker writes one immutable object, and the UI polls status until a download becomes available.

## Material obligations

- The real admin entry shows `queued`, then a decidable terminal state.
- A completed job has exactly one authoritative object record and exposes a download whose checksum matches that record.
- Repeating the same request key must not create a second job or object.
- Cancellation before object commit reaches `cancelled` and leaves no object.
- If cancellation races with object commit, the system must expose the authoritative winner rather than display `cancelled` while retaining an orphan object.

## Existing focused evidence

- API authorization tests cover administrator and non-administrator identities.
- Exporter unit tests cover CSV escaping, column selection, row limits and empty data.
- Worker integration tests cover job claiming and object-write retry.

## Planning boundary

The staging admin entry, job API and object-store inspection capability are known, but this task authorizes case derivation only. It does not authorize starting, cancelling, downloading or cleaning up an export. No product execution evidence is attached.
