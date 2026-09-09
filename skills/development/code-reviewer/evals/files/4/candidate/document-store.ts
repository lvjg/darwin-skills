import { formatShardKey } from "./shard-key.ts";

export interface DocumentRecord {
  body: string;
}

import { records } from "./document-records.ts";

export function findDocument(
  tenantId: string,
  documentId: string,
): DocumentRecord | undefined {
  return records.get(formatShardKey(tenantId, documentId));
}
