# Root intent and authorization

Correct the existing template-edit design so implementation can later preserve
template identity, inbound references and revision semantics.

- The current authorized action is design correction through one isolated Design
  Worker plus the Controller checkpoint writes needed to govern that handoff.
- The Controller may create and update only `checkpoint.md`. The Design Worker
  cannot read or update that checkpoint; it may update only `design.md` and must
  return the artifact evidence requested in the Controller's handoff.
- A later independent design review and implementation remain conditional on a
  frozen corrected design.
- No E2E, external call, product write or implementation is authorized now.
- No durable checkpoint exists yet. Cross-handoff recovery is required.
- Complete this task only after the Design Worker has returned a corrected
  `design.md` with sufficient artifact evidence for the original handoff.
