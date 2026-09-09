import { getAuthoringCapabilities } from "./capabilities";
import { decodeNode } from "./client-decoder";
import type { ParticipantBinding } from "./workflow-contract";

interface AuthoritativeNode {
  name: string;
  description: string;
  guidance: string;
  option_values: string[];
}

interface WorkflowAuthoringClient {
  updateNode(input: {
    draft_id: string;
    node_key: string;
    node: AuthoritativeNode;
  }): Promise<{ revision: number }>;
  getNode(input: {
    draft_id: string;
    node_key: string;
  }): Promise<AuthoritativeNode>;
}

export function canAuthorParticipant(binding: ParticipantBinding): boolean {
  return getAuthoringCapabilities().participant_kinds.includes(binding.kind);
}

export async function updateAndRereadNode(
  workflow: WorkflowAuthoringClient,
  input: {
    draft_id: string;
    node_key: string;
    node: AuthoritativeNode;
  },
) {
  await workflow.updateNode(input);
  const authoritative = await workflow.getNode(input);
  return decodeNode(authoritative);
}
