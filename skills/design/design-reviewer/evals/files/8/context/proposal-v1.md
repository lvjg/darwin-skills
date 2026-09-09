# Proposal version 1 — superseded

- Let each client assign the durable subscription identifier.
- Upsert by that client identifier without defining cross-client collision behavior.
- Return success after local request validation, before persistence is confirmed.

This revision is retained only as history and is not the review candidate.
