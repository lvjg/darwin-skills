# Design Tradeoffs

Use the relevant guidance when reasonable alternatives pull in different directions. A useful judgment explains why a concrete gain is worth a concrete sacrifice under this task's conditions, and what would reverse that judgment. These are lenses for a choice, not another design workflow or a checklist to complete.

## Conflicting Objectives

Hard requirements are eligibility conditions; preferences distinguish acceptable solutions. Do not let a score on one dimension compensate for violating a binding requirement. If none of the options is feasible, the current alternatives or constraints need reconsideration; choosing the least deficient option does not resolve the conflict.

When feasible options have different strengths, identify which difference actually affects the intended result. Prefer an option that is no worse on relevant criteria and better on at least one, with comparable evidence. Otherwise use the established priorities and name the sacrifice. If a missing priority could reverse the choice, present the concrete consequence for the user to judge. Do not invent numeric weights to conceal an unresolved preference.

## Quality Versus Cost

Compare the additional benefit with the additional cost, rather than comparing feature counts or benchmark rankings. More accuracy, stronger consistency, lower latency, and broader coverage matter only through their effect on the required result. Beyond a useful threshold, further improvement may cost more than it delivers. Conversely, a cheap approximation is unsuitable if its errors lose required meaning or force expensive correction.

For an algorithm, examine the relevant workload, error distribution, and resource budget: average accuracy can hide an unacceptable class of errors, while a worst-case guarantee may be unnecessary for the actual use. For a system, include user effort, coordination, operation, and maintenance in the cost. Accept extra complexity when the consequential improvement warrants these continuing obligations.

## Simplicity Versus Flexibility

Judge simplicity by the amount of behavior people must understand and maintain, not merely by component count or lines of code. An abstraction earns its place when it captures a shared invariant or makes an established change substantially easier. Shared syntax alone is weak evidence; independent responsibilities may be clearer with some duplication.

Compare the cost of supporting a change now with the cost of making it when needed. Prefer a direct design when future variation is speculative and later change is affordable. Invest earlier when a credible change would otherwise require expensive migration or an irreversible commitment. The relevant benefit is reduced total change cost, not flexibility in the abstract.

## Reuse Versus Local Construction

Compare the complete cost of fitting a mature solution to the task with the complete cost of owning a local one. Reuse can provide tested behavior, expertise, and maintenance; adapters, operational dependencies, semantic mismatch, and upgrade constraints can consume that advantage. Local code can fit a narrow need closely, but its correctness and maintenance still have to be owned.

Prefer reuse when its mechanism and assumptions fit and its integration burden is lower than the work it replaces. Prefer a bounded local solution when the mismatch is central and adapting the dependency would effectively recreate the mechanism anyway. Evaluate the actual implementation or method, not the reputation of a project or the presence of a paper.

## Local Improvement Versus Whole-Solution Cost

Compare alternatives at the boundary where the intended result is consumed. A faster component may shift waiting elsewhere; automation may transfer difficult judgment to the user; a simpler service may require a more complicated protocol. Count transferred work and lost information rather than treating them as savings.

Evaluate coupled choices together when one changes the feasibility or cost of another. A combined approach is worthwhile when a concrete division of work improves the result enough to pay for coordination. Keeping both paths merely because each has advantages postpones the tradeoff and adds another one.

## Confidence Versus Reversibility

Find the assumption that could reverse the recommendation and vary it over a plausible range. A choice that remains preferable needs less precision than one that changes with a small estimation error. For a sensitive choice, seek evidence about that difference or state a meaningful condition for selecting each option.

When evidence remains limited, weigh the cost of being wrong and changing later. A reversible choice can justify acting sooner if it delivers a useful result; an expensive commitment needs stronger support. Consider credible adverse outcomes that an average can hide, without inventing probabilities or designing for every imaginable failure. Speculative extension points and parallel implementations are not free insurance.

## Further Investigation Versus Acting Now

Ask whether obtainable information could change a consequential choice enough to justify the cost and delay of obtaining it. Investigate the decisive difference. Use a calculation or experiment when that is what can resolve the uncertainty; additional citations do not substitute for it. Stop reading sources that only repeat what is already known.

Deepen details whose plausible alternatives change the result, approach, or material cost. Stop when remaining choices are interchangeable implementation details or further work is unlikely to change the recommendation. Time spent is not evidence of validity, and exhausted time does not make a missing central mechanism complete. Where uncertainty cannot be resolved, bound the recommendation instead of claiming certainty or postponing every decision.
