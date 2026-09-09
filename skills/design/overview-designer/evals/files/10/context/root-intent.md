# Duplicate order suppression intent

One checkout must create at most one order and therefore charge and ship exactly once, whether duplicate submission comes from repeated taps, an automatic retry after a gateway timeout, or a user retry after an indeterminate response. Support must be able to explain any suppressed duplicate.

The draft design frames this as a request-deduplication problem at the API edge. That framing is the draft author's proposal, not a constraint; the design authority asks for the target design that actually satisfies the result given the system facts. Route selection is delegated within the stated result and constraints.

Only `design/system-design.md` may be modified. Do not implement code.
