# Current system facts

- Invoice Service owns `Invoice` and `InvoiceLine`. Lines are added, edited and removed through Invoice Service's API until the invoice is issued; after issue they are immutable.
- Invoice Service stores `Invoice.total` as a column. It is written by Billing Portal, a separate service owned by the web team, which computes the total in the browser after each line edit and sends `PATCH /invoices/{id}` with the new total.
- Tax Service owns tenant tax rules and exposes `GET /tax-rules/{tenant_id}` returning the current rule and its `effective_from`. Rules change at most a few times a year; a change applies to invoices issued after `effective_from`.
- Billing Portal fetches the tax rule once when the invoice screen opens and reuses it for the session.
- Incident analysis: every observed mismatch falls into one of two classes. (a) A line was edited through the Invoice Service API by an integration partner, which does not send a total; Billing Portal never saw the edit. (b) The tax rule changed while a portal session was open, and the portal continued to use the stale rule.
- Invoice Service already computes `sum(line.amount)` internally for validation and has read access to Tax Service.
- Reports, exports and the customer PDF all read `Invoice.total` from Invoice Service; none compute it. They are the only consumers of the total.
- No consumer needs a history of past totals for unissued invoices.
