export interface DraftSnapshot {
  draft_id: string;
  revision: number;
}

export interface CascadeSummary {
  deleted_field_keys: string[];
  deleted_edge_keys: string[];
}

interface WorkflowClient {
  deleteNode(input: { draft_id: string; node_key: string }): Promise<CascadeSummary>;
  getDraft(draftId: string): Promise<DraftSnapshot>;
}

declare const workflow: WorkflowClient;

async function mutate(
  draftId: string,
  operation: () => Promise<unknown>,
): Promise<DraftSnapshot> {
  await operation();
  return workflow.getDraft(draftId);
}

export const deleteNode = (input: {
  draft_id: string;
  node_key: string;
}) => mutate(input.draft_id, () => workflow.deleteNode(input));
