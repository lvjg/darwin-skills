# Connector API query contract

- Authority: Cloud Manager Connector API reference
- Document revision: `2026-08-27`
- Stable section: `GET /v2/connectors#filter-by-code`
- Exact filter: `filter[code][eq]=<percent-encoded-code>`
- Pagination: `page[number]` is one-based and `page[size]` is required when more than one match could be returned
- Success envelope: `data` is an array of Connector resources; an exact-code query may return zero or one active resource
- Error envelope: non-2xx responses use `errors[]` with `status`, `code`, `title`, and optional `detail`
- Effects: reference read only; no API call was made
- Unknowns: none for the exact-code V2 query needed by this decision
