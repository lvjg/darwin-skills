# Current-system snapshot

- The configuration service is the authoritative owner of feature-flag values and targeting decisions.
- It already exposes an authenticated read operation for the application API.
- The application API already has the required service identity and timeout policy.
- No new durable state, compatibility path or external contract is needed for this lookup.
