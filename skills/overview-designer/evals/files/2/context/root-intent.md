# Build provenance visibility intent

Administrators need to see exactly which application build is currently running before acting on support incidents.

- The visible result must include build ID, source revision and build time from the running deployment's own manifest.
- If provenance cannot be obtained, the UI must show it as unavailable rather than reuse a possibly stale value.
- Existing admin authentication remains mandatory.
- Adding deployment history, rollback controls, analytics or a new provenance store is outside scope.

The requested artifact is a system design suitable for independent Design Review. It is not authorization to implement or deploy.
