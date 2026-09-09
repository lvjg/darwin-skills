function encodeSegment(value: string, label: string): string {
  const trimmed = value.trim();
  if (trimmed.length === 0) {
    throw new Error(`${label} must not be blank`);
  }

  return encodeURIComponent(trimmed);
}

export function formatShardKey(tenantId: string, documentId: string): string {
  const encodedTenantId = encodeSegment(tenantId, "tenantId");
  const encodedDocumentId = encodeSegment(documentId, "documentId");

  return `${encodedTenantId}/${encodedDocumentId}`;
}
