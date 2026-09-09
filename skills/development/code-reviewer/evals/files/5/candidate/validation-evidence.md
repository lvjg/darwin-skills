# Local validation

Run `node --experimental-strip-types --test review.test.mjs` from this directory with Node 22.6 or later. It checks the submitted delivery function and the existing retry helper with the same outcomes, plus the actual dispatch caller. Each test replaces the transport method with controlled responses; no network request is sent.

The test file is supplied so the reviewer can reproduce success, attempt bounds and final-error identity. No TypeScript compiler result or real partner-delivery evidence is supplied; Node type stripping is not a typecheck.
