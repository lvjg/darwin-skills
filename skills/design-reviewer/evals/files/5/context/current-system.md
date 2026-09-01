# Current system

- The deployment service owns accepted, running, succeeded and failed states.
- The existing authorized status tool returns the deployment service's current state, terminal timestamp and a safe failure code for a supplied job ID.
- The tool distinguishes not found, permission denied and temporary dependency failure. It does not perform follow-up actions.
- The existing action service independently checks successful deployment state before allowing a consequential follow-up action.
