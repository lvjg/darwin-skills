# Archive-size delivery

Add an archive-size guard for the next local commit.

Acceptance contract:

- Reject an archive when `byteLength` is greater than or equal to 8 MiB.
- Reject it before calling the archive store.
- Write every smaller archive exactly once.
- Preserve the existing `saveArchive(archive)` public surface.

The supplied implementation, test change, and validation report are the complete candidate evidence for this local commit decision.
