# Accepted parser contract

The candidate adds a private parser for one CLI `--timeout-ms` value.

- An absent value returns the existing default `5000`.
- An explicit value must be canonical decimal digits representing an integer from `1` through `60000` inclusive.
- Whitespace, signs, decimal points, exponents, zero, unsafe integers and values above `60000` are rejected.
- Accepted values are returned without coercion to a different unit.
- The parser has no state or external effects.

The requested next action is a local commit of this parser. Caller wiring, deployment and unrelated repository behavior are outside this candidate.
