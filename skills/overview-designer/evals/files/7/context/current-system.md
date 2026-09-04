# Current system facts

- Account Service, Campaign Service and Support Service each persist an independently writable copy of notification preferences.
- Each service accepts writes through its own API. No copy is authoritative, and conflicting updates can arrive in different orders.
- A nightly reconciliation job chooses the most recent timestamp, but clocks are not an accepted business authority and the one-minute result cannot be established by this route.
- Campaign Service and Support Service are active decision consumers. Account Service owns the current user-facing edit entry but is not the assigned target authority.
- Preference Service already exists as a maintained service boundary but does not yet own these preferences.
- The platform event bus provides durable at-least-once delivery. Active consumers can apply an immutable preference revision idempotently and expose their applied revision.
- Preference Service can return the authoritative current decision and immutable revision to authenticated notification consumers. Campaign Service and Support Service can compare that revision with a local projection immediately before sending and can withhold the send with an owned unavailable result when the authoritative decision cannot be obtained or the projection is stale.
- No external consumer requires the three writable schemas or the nightly reconciliation contract to remain after cutover.
