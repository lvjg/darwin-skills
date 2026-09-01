import type { DeleteNodeToolOutput } from "./agent-tool-contract";
import { deleteNode } from "./conversation-tools";

export const registeredDeleteNode: (input: {
  draft_id: string;
  node_key: string;
}) => Promise<DeleteNodeToolOutput> = deleteNode;
