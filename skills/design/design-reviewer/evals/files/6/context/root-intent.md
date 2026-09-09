# Root intent

An internal administrator saves a catalog item and may request a search-index refresh. The review must decide whether the submitted design is sufficient to enter implementation.

- The database save must remain durable and immediately visible in the catalog.
- Stakeholders have not decided whether a requested index refresh must be eventually guaranteed or may fail visibly and be retried manually.
- The implementation must not choose that product guarantee on their behalf.
