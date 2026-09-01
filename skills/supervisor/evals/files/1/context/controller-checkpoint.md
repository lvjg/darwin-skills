# Controller checkpoint before correction

- Checkpoint reference: `evals/files/1/context/controller-checkpoint.md`
- Revision: 7
- Control state: Active

## Expected result and boundary

Deliver a generic document-to-template capability across the conversation service and workflow service. The sample workflow is evidence, not a hard-coded product feature. The model must not publish templates.

## Current objects

- An adopted design and implementation candidate currently use persistent source evidence, whole-graph replacement, node-detail replacement and two route representations.
- Earlier design and delivery-acceptance conclusions refer to that route.
- No product write or E2E process is active at this checkpoint.

## New authoritative user decisions

The user has now established every decision in `accepted-corrections.md` and explicitly requests `$supervisor` to correct and implement the design. The user also says not to use E2E in this delivery.

## Available responsibility owners

- A Design Owner owns the sole writable design artifact
  `design/system-overview.md` and can rewrite it from its current revision 7.
  The repository-installed
  `.agents/skills/overview-designer/SKILL.md` is the available professional
  method for that work.
- A Design Reviewer can independently review a frozen design. The
  `.agents/skills/design-reviewer/SKILL.md` capability is installed for that
  later, separately executed review.
- One Implementation Worker can modify both product repositories in a single write chain.
- A Code Reviewer can independently judge the exact code candidate with the
  installed `.agents/skills/code-reviewer/SKILL.md` capability.
- `e2e-verifier` is installed but is not authorized for this delivery.

The evaluator may update only this checkpoint to incorporate the corrections and
the selected next action. It stops before dispatch; product implementation is
not executed inside this fixture.
