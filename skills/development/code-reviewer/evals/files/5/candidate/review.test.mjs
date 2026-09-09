import assert from "node:assert/strict";
import { test } from "node:test";
import { deliverWebhook, TransientDeliveryError } from "./webhook-delivery.ts";
import { dispatchWebhook } from "./caller.ts";
import { webhookTransport } from "./webhook-transport.ts";
import { retryTransient } from "./retry-transient.ts";

const event = { id: "evt-1042", body: '{"order":"1042","status":"shipped"}' };
const receipt = { deliveryId: "delivery-1042" };
const temporary1 = new TransientDeliveryError("busy");
const temporary2 = new TransientDeliveryError("rate limited");
const finalError = new TransientDeliveryError("still unavailable");
const permanent = new Error("invalid destination");

for (const [name, results, attempts, error] of [
  ["immediate success", [receipt], 1],
  ["transient success on third attempt", [temporary1, temporary2, receipt], 3],
  ["permanent failure", [permanent], 1, permanent],
  ["exhausted retries preserve the final error", [temporary1, temporary2, finalError, receipt], 3, finalError],
  ["permanent failure after a transient failure", [temporary1, permanent, receipt], 2, permanent],
]) {
  for (const implementation of ["delivery", "existing utility"]) {
    test(`${implementation}: ${name}`, async (t) => {
      let calls = 0;
      const operation = async () => {
        const result = results[calls++];
        if (result instanceof Error) throw result;
        return result;
      };
      t.mock.method(webhookTransport, "send", async (received) => {
        assert.equal(received, event);
        return operation();
      });
      const run = implementation === "delivery"
        ? () => deliverWebhook(event)
        : () => retryTransient(operation, (err) => err instanceof TransientDeliveryError);
      if (error) await assert.rejects(run, (received) => received === error);
      else assert.equal(await run(), receipt);
      assert.equal(calls, attempts);
    });
  }
}

test("dispatch returns the partner receipt and forwards the original event", async (t) => {
  const send = t.mock.method(webhookTransport, "send", async (received) => {
    assert.equal(received, event);
    return receipt;
  });
  assert.equal(await dispatchWebhook(event), "delivery-1042");
  assert.equal(send.mock.callCount(), 1);
});
