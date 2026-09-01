# Internal report download intent

Authorized administrators need to download the latest completed nightly usage report from the existing admin application.

- The result is a short-lived download link for the latest completed report.
- It is acceptable to return “no completed report” before the first successful generation.
- A signing outage should be visible as a temporary failure; serving an older cached link is not required.
- This is an internal-admin capability. Public sharing, report generation changes and download analytics are outside scope.

The user asks whether the proposed route is ready to implement.
