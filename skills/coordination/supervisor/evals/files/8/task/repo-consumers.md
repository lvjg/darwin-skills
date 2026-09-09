# Repository consumer audit

- Authority: Connector repository consumer inventory
- Repository revision: `a18c7e3`
- Search scope: runtime code, template registry, Draft and returned Task flows, Resubmit handlers, deployment manifests
- Result: every active request-time call site resolves `connector-v2`; no runtime, template, Draft, returned Task, Resubmit or deployment consumer references `connector-v1`
- Remaining reference: `docs/migrations/connector-v1.md` is historical documentation and is not loaded or published at runtime
- Effects: read-only inventory; no repository object changed
- Unknowns: none within the stated repository revision and search scope
