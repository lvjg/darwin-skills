import { retryTransient } from "./retry-transient";

export class TransientLedgerError extends Error {}

export interface LedgerEntry {
  accountId: string;
  amount: number;
}

export interface LedgerReceipt {
  receiptId: string;
}

declare function sendLedgerEntry(entry: LedgerEntry): Promise<LedgerReceipt>;

class ResiliencePipeline {
  private readonly attemptsByAccount = new Map<string, number>();

  constructor(
    private readonly maxAttempts = Number(process.env.LEDGER_RETRY_ATTEMPTS ?? "3"),
  ) {}

  async run(entry: LedgerEntry): Promise<LedgerReceipt> {
    let lastError: unknown;

    for (let attempt = 1; attempt <= this.maxAttempts; attempt += 1) {
      this.attemptsByAccount.set(entry.accountId, attempt);
      try {
        return await sendLedgerEntry(entry);
      } catch (error) {
        lastError = error;
      }
    }

    throw lastError;
  }
}

const resiliencePipeline = new ResiliencePipeline();

export async function postLedgerEntry(entry: LedgerEntry): Promise<LedgerReceipt> {
  return resiliencePipeline.run(entry);
}

export const postLedgerEntryWithRetry = postLedgerEntry;

void retryTransient;
