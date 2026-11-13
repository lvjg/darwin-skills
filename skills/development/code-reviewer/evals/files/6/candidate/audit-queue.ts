export interface AuditEvent {
  kind: "seat_reserved";
  workspaceId: string;
  actorId: string;
  seatsAdded: number;
  resultingRevision: number;
}

export interface AuditReceipt {
  ticketId: string;
}

/**
 * Maintained repository audit transport shared across services.
 *
 * Contract: `enqueue` submits an event asynchronously to the remote audit
 * ingestion buffer and resolves with a queue ticket once accepted into the
 * buffer, or rejects when the buffer is full or unavailable. It is non-blocking
 * relative to durable storage and does not participate in synchronous in-memory
 * or database transactions.
 */
export interface AuditQueue {
  enqueue(event: AuditEvent): Promise<AuditReceipt>;
}
