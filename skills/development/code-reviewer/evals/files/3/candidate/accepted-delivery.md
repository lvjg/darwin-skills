# Ledger retry delivery

Add transient-failure retry to `postLedgerEntry` for the next local commit.

Acceptance contract:

- Retry only `TransientLedgerError`.
- Make no more than three total attempts.
- Preserve the original success value and final error.
- Keep the existing `postLedgerEntry(entry)` public surface.
- Do not add runtime configuration, persistent state, or another public entrypoint.

The existing retry utility and the candidate implementation are included in this fixture. No external or E2E validation is required for this local commit decision.
