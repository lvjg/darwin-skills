# Deployment-status behavior intent

An internal operator should be able to ask the assistant whether a deployment has finished.

- The answer must distinguish request acceptance, work in progress, success and failure.
- The operator may start follow-up actions only after real successful completion.
- If the authoritative state cannot be obtained, the assistant must expose that uncertainty.
- The user asks whether the proposed maintained behavior is ready to implement.
