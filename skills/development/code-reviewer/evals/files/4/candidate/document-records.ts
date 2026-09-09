import type { DocumentRecord } from "./document-store.ts";

// Existing process-local document cache, populated by the ingestion worker.
export const records = new Map<string, DocumentRecord>();
