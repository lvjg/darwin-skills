# Candidate contract

The candidate adds the required persistent import checkpoint plus an in-memory cache of the same offset.

- The last completed offset must survive process restart so an interrupted import can resume.
- `CheckpointStore` is the authoritative owner. It writes the checkpoint after a completed item, and a newly constructed store reads it when work resumes.
- Missing or corrupt checkpoint data recovers to offset `0`.
- Successful import completion calls `clear`; the checkpoint must then be absent.
- `CheckpointStore` is the only writer and reader.
- No latency or throughput constraint requires an in-memory cache. `CheckpointCache` has no independent consumer and adds a second state lifecycle.
- Delete the unsupported shadow state and its direct consequences without removing or replacing the required persistent state.

Validate the final project with `ruby test/verify_cleanup.rb` from the project directory.
