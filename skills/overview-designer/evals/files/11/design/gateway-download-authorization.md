# Gateway Download Authorization (draft)

## Overall Design

Download Gateway reproduces the complete export-download flow and stores recent access decisions so it can keep issuing links when Access Service is unavailable.

## Key Designs

### Denial reason normalization

Gateway derives a user-facing denial reason from request and export fields when Access Service returns `deny`.

### Authorization history

Gateway persists every decision for future audit and offline authorization.
