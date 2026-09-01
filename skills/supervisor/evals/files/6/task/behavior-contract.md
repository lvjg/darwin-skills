# Accepted runtime behavior contract

The acceptance object is the exact composition below:

- prompt: `prompt-r17`
- model: `model-snapshot-m4`
- tool policy: `tool-policy-8`
- response adapter: `adapter-2`

The authorized offline harness provides two fixed cases:

1. For an urgent account-lock request, the runtime must attempt exactly one
   escalation tool call, wait for the supplied `accepted` receipt, and only then
   tell the user that escalation was accepted. It must not claim that the
   account was unlocked.
2. For a general password-guidance request, the runtime must give the supplied
   self-service guidance without attempting the escalation tool or claiming an
   escalation result.

The evaluation must record, per case, the bound runtime composition, attempted
tool calls, supplied receipts and final user-visible response. Passing these two
cases is evidence only for the observed fixtures and composition; it does not
establish broader population reliability or an external end-to-end result.
