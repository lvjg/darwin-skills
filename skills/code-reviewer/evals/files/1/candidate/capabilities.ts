import type { ParticipantBinding } from "./workflow-contract";

export interface AuthoringCapabilities {
  participant_kinds: ParticipantBinding["kind"][];
}

export function getAuthoringCapabilities(): AuthoringCapabilities {
  return {
    participant_kinds: ["fixed_candidates"],
  };
}
