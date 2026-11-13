import type { AuditQueue } from "./audit-queue.ts";
import type { InMemoryQuotaStore } from "./quota-store.ts";

export type ActorRole = "workspace_admin" | "member" | "billing_viewer";

export interface ReserveSeatsInput {
  workspaceId: string;
  actorId: string;
  actorRole: ActorRole;
  seatCount: number;
}

export interface ReserveSeatsResult {
  workspaceId: string;
  usedSeats: number;
  revision: number;
  auditCommitted: boolean;
}

export class SeatReservationError extends Error {
  readonly code: "FORBIDDEN" | "WORKSPACE_SUSPENDED" | "QUOTA_EXCEEDED" | "INVALID_COUNT";

  constructor(
    code: "FORBIDDEN" | "WORKSPACE_SUSPENDED" | "QUOTA_EXCEEDED" | "INVALID_COUNT",
    message: string,
  ) {
    super(message);
    this.name = "SeatReservationError";
    this.code = code;
  }
}

export class QuotaLedger {
  #store: InMemoryQuotaStore;
  #auditQueue: AuditQueue;

  constructor(store: InMemoryQuotaStore, auditQueue: AuditQueue) {
    this.#store = store;
    this.#auditQueue = auditQueue;
  }

  reserveSeats(input: ReserveSeatsInput): ReserveSeatsResult {
    if (!Number.isInteger(input.seatCount) || input.seatCount <= 0) {
      throw new SeatReservationError("INVALID_COUNT", "seatCount must be a positive integer");
    }
    if (input.actorRole !== "workspace_admin") {
      throw new SeatReservationError("FORBIDDEN", "Only workspace_admin may reserve seats");
    }

    const current = this.#store.getQuota(input.workspaceId);
    if (current.suspended) {
      throw new SeatReservationError("WORKSPACE_SUSPENDED", "Workspace is suspended");
    }
    if (current.usedSeats + input.seatCount > current.maxSeats) {
      throw new SeatReservationError("QUOTA_EXCEEDED", "Insufficient available seats");
    }

    const committed = this.#store.saveQuota(current.revision, {
      ...current,
      usedSeats: current.usedSeats + input.seatCount,
    });

    // Keep reserveSeats synchronous per design signature while firing async queue in background.
    void this.#auditQueue
      .enqueue({
        kind: "seat_reserved",
        workspaceId: input.workspaceId,
        actorId: input.actorId,
        seatsAdded: input.seatCount,
        resultingRevision: committed.revision,
      })
      .catch(() => undefined);

    return {
      workspaceId: committed.workspaceId,
      usedSeats: committed.usedSeats,
      revision: committed.revision,
      auditCommitted: true,
    };
  }
}
