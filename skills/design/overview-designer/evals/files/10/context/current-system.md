# Current system facts

- The mobile app sends `POST /orders` through the API Gateway to Order Service. Each tap produces a new HTTP request with a fresh `request_id`; the app does not reuse a client key across retries and cannot be changed in this delivery.
- API Gateway is stateless and horizontally scaled; requests from one device may reach different gateway instances.
- Order Service creates an `Order` row and then publishes `OrderPlaced` to the durable event bus. Payment Service and Fulfillment Service consume `OrderPlaced` and each performs its effect exactly once per `order_id`, keyed on `order_id`.
- Incident review of the last ninety days shows that 71% of duplicate charges did not involve two requests within any dedup window. They occurred when the mobile app retried after a gateway timeout of 30 seconds or more, and in 18 cases the second request arrived more than five minutes after the first. The remaining 29% were two taps within two seconds.
- Order Service already receives, but does not use, the cart's `checkout_session_id`, which the Cart Service creates once per checkout and invalidates when an order is confirmed. Cart Service owns the meaning of `checkout_session_id`.
- Order Service has a unique constraint available on any column it chooses to add to `Order`.
- No consumer requires a customer-visible list of suppressed duplicates; support reads Order Service records directly.
