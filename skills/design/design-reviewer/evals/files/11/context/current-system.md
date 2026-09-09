# Current system

- The policy catalog owns policy identity, scope and effective dates.
- Its maintained reader can return current policy records with typed employment-country and request-type fields.
- The reader may return multiple records if the query lacks either decisive field.
- Policy applicability does not grant travel approval; approval is owned by a separate process that is outside this assistant interaction.
- No exact prompt, Harness configuration or evaluation candidate has been implemented or run.

## Catalog sample returned by the maintained reader

| Policy ID | Employment country | Request type | Scope and guidance |
| --- | --- | --- | --- |
| DE-DOM-2026 | Germany | Domestic business trip | Germany domestic travel; economy rail is covered; book through the travel portal. |
| DE-INT-2026 | Germany | International business trip | Germany international travel; check destination allowances and submit a travel request. |
| SG-INT-2026 | Singapore | International business trip | Singapore international travel; check destination allowances and submit a travel request. |

These records are current in the supplied scenario. Location of departure or destination is not necessarily the employee's country of employment.
