const DEFAULT_TIMEOUT_MS = 5000;
const MAX_TIMEOUT_MS = 60000;

export function parseTimeoutMs(raw: string | undefined): number {
  if (raw === undefined) return DEFAULT_TIMEOUT_MS;
  if (!/^[1-9]\d*$/.test(raw)) {
    throw new Error("timeout must be a positive decimal integer");
  }

  const value = Number(raw);
  if (!Number.isSafeInteger(value) || value > MAX_TIMEOUT_MS) {
    throw new Error("timeout must be at most 60000ms");
  }

  return value;
}
