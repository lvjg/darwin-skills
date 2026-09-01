# Root intent

When an accepted configuration changes, the system must eventually compile the latest accepted revision and expose whether that revision succeeded or has an owned unresolved failure. Intermediate revisions may be superseded before compilation begins. Avoid continuous polling and new infrastructure when the existing durable delivery path can satisfy the result.

The initial suggestion to model this as a feedback controller is not an adopted constraint. It must be retained only if the actual system has a meaningful measured error, control input and stability obligation that require it.
