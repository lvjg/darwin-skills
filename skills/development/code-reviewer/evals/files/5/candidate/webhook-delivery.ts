export class TransientDeliveryError extends Error {}

export interface WebhookEvent {
  id: string;
  body: string;
}

export interface DeliveryReceipt {
  deliveryId: string;
}

declare function sendWebhook(event: WebhookEvent): Promise<DeliveryReceipt>;

class RetryPolicy {
  private readonly attemptsByEvent = new Map<string, number>();

  async execute<T>(
    eventId: string,
    operation: () => Promise<T>,
    isTransient: (error: unknown) => boolean,
  ): Promise<T> {
    let attempt = 0;

    while (true) {
      try {
        return await operation();
      } catch (error) {
        attempt += 1;
        this.attemptsByEvent.set(eventId, attempt);
        if (attempt >= 3 || !isTransient(error)) {
          throw error;
        }
      }
    }
  }
}

const retryPolicy = new RetryPolicy();

export function deliverWebhook(event: WebhookEvent): Promise<DeliveryReceipt> {
  return retryPolicy.execute(
    event.id,
    () => sendWebhook(event),
    (error) => error instanceof TransientDeliveryError,
  );
}

export const deliverWebhookWithRetry = deliverWebhook;
