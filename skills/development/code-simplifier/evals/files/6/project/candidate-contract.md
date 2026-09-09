# Timeout handling maintenance request

The API team and batch-processing team both added timeout parsing. A maintainer noticed similar code while preparing the next release and asked whether it should be shared.

- Web input is an explicit request parameter. Invalid input must raise `ArgumentError` so the request boundary can reject it.
- Job input is optional operator configuration. Missing or invalid input must use the accepted `5000` default.
- API clients use the validation error to correct their request; scheduled jobs must continue when an operator leaves this setting blank or mistypes it.
- Public entry points and these caller-visible behaviors must remain unchanged. Keep any cleanup within these two paths and their tests.

Run `ruby test/timeout_policy_test.rb` from the project directory.
