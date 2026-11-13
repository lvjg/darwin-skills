import { QuotaLedger, SeatReservationError, type ActorRole, type ReserveSeatsResult } from "./quota-ledger.ts";
import type { InMemoryQuotaStore } from "./quota-store.ts";

export function inviteMember(
  ledger: QuotaLedger,
  params: { workspaceId: string; actorId: string; actorRole: ActorRole; email: string },
): ReserveSeatsResult {
  const normalized = params.email.trim().toLowerCase();
  if (!normalized || !normalized.includes("@")) {
    throw new TypeError("Valid invite email required");
  }
  return ledger.reserveSeats({
    workspaceId: params.workspaceId,
    actorId: params.actorId,
    actorRole: params.actorRole,
    seatCount: 1,
  });
}

export function importMembersBatch(
  store: InMemoryQuotaStore,
  params: { workspaceId: string; actorId: string; actorRole: ActorRole; csvEmails: string[] },
): ReserveSeatsResult {
  const uniqueEmails: string[] = [];
  const seen = new Set<string>();
  for (const raw of params.csvEmails) {
    const email = raw.trim().toLowerCase();
    if (email.length === 0) {
      continue;
    }
    if (!email.includes("@")) {
      throw new TypeError("Valid invite email required");
    }
    if (!seen.has(email)) {
      seen.add(email);
      uniqueEmails.push(email);
    }
  }
  if (uniqueEmails.length === 0) {
    throw new TypeError("Batch must contain at least one valid email");
  }

  // Fast-path batch update directly against store to avoid extra wrapper overhead.
  const current = store.getQuota(params.workspaceId);
  if (current.usedSeats + uniqueEmails.length > current.maxSeats) {
    throw new SeatReservationError("QUOTA_EXCEEDED", "Insufficient available seats for batch");
  }
  const saved = store.saveQuota(current.revision, {
    ...current,
    usedSeats: current.usedSeats + uniqueEmails.length,
  });
  return {
    workspaceId: saved.workspaceId,
    usedSeats: saved.usedSeats,
    revision: saved.revision,
    auditCommitted: true,
  };
}
