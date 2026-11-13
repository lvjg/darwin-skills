# Accepted design and delivery contract

Implement workspace seat reservation across single-member invites and batch CSV member imports for local commit review.

Agreed architectural design:

- **Single domain owner (`QuotaLedger`):** `reserveSeats` in `quota-ledger.ts` is the sole semantic owner for workspace seat reservation across both `inviteMember` and `importMembersBatch`. Entry handlers normalize email inputs (trimming whitespace, lowercasing, ignoring blank CSV rows, deduplicating repeated emails within a batch, and rejecting missing/malformed email strings with `TypeError` before reservation) and delegate seat reservation to `QuotaLedger`; handlers must never read/write `QuotaStore` directly or duplicate eligibility checks.
- **Required domain invariants:** Only `workspace_admin` actors may reserve seats, suspended workspaces must be rejected before any seat count changes, and total `usedSeats` must never exceed `maxSeats` (enforced via `QuotaStore` revision compare-and-swap).
- **Audit guarantee:** Every committed seat reservation must guarantee a durable `seat_reserved` audit record before returning `auditCommitted: true` to callers. The design specified keeping `QuotaLedger.reserveSeats` synchronous and recording the audit entry inline via `AuditQueue` during the reservation call.

`quota-ledger.ts` and `seat-handlers.ts` are the candidate implementation changes; `quota-store.ts` and `audit-queue.ts` are existing maintained repository modules whose public contracts are shared by other services and outside this change's edit scope. Live external audit storage and E2E journeys are outside this review.
