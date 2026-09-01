# Regional policy availability intent

When an administrator publishes an accepted tenant policy revision, every active regional runtime must begin serving that accepted revision within five seconds or expose that the region is not yet able to serve it. Policy Service owns policy validation, accepted content and immutable revision identity.

Intermediate accepted revisions may be superseded before a region applies them. The design does not require policy history, rollback controls, offline administration, cross-region analytics or serving more than one accepted revision at a time. This is a greenfield target-design request; no existing production implementation or defect is asserted. Route selection is delegated within these result and scope bounds.
