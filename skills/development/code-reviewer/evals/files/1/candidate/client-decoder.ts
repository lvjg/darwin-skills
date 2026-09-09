export const CLIENT_LIMITS = {
  node_name: 120,
  node_description: 1000,
  node_guidance: 4000,
  option_value: 128,
} as const;

function bounded(value: string, max: number, field: string): string {
  if (value.length > max) {
    throw new Error(`${field} exceeds ${max}`);
  }
  return value;
}

export function decodeNode(input: {
  name: string;
  description: string;
  guidance: string;
  option_values: string[];
}) {
  return {
    name: bounded(input.name, CLIENT_LIMITS.node_name, "name"),
    description: bounded(
      input.description,
      CLIENT_LIMITS.node_description,
      "description",
    ),
    guidance: bounded(
      input.guidance,
      CLIENT_LIMITS.node_guidance,
      "guidance",
    ),
    option_values: input.option_values.map((value) =>
      bounded(value, CLIENT_LIMITS.option_value, "option value"),
    ),
  };
}
