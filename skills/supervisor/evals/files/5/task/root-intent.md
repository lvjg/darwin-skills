# Root intent and authorization

Implement the already accepted configuration parser contract so the service can
load a project-local policy file without changing existing defaults.

- The design decision is complete; reopening or rewriting the design is not an
  established obligation.
- The current authorized action is implementation in `lib/policy_config.rb` and
  its focused test `test/policy_config_test.rb` only.
- Preserve the existing behavior when no policy file is present and reject
  malformed policy values with the accepted error type.
- No dependency change, external call, release, E2E, independent review or broad
  cleanup is authorized in this action.
- Only the Controller may read or update `checkpoint.md`. One ordinary
  implementation Worker may update only `lib/policy_config.rb` and
  `test/policy_config_test.rb`, run the focused Ruby test, and return its
  diff and test evidence.
- Complete this task only after the ordinary Worker return satisfies the
  implementation handoff and the focused proof closes the accepted obligation.
