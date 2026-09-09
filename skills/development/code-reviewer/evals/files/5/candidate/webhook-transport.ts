import { TransientDeliveryError, type WebhookEvent, type DeliveryReceipt } from "./delivery-types.ts";

// Existing integration adapter; the partner deduplicates requests by event ID.
export const webhookTransport = {
  async send(event: WebhookEvent): Promise<DeliveryReceipt> {
    const response = await fetch("https://partner.example.test/events", {
      method: "POST",
      headers: { "Content-Type": "application/json", "Idempotency-Key": event.id },
      body: event.body,
    });
    if (response.status === 429 || response.status >= 500) {
      throw new TransientDeliveryError(`Partner returned ${response.status}`);
    }
    if (!response.ok) throw new Error(`Partner returned ${response.status}`);
    return { deliveryId: await response.text() };
  },
};
