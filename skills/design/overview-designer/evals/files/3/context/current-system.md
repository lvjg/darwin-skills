# Current system facts

- Configuration Service validates every accepted change and assigns an immutable, monotonically increasing `config_revision`. It is authoritative for accepted configuration content and revision identity.
- Each accepted revision enqueues a durable `CompileRequested(config_revision)` job. The queue provides at-least-once delivery and preserves an unacknowledged job across worker restarts.
- The queue may coalesce pending jobs for the same configuration identity to the highest revision before a worker claims one.
- Compiler Worker reads the requested authoritative revision, compiles idempotently by `(configuration_id, config_revision)`, and reports success or a classified terminal failure to Configuration Service.
- A retryable worker failure leaves the durable job unacknowledged. A later accepted revision may supersede an unclaimed older revision.
- There is no periodic numeric measurement, actuator, continuous setpoint error, or requirement to tune convergence speed. No separate controller service or controller database exists.
