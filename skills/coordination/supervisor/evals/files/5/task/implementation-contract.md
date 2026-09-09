# Accepted implementation contract

Contract version: 2

- Read `.project/policy.json` only when it exists.
- Accept `mode` values `strict` and `advisory`.
- When the file is absent, preserve the current `advisory` default without a new
  warning or side effect.
- A present but malformed file raises the existing `PolicyConfigError`.
- The focused test must distinguish absent, strict, advisory and malformed input.
- Implementation proof is the exact diff plus a passing focused test bound to
  that diff; it is not final delivery acceptance.
