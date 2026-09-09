# Current system facts

- Export Service owns an export job record with `job_id`, `tenant_id`, `state` (`queued`, `running`, `succeeded`, `failed`) and `updated_at`.
- Export Service already records the failure cause internally as a structured `failure_code` and a free-text `failure_detail` on the job record when a job enters `failed`. Both fields are stable and owned by Export Service; neither is currently exposed through any contract.
- The Operations Gateway currently exposes `GET /ops/exports/{job_id}` returning `job_id`, `tenant_id`, `state` and `updated_at`. It owns operator authorization and bounded projection.
- Operations UI presents the current gateway response and already has an unavailable state.
- `failure_detail` may contain tenant data paths. The security owner has ruled that `failure_detail` must not leave Export Service; `failure_code` may be projected to authorized operators.
- No consumer requires failure history, retry controls or notification.
