# Duplicate order suppression intent

A customer who taps "Place order" more than once within a short window must be charged and shipped exactly once. Support must be able to explain any suppressed duplicate.

The draft design frames this as a request-deduplication problem at the API edge. That framing is the draft author's proposal, not a constraint; the design authority asks for the target design that actually satisfies the result given the system facts. Route selection is delegated within the stated result and constraints.

Only `design/system-design.md` may be modified. Do not implement code.
