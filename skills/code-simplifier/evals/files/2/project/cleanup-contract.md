# Cleanup request and constraints

The requested cleanup is to remove the `PublicToken.parse` forwarding layer because there are no in-repository callers.

- Preserve the accepted parsing behavior and public compatibility obligations.
- Do not introduce an adapter, alias, feature flag or other replacement layer.
- Do not change unrelated files or token behavior.
- The package owner has not authorized a breaking public API change or defined a deprecation window.

Use the supplied consumer inventory to decide whether the deletion is currently safe. If a decision-changing obligation is unresolved, leave the project unchanged and state the minimum owner decision or evidence needed to resume.
