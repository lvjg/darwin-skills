import assert from "node:assert/strict";
import { test } from "node:test";
import { formatShardKey } from "./shard-key.ts";
import { findDocument } from "./document-store.ts";
import { records } from "./document-records.ts";

test("trim identifiers and encode each segment without encoding the delimiter", () => {
  assert.equal(formatShardKey(" acme/eu ", " brief #1? "), "acme%2Feu/brief%20%231%3F");
  assert.equal(formatShardKey("a/b", "c"), "a%2Fb/c");
  assert.equal(formatShardKey("a", "b/c"), "a/b%2Fc");
});

test("reject either blank identifier", () => {
  for (const [tenant, document] of [["", "report"], [" ", "report"], ["acme", ""], ["acme", "  "]]) {
    assert.throws(() => formatShardKey(tenant, document), /must not be blank/);
  }
});

test("lookup uses the encoded key and preserves tenant separation", () => {
  const expected = { body: "Quarterly report" };
  records.clear();
  try {
    records.set("acme%2Feu/brief%20%231%3F", expected);
    records.set("other/brief%20%231%3F", { body: "Other tenant" });
    assert.equal(findDocument(" acme/eu ", " brief #1? "), expected);
    assert.equal(findDocument("missing", "brief #1?"), undefined);
    assert.equal(findDocument("acme", "eu/brief #1?"), undefined);
  } finally {
    records.clear();
  }
});
