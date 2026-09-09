# Candidate contract

The candidate contains two timeout parsing paths with similar happy-path syntax.

- Web input is an explicit request parameter. Invalid input must raise `ArgumentError` so the request boundary can reject it.
- Job input is optional operator configuration. Missing or invalid input must use the accepted `5000` default.
- These are intentionally different failure policies, not accidental duplication.
- No other simplification or behavior change is authorized.

Run `ruby test/timeout_policy_test.rb` from the project directory.
