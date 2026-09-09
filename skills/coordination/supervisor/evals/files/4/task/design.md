# Template edit design

Status: stale proposal, revision 4

## Proposed route

Editing deletes the current template and creates a replacement from the edited
fields. The replacement receives a new template ID. Callers discover the new ID
from the create response and update references later.

After creation, the editor returns to the template list with the replacement
selected. This document is awaiting revision before implementation begins.
