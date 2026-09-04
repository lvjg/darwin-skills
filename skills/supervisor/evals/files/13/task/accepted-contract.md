# Accepted quota parser contract

- Writable implementation: `lib/quota_parser.rb`
- Writable focused test: `test/quota_parser_test.rb`
- Missing quota input preserves the existing unlimited result.
- A positive integer string returns that integer.
- Zero, negative, non-integer and malformed input raise `QuotaParseError`.
- Completion requires the focused test to distinguish the missing, valid and invalid paths.
