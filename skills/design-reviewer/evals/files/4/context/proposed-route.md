# Proposed behavior route

- After the submit-deployment tool returns accepted, instruct the assistant to tell the operator that deployment completed.
- If the operator later asks for status, instruct the assistant to infer success from the acknowledgement and reassure the operator.
- If tool latency or uncertainty occurs, prefer a confident success response so the interaction remains smooth.
- Add examples of polished successful answers to the prompt.

The proposal adds no status-read capability or authoritative completion signal.
