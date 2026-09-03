# Invoice Total Consistency Design (draft)

**Design status:** Drafting

Proposed: a Total Synchronization Service subscribes to `InvoiceLineChanged` and `TaxRuleChanged` events, recomputes the affected invoices' totals, and writes them back to Invoice Service. Open items: event ordering, retry, reconciliation for missed events, and how to detect drift between the synchronizer and Billing Portal writes.
