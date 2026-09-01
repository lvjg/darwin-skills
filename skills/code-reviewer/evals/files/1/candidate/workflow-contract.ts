export type ParticipantBinding =
  | { kind: "applicant" }
  | { kind: "fixed_user"; ordinary_email: string }
  | {
      kind: "fixed_candidates";
      primary_ordinary_email: string;
      backup_ordinary_emails: string[];
    };

export const AUTHORING_LIMITS = {
  node_name: 200,
  node_description: 2000,
  node_guidance: 8000,
  option_value: 255,
} as const;

export interface DeleteNodeResponse {
  revision: number;
  cascade_summary: {
    deleted_field_keys: string[];
    deleted_edge_keys: string[];
  };
}

export function validateParticipant(binding: ParticipantBinding): void {
  if (binding.kind === "fixed_user" && !binding.ordinary_email) {
    throw new Error("ordinary_email is required");
  }
}
