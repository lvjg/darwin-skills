# Candidate contract

The candidate adds a timeout gateway between `PolicyLoader` and a vendor client.

- `PolicyLoader` owns assembly of the internal policy.
- `TimeoutGateway` owns the vendor call and must translate `VendorTimeoutError` into the internal `TimeoutUnavailable` error.
- The vendor exception type must not leak into `PolicyLoader`.
- There is currently one consumer. That alone is not permission to remove the protocol and error boundary.
- No other behavior or cleanup is authorized.

Run `ruby test/timeout_gateway_test.rb` from the project directory.
