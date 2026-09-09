# Current system facts

- The vendor API accepts only a confidential organization credential and explicitly prohibits distributing it to browser clients.
- The vendor API does not permit cross-origin browser calls and provides no browser-safe delegated token flow.
- The organization's security policy prohibits storing the vendor credential in browser storage, frontend bundles or user-visible responses.
- The existing authenticated administration gateway can call the vendor API server-side, already owns administrator authorization, and can project a bounded diagnostic response without exposing the credential.
- These facts come from the vendor contract and the security owner. They invalidate the previously assumed browser-direct capability.
