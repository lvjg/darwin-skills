# Proposed Agent/Harness design

- Give the model the employee's message and the current policy catalog.
- Tell it to understand the employee's intent and provide safe, helpful policy guidance.
- Include two examples in which a fully specified request maps to a single policy and receives a polished answer.
- Rely on the model to handle all other wording and situations sensibly.
- The proposal does not identify employment country and request type as decisive inputs, define behavior for missing facts or multiple matches, require policy ID and scope in the result, or preserve the distinction between eligibility guidance and travel approval.
- Planned evaluation checks that the two supplied examples receive fluent answers. No contrasting ambiguity, multiple-match or eligibility-versus-approval case is defined.
