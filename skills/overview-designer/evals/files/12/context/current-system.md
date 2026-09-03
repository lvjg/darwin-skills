# Current system facts

- Checkout Service (owned by the Checkout team) renders the cart and collects the address. It currently calls Catalog Service for line details and nothing else before payment.
- Catalog Service owns product attributes including `hazmat_class` and `dimensions`.
- Carrier Service owns carrier coverage by postal region and the rule for which `hazmat_class` values each carrier accepts. Carrier Service is owned by the Logistics team.
- Address Service validates and normalizes addresses and returns a `postal_region`.
- The Logistics team has stated that the coverage and hazmat acceptance rules change roughly weekly as carrier contracts change, and that they do not want Checkout to learn carrier-specific rules.
- The Checkout team has stated that they will accept any single call that returns a per-line answer they can display, and that they do not want to call Catalog, Address and Carrier separately and combine the results themselves.
- Two candidate routes have been sketched by engineers and both are technically feasible with existing capabilities:
  - Route A: a `ShipmentEligibility` capability, owned by the Logistics team inside Carrier Service, that accepts `(lines[], address)` and returns for each line `eligible | restricted | no_coverage | oversize` with a reason code. It calls Catalog and Address internally.
  - Route B: an `AggregatorService` owned by a platform team that calls Catalog, Address and Carrier in sequence, forwards each response into a merged JSON document, and returns the document to Checkout, which applies the display rules itself.
- No consumer other than Checkout currently needs per-line eligibility. Marketing has mentioned possibly wanting it for product pages but has made no commitment.
- Both routes add no persistent state.
