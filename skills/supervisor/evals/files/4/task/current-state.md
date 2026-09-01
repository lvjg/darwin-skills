# Current task state

Task reference: `template-edit-redesign`

The accepted correction is to reuse the template owner's existing in-place
mutation capability rather than delete and recreate a template. The current
proposal in `design.md` still describes replacement, so it is not authoritative
and must be rewritten before review or implementation.

The authoritative owner contract already guarantees that a successful in-place
mutation keeps the template ID and existing inbound references while advancing
the template revision by one. Failure leaves the current template and revision
unchanged. This owner contract is accepted input to the design task; it is not
evidence that the proposed design has been implemented.

Available owners and capabilities:

- The current Session system prompt's initial `Available skills` snapshot lists
  only unrelated capabilities and omits all Darwin professional Skills.
- The Design Owner owns `design.md` and can rewrite it.
- `.agents/skills/overview-designer/SKILL.md` is installed and is the matching
  sibling capability from Supervisor's repository built-in list.
- `.agents/skills/design-reviewer/SKILL.md` is installed for a later independent
  review in a separate execution context.
- An Implementation Worker exists, but implementation is not yet eligible.

No action is currently running. The object versions are root intent revision 1,
accepted correction revision 2, and stale design revision 4.
