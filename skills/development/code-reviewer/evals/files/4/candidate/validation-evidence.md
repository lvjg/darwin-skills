# Local validation

Run `node --experimental-strip-types --test review.test.mjs` from this directory with Node 22.6 or later. The tests exercise the submitted helper and document lookup against the existing process-local cache, including whitespace, blank identifiers, reserved characters and tenant separation.

The test file is supplied so the reviewer can reproduce the result. No TypeScript compiler result, ingestion-worker integration run or external-store evidence is supplied. Node type stripping executes this fixture; it is not a typecheck.
