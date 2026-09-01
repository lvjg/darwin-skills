# Initial proposed route

The proposal claims to provide a generic document-to-template capability.

## Conversation-service responsibilities

- Import an exact document revision into a server-owned source snapshot.
- Normalize headings, paragraphs, lists and table cells into persistent evidence leaves.
- Read selected evidence leaves by ID during later turns.
- Maintain evidence mappings, exclusions, conflicts and unsupported classifications.
- Orchestrate template structure, node detail, rules, finalize and human confirmation.

## Workflow-service authoring operations

1. `get_template_authoring_capabilities`
2. `create_approval_template_draft`, which persists the source snapshot and an empty draft
3. `get_approval_template_draft`
4. `get_approval_template_source_evidence`
5. `replace_approval_template_structure`, which replaces the complete node/outcome/edge graph and requires a closed reachable graph
6. `replace_approval_template_node_detail`, which replaces all configuration for one node
7. `replace_approval_template_rules`, which replaces global edge rules and all evidence dispositions
8. `finalize_approval_template_draft`
9. `publish_approval_template_draft`, available only to the signed application path

## Representations and state

- Direct edge conditions may appear inside node detail.
- Global template rules may independently target edges.
- Outcomes are separate resources referenced by edges, but compilation does not give every outcome a runtime meaning.
- Draft revision CAS protects writes.
- Every editing operation attempts to preserve a globally closed graph.
- Source coverage and source digest participate in finalization and publication.

The proposal justifies the source lifecycle as traceability for long documents, but names no current audit consumer, retention requirement or external contract that requires the workflow service to own it.
