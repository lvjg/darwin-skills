# Candidate contract

The candidate adds a slug helper for an internal import path.

- The decided behavior is to trim surrounding whitespace, lowercase text and replace each run of whitespace with one hyphen.
- `Slug.call` is the intended internal entry point.
- No compatibility, configuration, extension or additional validation behavior is required.
- Modify the candidate only if a line or structure lacks an obligation.

Run `ruby test/slug_test.rb` from the project directory.
