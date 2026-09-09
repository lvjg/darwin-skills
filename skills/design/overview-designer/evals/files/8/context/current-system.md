# Current diagnostic request path

- An authenticated administrator requests the running build identity from Admin UI.
- Admin UI calls the authenticated administration Gateway and does not hold build-manifest credentials.
- Gateway reads the running application's immutable build manifest through the maintained diagnostics client.
- Build Service owns the manifest schema and meaning; Gateway owns administrator authorization and bounded projection; Admin UI owns presentation.
- Gateway returns build ID, source revision and build time. If the manifest read fails, Gateway returns an unavailable diagnostic result and Admin UI presents the unavailable state.
- These statements describe the current path only. No target change, defect, design decision or implementation request is part of this task.
