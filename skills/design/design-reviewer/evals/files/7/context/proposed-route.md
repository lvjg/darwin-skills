# Proposed route

- The application API authorizes the caller and requests the named flag from the configuration service.
- The configuration service evaluates targeting and returns its authoritative value and revision.
- The application API returns the value and revision without caching or reinterpreting the targeting rule.
- Authentication failure, missing flags, service timeout and invalid responses remain explicit failures.
