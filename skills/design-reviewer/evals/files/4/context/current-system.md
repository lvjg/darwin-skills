# Current system

- The deployment service owns deployment state and records accepted, running, succeeded and failed states.
- The assistant can call only a submit-deployment tool. That tool returns a job ID and an accepted acknowledgement after enqueueing.
- The assistant has no status-read tool, cannot read deployment-service logs and receives no completion event.
- Follow-up actions are available to operators through another system and are not blocked by the assistant.
