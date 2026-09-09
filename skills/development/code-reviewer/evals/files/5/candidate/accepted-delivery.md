# Webhook retry delivery

The shipping service sends order status events to a partner. Operations currently replays events manually after transient partner failures. The existing partner contract deduplicates by event ID.

Add transient-failure retry to `deliverWebhook` for the next local commit.

Acceptance contract:

- Retry only `TransientDeliveryError`.
- Make no more than three total attempts.
- Preserve the original success value and final error.
- Preserve the existing `deliverWebhook(event)` public surface.

No implementation route is prescribed. `webhook-delivery.ts` is the submitted change. The caller, transport, types and `retry-transient.ts` utility are existing context. The supplied test replaces the transport for local verification; live partner delivery is outside this review.
