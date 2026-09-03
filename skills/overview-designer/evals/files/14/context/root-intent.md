# Invoice total consistency intent

An invoice's displayed total must always equal the sum of its line amounts after applying the tenant's current tax rule. Finance has reported invoices whose stored total disagrees with the recomputed sum.

An engineer has proposed a "total synchronization service" that watches line and tax-rule changes and rewrites `Invoice.total`. The design authority asks whether that is the right target design or whether something simpler closes the result. Route selection is delegated, including reassignment of responsibility between the services named below.

Only `design/system-design.md` may be modified. Do not implement code.
