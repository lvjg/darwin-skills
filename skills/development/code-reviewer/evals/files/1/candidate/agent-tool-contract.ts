import type {
  CascadeSummary,
  DraftSnapshot,
} from "./conversation-tools";

export interface DeleteNodeToolOutput {
  draft: DraftSnapshot;
  cascade_summary: CascadeSummary;
}

export const deleteNodeDescription =
  "Delete one node and return both the authoritative reread draft and the workflow service cascade summary.";
