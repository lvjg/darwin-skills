import { formatShardKey } from "./shard-key";

export interface DocumentRecord {
  body: string;
}

declare const records: Map<string, DocumentRecord>;

export function findDocument(
  tenantId: string,
  documentId: string,
): DocumentRecord | undefined {
  return records.get(formatShardKey(tenantId, documentId));
}
