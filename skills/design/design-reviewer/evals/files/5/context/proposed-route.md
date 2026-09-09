# Proposed behavior route

- When asked whether a deployment finished, the assistant obtains the job ID or asks for it, then calls the authorized status tool.
- It reports accepted or running as not finished, succeeded as completed with the terminal timestamp, and failed as not completed with the safe failure code.
- For not found, permission denied or temporary dependency failure, it states that completion cannot be determined and does not infer success.
- The model interprets the operator's question and explains the typed result. The deployment service and action service retain state, authorization and consequential-action enforcement.
- Planned evaluation includes contrasting accepted-versus-succeeded, running-versus-failed and unavailable-state scenarios. Exact prompt composition and runtime behavior will be accepted after implementation.
