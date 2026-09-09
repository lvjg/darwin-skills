# Corrected evidence

- The adopted target route remains Build Service -> authenticated Gateway -> Admin UI.
- Build Service remains authoritative for the immutable build manifest; Gateway projects it to authorized administrators; Admin UI only presents the result.
- The source document previously named `/build-info`, but that endpoint never existed in the active implementation.
- The authoritative current owner contract is `GET /internal/build-manifest`, returning `build_id`, `source_revision`, `built_at`, and `artifact_digest`.
- The confirmed administrator-visible projection remains `build_id`, `source_revision`, and `built_at`. `artifact_digest` is part of the owner contract but has not been accepted as a new UI result.
- This is an evidence correction only. The design authority explicitly confirms that the target route, result, constraints and acceptance meaning are unchanged.
- No active consumer depends on `/build-info`, and no compatibility or migration obligation exists.
