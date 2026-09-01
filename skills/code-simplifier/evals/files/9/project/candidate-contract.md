# Candidate contract

The candidate duplicates the same limit rule in the API and Job entry paths.

- `ApiLimit.apply` and `JobLimit.apply` are required entry contracts and must remain.
- Both consumers use the same rule: parse the requested value, clamp it to the established maximum `100`, and use `100` when input is missing or invalid.
- The rule, failure behavior and reason for change are identical. This is duplicated knowledge, not merely similar syntax.
- `LimitPolicy` in `lib/limit_policy.rb` is the accepted internal owner that centralizes the invariant; no runtime variation or configuration is required.
- Do not merge or rename the API and Job entry contracts.
- Do not add a strategy hierarchy, factory, injection framework or configuration.

Validate the final project with `ruby test/verify_optimization.rb` from the project directory.
