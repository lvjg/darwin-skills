# Webhook retry delivery

Add transient-failure retry to `deliverWebhook` for the next local commit.

Acceptance contract:

- Retry only `TransientDeliveryError`.
- Make no more than three total attempts.
- Preserve the original success value and final error.
- Preserve the existing `deliverWebhook(event)` public surface.

No implementation route is prescribed. The supplied files contain the complete production module, its current caller, the existing retry utility, and focused validation evidence.
