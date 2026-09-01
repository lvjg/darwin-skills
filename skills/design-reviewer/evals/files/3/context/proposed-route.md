# Proposed route

Add an internal admin endpoint at the existing gateway.

1. The gateway authenticates and authorizes the administrator.
2. It sends the complete base-rule and environment-override draft snapshot plus the expected revision to the policy service.
3. The policy service applies its existing validation, precedence, atomic replacement and compare-and-swap semantics.
4. The gateway returns the new draft revision or the service's typed validation or revision-conflict error.
5. Publication remains the existing separate signed policy-service action.

The route introduces no new policy representation, state store, coordinator, compatibility path or runtime resolver.
