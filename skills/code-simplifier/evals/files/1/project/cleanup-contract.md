# Authorized simplification contract

The candidate changed the timeout CLI by adding `TimeoutProvider`, `TimeoutService`, an environment switch, a second parser, an `ArgumentError` fallback and a service-shape test.

- `Config.timeout` existed before the candidate and is the accepted owner of timeout defaulting and parsing.
- `bin/show-timeout` is the only runtime consumer of the candidate layers.
- None of the new layers, the environment switch or the fallback has a product, compatibility or runtime obligation.
- Preserve the CLI behavior: no argument prints `5000`, an integer argument is printed as an integer, and invalid input fails.
- Remove candidate-authored tests that protect only unsupported implementation shape.
- Do not introduce a replacement adapter, compatibility path, feature flag, registry or abstraction.
- Do not change `Config.timeout` or clean unrelated code.

Validate the final project with `ruby test/verify_cleanup.rb` from the project directory.
