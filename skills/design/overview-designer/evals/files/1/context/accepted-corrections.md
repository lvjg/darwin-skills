# Accepted corrections

These are authoritative user decisions for cutoffs after the route challenge.

- The workflow service should expose typed CRUD for stable `Node`, `Node Field` and `Edge` resources.
- Editing may be temporarily incomplete. Local writes preserve referential integrity; `finalize` owns global graph and publishability checks.
- An Edge is the only authoring representation that owns its outcome and optional typed condition. Remove competing global route rules and node-local duplicate route representations.
- Node participant binding, actions, guidance and constraints are typed node properties. They do not need separate CRUD unless an actual independent identity or consumer requires it.
- Do not expose arbitrary JSON Path patching or raw workflow expressions.
- Remove persistent source snapshots, evidence leaves, evidence dispositions, evidence references, coverage diagnostics and source-digest publication binding.
- Generic document reading is outside the Skill. The Skill's central maintained behavior is understanding supplied business text, producing an explicit temporary `TemplateIntent`, identifying unsupported or ambiguous requirements, and orchestrating CRUD without inventing missing facts.
- The model still cannot publish. Finalize and signed publication remain separate.
- The current delivery may use type checks, unit tests, integration tests and public-contract checks, but must not run E2E.
