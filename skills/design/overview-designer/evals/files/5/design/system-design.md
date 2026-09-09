# Build Provenance Visibility Design

**Design status:** Confirmed

## Overall Design

Build Service owns the immutable build manifest. The authenticated Gateway reads `/build-info` and projects the bounded result to Admin UI, which presents it to authorized administrators. The browser never receives storage credentials or becomes provenance authority.

## Acceptance

Contract evidence must establish the manifest fields; gateway integration evidence must establish authorization and projection; UI evidence must establish exact-value and unavailable states. These checks do not prove production deployment or external validation.
