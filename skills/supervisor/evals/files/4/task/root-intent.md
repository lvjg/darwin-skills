# Root intent and authorization

Correct the existing template-edit design so implementation can later preserve
template identity, inbound references and revision semantics.

- The current authorized action is design correction through one isolated Design
  Worker plus the Controller checkpoint writes needed to govern that handoff.
- The Controller may create and update only `checkpoint.md`. The Design Worker
  may update only `design.md` and must return the bound artifact evidence to the
  Controller.
- A later independent design review and implementation remain conditional on a
  frozen corrected design.
- No E2E, external call, product write or implementation is authorized now.
- No durable checkpoint exists yet. Cross-handoff recovery is required.
- Complete this task only after the Design Worker has returned a corrected
  `design.md` bound to the dispatched action and input checkpoint revision.
