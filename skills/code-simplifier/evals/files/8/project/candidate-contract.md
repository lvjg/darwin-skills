# Candidate contract

The candidate makes `DeliveryPlanner` call the ParcelCloud SDK and translate its vendor exception directly.

- `DeliveryPlanner` owns the internal quote result `{ cents: <integer> }`.
- ParcelCloud's `fetch_rate` protocol and `ParcelCloud::Unavailable` error are external details and must not leak into `DeliveryPlanner`.
- The required internal failure is `RateUnavailable` with the original message.
- `ShippingRateGateway` in `lib/shipping_rate_gateway.rb` is the accepted boundary for the vendor call and error translation. Its internal contract is `fetch(postal_code) -> integer cents`; the project does not already provide it.
- There is one current consumer. The real protocol and error boundary, not hypothetical reuse, requires the gateway.
- Do not add a factory, registry, generic provider hierarchy, feature flag or speculative implementation.
- Do not change the vendor contract or quote behavior.

Validate the final project with `ruby test/verify_optimization.rb` from the project directory.
