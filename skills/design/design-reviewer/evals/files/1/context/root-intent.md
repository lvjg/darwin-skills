# Root intent

The review must decide whether the submitted design is sufficient to implement a document-to-SOP-template capability across a conversation service and a workflow service.

- The named tenant-information workflow is a representative acceptance example, not the maintained implementation itself.
- Deliver one generic Agent Skill that can turn supplied business material into a template through workflow-service primitives.
- Keep the existing `sop-create` Skill responsible only for consuming an existing template to create and operate an instance.
- The workflow service should provide the template-authoring primitives; the conversation service should interpret the business material and orchestrate them.
