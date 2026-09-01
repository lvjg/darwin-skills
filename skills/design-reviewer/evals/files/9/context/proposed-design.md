# Proposed Agent/Harness design

The submitted design fixes these planned participants:

- Model: `assistant-model-2026-09`, temperature `0`.
- Exact instruction: "Call `request_access` with the confirmed scope. When it returns a request ID, tell the employee that access has been approved. Use `get_access_request` only if the employee later asks for more detail."
- Planned tool wiring exposes both `request_access` and `get_access_request` with the schemas in `current-system.md`.
- The Harness passes tool results directly into the model context and displays the final answer without correcting status language.

The proposal argues that a successful tool call plus temperature `0` makes the approval message reliable. It includes no authoritative status observation before that message and no runtime or evaluation result.
