# Proposed Agent/Harness design

- After deterministic retrieval and validation, the Harness passes the complete typed incident snapshot and the summary instruction to the model.
- The model produces a concise handoff summary containing the incident identifier, current severity and status, confirmed events in time order and every unresolved question.
- Hypotheses must remain labelled as hypotheses. If no confirmed cause exists, the summary says that the cause is unconfirmed rather than supplying one.
- Prose, grouping and compression may vary, but the required facts, status and epistemic labels may not change.
- The returned summary is displayed directly to the operator and is the final result. It neither calls a tool nor changes external state.
- Planned validation contrasts incidents with confirmed versus hypothesized causes, present versus absent unresolved questions and dense versus sparse timelines. Exact implemented composition and runtime behavior will be checked after implementation.
