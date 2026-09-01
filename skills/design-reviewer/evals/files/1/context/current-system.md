# Current-system snapshot

These are neutral observations from the product snapshot available when the review was requested. They describe the existing candidate; they are not accepted target-design decisions.

## Responsibility and runtime facts

- The conversation service owns Agent-facing Skills and orchestration. Its existing `sop-create` capability consumes a published template to create and operate an instance; it does not author templates.
- The workflow service owns template draft persistence, validation, compilation, publication and runtime semantics.
- The model cannot submit raw BPMN or expression strings and cannot call publication. Publication is a separate signed human-confirmed application action.
- Existing published templates and their runtime types are active behavior that a new authoring route must not silently remove.

## Existing authoring behavior

- Draft creation persists an editing draft with empty node and edge collections.
- The next structure operation accepts the complete node, outcome and edge collections. It rejects input unless the submitted graph already has a unique start, a terminal node and full reachability.
- A successful structure replacement makes omitted resources disappear. Revision compare-and-swap prevents stale writes but does not distinguish omission from intentional deletion in a fresh full replacement.
- Nodes, fields, actions and edges use keys referenced by other draft objects. Node configuration is replaced as one aggregate.
- Edge conditions can be represented both in node detail and in a global rule collection. When both target the same edge, the compiler selects one representation instead of rejecting the conflict.
- The candidate persists source snapshots, evidence leaves, dispositions, coverage state and a source digest used during finalization and publication.
- The supplied requirements and contract inventory name no independent audit, retention or external consumer for that persistent source lifecycle. Within the inspected candidate, its readers belong to the same authoring, confirmation and publication path. A consumer outside that inspected scope remains an unknown, not an established absence.
- Request-key idempotency and revision compare-and-swap are existing mutation guarantees.
