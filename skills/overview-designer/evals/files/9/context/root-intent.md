# Export job visibility intent

Operators must be able to see, for every tenant export job, its current state and the reason for its last failure, so that they can answer support tickets without reading logs.

The adopted route is confirmed: Export Service remains the sole owner of job state; the authenticated Operations Gateway projects a bounded job view to the Operations UI. Route replacement is not authorized.

This task is authorized as a within-route design revision. The design authority has accepted the new obligation described in `new-obligation.md` and asks that the existing design be completed to satisfy it. The artifact must record the substantive change with a revision record following the existing document convention.
