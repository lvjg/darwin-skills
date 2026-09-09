# Export job visibility intent

Operators must be able to see, for every tenant export job, its current state and the reason for its last failure, so that they can answer support tickets without reading logs.

The adopted route is confirmed: Export Service remains the sole owner of job state; the authenticated Operations Gateway projects a bounded job view to the Operations UI. Route replacement is not authorized.

This task is an accepted intent change within the existing adopted route. The design authority has accepted the new obligation described in `new-obligation.md`; the route remains confirmed and must not be replaced. The artifact must record the substantive change with a revision record following the existing document convention.
