# Current system facts

- The build service creates an immutable manifest containing build ID, source revision and build time for every application image.
- The running application can read its own manifest through a maintained library. The build service owns the manifest schema and meaning.
- The authenticated admin gateway already proxies read-only application diagnostics to the admin UI.
- The browser has no manifest-storage credential and must not receive one.
- The UI already has standard loading, unavailable and retry presentation states for diagnostics.
- No active consumer or contract requires provenance history, cross-deployment aggregation or offline availability.
