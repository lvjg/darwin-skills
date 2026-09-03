# Export Job Visibility Design

**Design status:** Confirmed

## Overall Design

Export Service owns every export job's state. The authenticated Operations Gateway reads the job record through `GET /ops/exports/{job_id}` and projects `job_id`, `tenant_id`, `state` and `updated_at` to the Operations UI, which presents the current state to authorized operators. If the read fails, Gateway returns an unavailable result and the UI presents the unavailable state.

## Key Designs

### Bounded operator projection

Gateway is the only path from operators to job state. It enforces operator authorization and returns only the four fields above; it holds no job state of its own and never becomes an authority for job meaning.

## Acceptance

Contract evidence establishes the four projected fields; gateway integration evidence establishes authorization and the unavailable result; UI evidence establishes state presentation and the unavailable state. These checks do not prove production deployment.

## 修订记录

| Design changed | Mechanism, responsibility, or choice changed | Impact | Basis and source |
| --- | --- | --- | --- |
| Overall Design | Replaced direct UI read of Export Service with Gateway projection | Operators no longer need Export Service credentials | Security owner decision, 2026-03 |
