export interface WorkspaceQuota {
  workspaceId: string;
  usedSeats: number;
  maxSeats: number;
  suspended: boolean;
  revision: number;
}

export class QuotaConflictError extends Error {
  constructor(workspaceId: string) {
    super(`Concurrent quota revision conflict for ${workspaceId}`);
    this.name = "QuotaConflictError";
  }
}

export class InMemoryQuotaStore {
  #records = new Map<string, WorkspaceQuota>();

  constructor(seed: WorkspaceQuota[] = []) {
    for (const item of seed) {
      this.#records.set(item.workspaceId, { ...item });
    }
  }

  getQuota(workspaceId: string): WorkspaceQuota {
    const record = this.#records.get(workspaceId);
    if (!record) {
      throw new Error(`Unknown workspace: ${workspaceId}`);
    }
    return { ...record };
  }

  saveQuota(expectedRevision: number, next: WorkspaceQuota): WorkspaceQuota {
    const current = this.getQuota(next.workspaceId);
    if (current.revision !== expectedRevision) {
      throw new QuotaConflictError(next.workspaceId);
    }
    const stored: WorkspaceQuota = { ...next, revision: current.revision + 1 };
    this.#records.set(stored.workspaceId, stored);
    return { ...stored };
  }
}
