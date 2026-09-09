export class TransientDeliveryError extends Error {}

export interface WebhookEvent {
  id: string;
  body: string;
}

export interface DeliveryReceipt {
  deliveryId: string;
}
