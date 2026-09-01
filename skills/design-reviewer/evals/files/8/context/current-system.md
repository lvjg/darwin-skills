# Current-system snapshot

- The notification service owns subscription identity, persistence and delivery eligibility.
- Its maintained store supports atomic uniqueness on server-assigned subscription identifiers.
- The existing API boundary already authenticates the caller and maps service errors without changing their meaning.
- No active consumer depends on client-assigned subscription identifiers.
