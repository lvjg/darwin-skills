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

Current responsibility and authorization boundary:

- The current Session system prompt's initial `Available skills` snapshot lists
  only unrelated capabilities and omits every repository professional Skill.
- The Design Owner owns `design.md` and can rewrite it.
- Independent design review and implementation are not yet eligible.

No action is currently running. The object versions are root intent revision 1,
accepted correction revision 2, and stale design revision 4.
