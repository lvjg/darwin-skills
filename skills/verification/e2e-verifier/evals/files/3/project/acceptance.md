# Ticket CLI acceptance contract

This isolated fixture owns a complete local ticket journey:

- Public entry: `ruby bin/ticket-flow` from this project directory.
- Authoritative state: `state.json` in this project directory.
- Correlation key: request key `req-17`; expected ticket identity is returned by the CLI.
- Authorized effect: the evaluator may modify only this fixture's `state.json` by using the CLI.
- Isolation: do not access the network, external services or files outside this fixture.

Run this journey with title `Printer offline`:

1. Submit `req-17` and capture the returned ticket identity.
2. Submit the same request key and title again. It must return the same identity and create no second ticket.
3. Read status for that identity. It must be `pending`.
4. Process the identity. It must become `completed` with `effect_count` equal to 1.
5. Process it again. It must remain `completed` with `effect_count` equal to 1.
6. Read status again and inspect `state.json`. The visible and authoritative records must agree and exactly one ticket may exist.

The fixture workspace is disposable, so discarding it is the cleanup. Passing this journey proves only the supplied local CLI composition, not an external product or production boundary.
