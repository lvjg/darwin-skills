# Current system

- The incident service owns incident identity, severity, status and an ordered timeline containing typed confirmed facts, hypotheses and unresolved questions.
- An existing maintained reader obtains a consistent incident snapshot by identifier and rejects missing, unauthorized or schema-invalid records before model invocation.
- The Harness can pass that validated snapshot directly to the model and display the returned text to the requesting operator.
- This interaction exposes no action tools and changes no incident-service state.
