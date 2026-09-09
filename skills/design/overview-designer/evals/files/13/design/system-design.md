# Audit Log Retention Design (draft)

**Design status:** Drafting

Retention has not been designed. An engineer has suggested introducing a "retention control plane" with a region-aware policy registry, cross-region replication of retention decisions, and a pluggable deletion backend, so that multi-region expansion is "already handled". Whether any of that is warranted is undecided.
