import { deliverWebhook, type WebhookEvent } from "./webhook-delivery";

export async function dispatchWebhook(event: WebhookEvent): Promise<string> {
  const receipt = await deliverWebhook(event);
  return receipt.deliveryId;
}
