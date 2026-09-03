# Duplicate Order Suppression Design (draft)

**Design status:** Drafting

## Overall Design

Duplicate taps are a request-deduplication problem. API Gateway keeps a short-lived in-memory cache of recent `(device_id, request_fingerprint)` pairs. When a second matching request arrives within a two-second window, the gateway returns the cached response of the first without forwarding it to Order Service.

## Open items

- Cache TTL and eviction.
- Whether to share the cache across gateway instances via a distributed store.
- How support learns that a request was suppressed.
