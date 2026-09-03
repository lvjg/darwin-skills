# Accepted new obligation

The design authority has accepted the following change to the required result:

- An operator viewing a failed export job must see a bounded failure reason without leaving the Operations UI.
- The failure reason shown must be derived from Export Service's own `failure_code`; the UI must not infer a reason from state transitions or timing.
- When the job is not in `failed`, no failure reason is shown.

This is a change to the required result within the adopted route. It is not an evidence correction and it does not replace the route.
