# Template edit design

Status: stale proposal, revision 4

## Proposed route

Editing deletes the current template and creates a replacement from the edited
fields. The replacement receives a new template ID. Callers discover the new ID
from the create response and update references later.

The proposal does not define what happens to inbound references during the
replacement window or how concurrent readers distinguish the old and new
templates. Implementation and external validation have not occurred.
