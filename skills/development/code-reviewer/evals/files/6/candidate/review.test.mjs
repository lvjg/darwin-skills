import assert from "node:assert/strict";
import test from "node:test";

import { QuotaLedger, SeatReservationError } from "./quota-ledger.ts";
import { InMemoryQuotaStore } from "./quota-store.ts";
import { importMembersBatch, inviteMember } from "./seat-handlers.ts";

test("inviteMember reserves seat for workspace_admin and emits audit event", async () => {
  const events = [];
  const store = new InMemoryQuotaStore([
    { workspaceId: "ws-1", usedSeats: 2, maxSeats: 5, suspended: false, revision: 1 },
  ]);
  const ledger = new QuotaLedger(store, {
    async enqueue(event) {
      events.push(event);
      return { ticketId: "ticket-1" };
    },
  });

  const result = inviteMember(ledger, {
    workspaceId: "ws-1",
    actorId: "u-admin",
    actorRole: "workspace_admin",
    email: "Alice@Example.com",
  });

  assert.equal(result.usedSeats, 3);
  assert.equal(result.revision, 2);
  assert.equal(result.auditCommitted, true);
  assert.equal(events.length, 1);
});

test("inviteMember rejects non-admin and suspended workspaces", () => {
  const store = new InMemoryQuotaStore([
    { workspaceId: "ws-suspended", usedSeats: 1, maxSeats: 5, suspended: true, revision: 4 },
  ]);
  const ledger = new QuotaLedger(store, {
    async enqueue() {
      return { ticketId: "ticket-2" };
    },
  });

  assert.throws(
    () =>
      inviteMember(ledger, {
        workspaceId: "ws-suspended",
        actorId: "u-member",
        actorRole: "member",
        email: "bob@example.com",
      }),
    (err) => err instanceof SeatReservationError && err.code === "FORBIDDEN",
  );
  assert.throws(
    () =>
      inviteMember(ledger, {
        workspaceId: "ws-suspended",
        actorId: "u-admin",
        actorRole: "workspace_admin",
        email: "bob@example.com",
      }),
    (err) => err instanceof SeatReservationError && err.code === "WORKSPACE_SUSPENDED",
  );
});

test("importMembersBatch deduplicates emails and increments seats", () => {
  const store = new InMemoryQuotaStore([
    { workspaceId: "ws-batch", usedSeats: 1, maxSeats: 5, suspended: false, revision: 1 },
  ]);

  const result = importMembersBatch(store, {
    workspaceId: "ws-batch",
    actorId: "u-admin",
    actorRole: "workspace_admin",
    csvEmails: [" a@example.com ", "A@example.com", "b@example.com"],
  });

  assert.equal(result.usedSeats, 3);
  assert.equal(result.auditCommitted, true);
});
