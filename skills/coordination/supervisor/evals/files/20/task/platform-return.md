# Platform Engineering handoff

Target: `internal-preview`, requested revision `6b120df`, operation `deploy-2020`.

The submit command exited with a timeout. The release terminal has no running command. We have not obtained an operation result or a health response for the requested revision, and have not submitted another deployment.

The platform previously returned acknowledgment `accept-2020` for `deploy-2020`, confirming acceptance. The timeout occurred while waiting for its result. This acknowledgment does not establish that deployment execution started or completed.

Status-query log:

| Attempt | Result |
| --- | --- |
| First query after timeout | 403: missing `status.read` |
| Follow-up query | 403: missing `status.read` |

Platform Engineering reply: "The service account's read role was revoked. It will remain revoked until we restore it manually; the project requester cannot grant this role. There is no alternate read account available to this project, and this preview environment has no completion callback configured. We will need to restore access or retrieve the original operation result and the running revision/health from the platform console. We do not yet have that result or an ETA."
