# Tenant audit log retention intent

Each tenant's audit events must be retained for exactly the retention period configured for that tenant (30, 90 or 365 days) and become unreadable after it. Compliance must be able to prove, per tenant, what the effective period was on any past date.

The company currently operates in one region. Leadership has said the product "may expand to additional regions in the next couple of years"; there is no committed plan, no target region, no regulatory requirement identified and no budget assigned.

Route selection is delegated within the stated result. The artifact must be the target design for the single-region system in scope. Where a decision would be affected by a future multi-region deployment, the design should make clear what it deliberately leaves open and what it closes, without building for the uncommitted case.

Only `design/system-design.md` may be modified. Do not implement code.
