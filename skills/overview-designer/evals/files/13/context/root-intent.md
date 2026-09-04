# Tenant audit log retention intent

Each tenant's audit events use UTC calendar-day retention of 30, 90 or 365 days. A setting change takes effect at the next UTC day boundary. Every event in UTC day `D` uses the setting effective for `D`, remains readable through its retained calendar days, and must be unreadable from the start of its expiry day even if physical deletion runs later. Extending retention does not restore already expired data. Compliance must be able to prove, per tenant, what period was effective on any past UTC day.

The company currently operates in one region. Leadership has said the product "may expand to additional regions in the next couple of years"; there is no committed plan, no target region, no regulatory requirement identified and no budget assigned.

Route selection is delegated within the stated result. The artifact must be the target design for the single-region system in scope. Where a decision would be affected by a future multi-region deployment, the design should make clear what it deliberately leaves open and what it closes, without building for the uncommitted case.

Only `design/system-design.md` may be modified. Do not implement code.
