---
name: intent-clarifier
description: Clarify consequential ambiguity in task goals, scope, success criteria, or user-owned tradeoffs before or during ongoing work. Use when checking interpretations, examples, or dialogue would materially improve the result; skip clear tasks, discoverable facts, and delegated technical choices.
---

# Intent Clarifier

## Purpose

Make the task interpretation inspectable and correctable before substantial work depends on it. Help the user express relevant context and form choices they may not yet have settled. The result is a working understanding sufficient for the next action.

You cannot observe unexpressed intent or reliably detect that your interpretation has diverged from it. You can inspect stated requirements, identify some gaps and contradictions, expose assumptions, and revise from evidence and feedback. A brief, scenario, or small example gives the user something concrete to correct; it is useful during clarification, not only at the end.

Work within the original task, valid decisions, and existing authorization. Explicit user instructions govern over this Skill's default process, subject to higher-priority constraints.

The agent may select this Skill when its purpose fits the current work; explicit invocation remains available. Selection does not change the active role: an executing agent applies clarification within its task, while a controller-only agent delegates it through the existing worker mechanism. Return to the original work after clarification without adding a confirmation step. This is an optional capability, not a required stage or dependency of other Skills.

## Find What Is Worth Clarifying

Recover the current request, relevant conversation and materials, progress, constraints, delegated choices, and what should happen after clarification. Focus on the requested whole task or local question. Do not ask the user to repeat available context.

Look for missing purpose, audience, scope, expected depth, or output needs; consequential default assumptions; materially different interpretations; conflicting constraints; and choices whose acceptable costs depend on user priorities. Consider what changes in the result if the current interpretation is wrong and whether resolving it now is more useful than showing a revisable first version. Complexity, impact, or the mere existence of another option does not by itself justify a question.

When the user says the result is wrong, first check explicit requirements and available evidence. A factual error, failure to follow a clear instruction, or deficient professional work calls for correction by the responsible task owner, not another interview about requirements already given. Keep uncertain attribution explicit.

## Choose the Next Useful Action

Use these distinctions to select an action, not as a checklist to complete:

| What is missing | How to handle it |
| --- | --- |
| Discoverable facts | Investigate the specific question using available materials or tools. Stop when evidence supports the next judgment. |
| Routine or delegated professional judgment | Analyze and decide within the user's constraints. Importance alone does not transfer ownership to the user. |
| Unexpressed goals, preferences, or acceptable costs | Ask when the answer is worth the interruption and could change the work. |
| A plausible but consequential interpretation | Show the interpretation and its implications so the user can correct it. |
| A preference the user cannot yet form | Offer a bounded scenario, example, or comparison that makes the consequences understandable. |
| A low-cost, reversible detail with a reasonable default | State the assumption when useful and continue. |
| An empirical unknown | Identify the evidence or experiment needed; do not manufacture a guarantee through conversation. |

Resolve material uncertainty about the current objective, scope, or authorization before acting on it. Tie each unresolved question to the work that actually depends on its answer; continue independent, already-authorized work. Honor an explicit request to finish clarification before continuing.

Investigation cannot recover an unstated preference. Conversely, asking the user to choose a technical mechanism without explaining its relevant consequences transfers professional work to them. Ground comparisons in available evidence and distinguish measured costs from estimates and unknowns. Limited design fragments can help form intent; full design, implementation, or experiments belong to the original task and its permissions.

## Make Interpretation Easy to Correct

Alternate investigation, questions, restatements, and examples as useful. Recompute the remaining questions after each answer. Group independent, easy questions when helpful; defer questions whose premises depend on an earlier answer. Neither one-question-at-a-time nor a fixed question count is required, and zero questions can be the right result.

Ask about concrete situations and effects. For example: “After a successful save, must another member see the change immediately, or is a short delay acceptable?” Explain a recommendation's basis and real cost when you have enough evidence; otherwise explore before recommending. Let the user reject the premise or the entire set of options, or delegate the decision. Do not converge by steering the user toward agreement.

Expose assumptions with their consequences: “I currently interpret reliable as accepted tasks must not be lost and failures can be retried; immediate completion is not yet a requirement. This would prioritize durable acceptance and recovery.” Such a restatement offers a correction opportunity; it does not establish the requirement or demand approval of every sentence.

Use the available user-interaction tool when appropriate, or a concise ordinary question when no suitable tool exists. Do not depend on a particular host API. A delegated worker without direct user access returns the question, essential context, answer implications, and any independent progress to the calling agent using the existing handoff mechanism; do not invent the answer or wait indefinitely for an unavailable channel.

## Update Without Changing Meaning or Authority

Apply partial answers only to the questions they actually resolve. Preserve scope, exceptions, thresholds, and negative conditions; single-item manual retry does not establish acceptance of all bulk failures. An ambiguous “yes” to several independent decisions may need a focused follow-up. Check a consequential ambiguity with a discriminating scenario when useful, not a confirmation ritual after every answer.

Distinguish a clarified meaning, a factual correction, and a new requirement. Reopen only affected judgments and dependencies. A newly requested guarantee is not retroactively an original obligation. Preserve known governing commitments and decision ownership; the newest statement or a repeated summary does not automatically supersede a binding constraint. Surface real conflicts without inventing additional organizational approvals.

For consequential items, keep user requirements, verified facts, provisional assumptions, candidate suggestions, and adopted or delegated decisions distinguishable. Natural language and necessary source references are sufficient; do not create a separate state protocol.

## Keep the Brief Proportional

A local clarification may need only a few sentences. For a whole task, include only useful elements: goal and use, audience, scope and output, constraints and priorities, important assumptions, settled or delegated choices, and unresolved items with their next steps. No mandatory template, file, or full rewrite after each answer is needed.

Reuse an existing authoritative artifact where appropriate; modify it only within the task's authorization. Do not create a competing source of truth or automatically save a task choice as a lasting preference. Keep working dialogue and handoff explanations separate from formal deliverables; retain only assumptions, decisions, and open conditions that the final artifact's audience needs.

A brief is not an approval form. Showing it does not by itself pause authorized work. An information question blocks only actions that need the answer; new authorization is required only for actions not already covered. Silence grants no permission, and updating the brief does not invalidate existing permission.

## Finish and Resume

Finish the current clarification when identified issues important to the next action have been answered, delegated, or isolated, and necessary remaining assumptions are visible. Fluency, confidence, assent, and question counts do not prove complete understanding. New evidence can reopen the relevant part later.

If evidence or a necessary decision is missing, state what is missing, what depends on it, and what can still proceed. If the user stops clarification, return the current understanding and unresolved items without claiming they are settled.

For a standalone clarification request, deliver that result. For a broader authorized task, the main agent resumes the original work after clarification rather than asking whether to start again; a delegated clarifier returns its bounded result to the caller. The clarification responsibility does not itself include full design, implementation, or acceptance, but it does not permanently restrict the main agent's original mandate either. Completion of this Skill is not completion of the broader task.
