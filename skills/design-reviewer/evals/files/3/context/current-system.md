# Current system

- The policy service owns draft persistence, policy validation, publication and runtime resolution.
- Its existing policy model has two writable domains: base rules and environment overrides. The service defines an environment override as taking precedence over the same base-rule key; absence means inheritance. Duplicate keys inside either domain and references to unknown environments are rejected.
- The service returns one authoritative effective policy for an environment after applying those rules.
- Drafts are replaced as complete snapshots. The existing contract defines omission as deletion, validates all references atomically and uses revision compare-and-swap. A failed replacement changes nothing.
- Published policy versions are immutable and remain active until a separate signed publication action selects a valid draft version.
- The admin gateway already authenticates administrators and keeps no policy state.
- No active consumer requires partial mutation, preservation of draft object identity across replacements or simultaneous editing.
