# Incident-summary assistant intent

An internal incident operator should be able to request a concise summary of one incident record before a handoff.

- The summary must preserve the incident identifier, current severity and status, confirmed timeline facts and unresolved questions.
- It must distinguish confirmed cause information from hypotheses and must not invent a cause when none is confirmed.
- Exact wording and compression may vary as long as those facts and distinctions remain intact.
- The summary displayed to the operator is the completed result. The assistant must not mutate incident state or initiate follow-up actions.
- The user asks whether the proposed Agent/Harness design is ready to implement.
