# Designer 重构实施方案

本文保留重构时的设计依据、候选正文及行为评测计划，是历史方案。当前入口、正文和配套资源以 [Designer](skills/design/designer/SKILL.md) 及其引用文件为准；下文的旧名称、拟议迁移步骤和候选内容不作为当前执行规范。仓库中的重构已完成，实际行为收益和对照采用条件尚未验证。

## 1. 决策与目标

将现有 `overview-designer` 重构为负责完整技术方案的 **Designer**，建议将正式入口同步改为 `designer`。这是原 Skill 的职责澄清与迁移，不新增并存的概要设计、详细设计或研究 Skill。本方案保留显式调用方式；实际重命名随获选版本采用一并实施。

设计对象包括系统、功能、流程及其中的局部机制。它应先建立整个任务的理解，再识别值得深入的设计部分；局部机制形成后，回到全局检验是否共同实现目标。请求范围决定本次交付范围，设计重要性决定内容深度。名称变化不扩大到实现、纯现状说明或交付验收。

角色心智：**在问题模型与方案模型之间往返，通过证据和取舍使两者逐步吻合。** 问题模型概括目标、当前状态、关键对象、关系和约束；方案模型解释如何从起点产生结果。全局模型帮助选择深入位置，深入发现的新事实又可能改变总体方案。这是理解和设计的方法，不要求建立两个持久化模型或固定图表。

主线为：理解目标与现状 → 概括任务并建立抽象模型 → 识别关键设计和初步方向 → 对明确部分直接设计、对不确定部分调研和比较 → 选择并形成完整方案 → 从相关角度审视、反思并修正 → 表达结果。每一步使用前一步的判断；反馈返回受影响的位置。简单任务可以快速完成，有效旧结论可以直接复用。

验收目标是跨任务的全局理解、关键内容深度与适度决策能力。SOP 是暴露问题的回归案例；它的具体算法和参考论文不定义 Designer 的能力边界。

### 1.1 当前依据

原任务最初将较多内容放在边界、合同和恢复上；用户明确要求深入后，最后一轮补充了配置前置、就绪选择、方法筛选、局部上下文和影响传播。这说明该次运行能够产出这些设计内容，但未能在前期自主发现并充分发展它们。此观察不能单独证明原因完全来自 Skill，也不能证明新指令必然有效。

当前工作区已包含此前针对“设计内容”的局部补丁。本次基线必须是这份实际工作区副本，不能将它与原始版本混称。

- 仓库 HEAD：`9a528ef82724a273399a58dba07442637c419b54`。
- `SKILL.md` SHA-256：`1d0d6f387228c019bfaedcccd2c8a74e335db6e0848303e233882f2ffefc1054`。
- `references/overview-standard.md` SHA-256：`1bd5bbae4dfa91b3200f2be363cf48d93c87ef63fc45276015b74b4231c03c31`。
- `evals/evals.json` SHA-256：`e9d14cec527d4186a36d5ce011ddd098766dd1098dd2d4cd64bd386b64c61c61`。

这些标识用于复现本方案起点，不是新 Skill 的运行内容。

### 1.2 待验证的原因与对应修复

| 假设 | 对应修复 | 可观察证据 |
| --- | --- | --- |
| 原角色被概要或关键局部设计限制 | 对完整方案负责，按请求范围和设计重要性调整视野与深度 | 局部机制与全局行为相互解释，不遗漏连接 |
| 上一版候选偏向按缺口找动作，缺少总体过程 | 先理解任务、建立模型，再有依据地选择工作 | 能从任务事实识别主次，避免追逐局部症状 |
| 对深入设计的要求偏宣言 | 每一步给出输入、操作、下一项判断和返回条件 | 形成实质设计，而非报告完成了哪些步骤 |
| 研究和比较成为习惯性扩展 | 已知适用方案直接发展，不确定且重要时才调查比较 | 简单任务不被放大，困难任务投入到有效证据 |
| 局部论证替代整体反思 | 形成整合方案后，从目标、行为、可行性及总成本等相关角度审视 | 发现并修复部件之间的问题与错误假设 |
| 简化要求没有说明如何权衡 | 单独提供取舍参考，比较收益、代价、敏感条件和继续调查的价值 | 有证据地增减机制、停止调查或重新选择 |

## 2. 文件变更与内容职责

当前目录为 `/Users/lvjigen/Workspace/skills/skills/design/overview-designer/`，拟采用时迁移至 `/Users/lvjigen/Workspace/skills/skills/design/designer/`。

```text
designer/
  SKILL.md                              角色心智与完整设计过程
  agents/openai.yaml                    Designer 入口，保留显式调用策略
  references/
    design-standard.md                 全局与局部内容的一致表达
    design-decisions.md                重要且不明确的取舍方法
  evals/
    evals.json                         按 Designer 能力重新定义全部用例
    files/1..10/                       架构、算法策略、综合设计与范围控制材料
```

主体保留从任务进入到方案修正的主线。理解现状时核实项目事实；设计方法不明确时，优先寻找业界成熟方案、维护中的实现及相关论文，研究其方法和适用条件，再形成当前方案。取舍参考在重要选择不明确、成本难以比较或反思陷入反复时读取，成稿规范在表达和核对产物时读取。

候选不包含 examples 文件或教学式片段。当前没有经审查、足以作为完整设计质量参照的方案文档，因此不增加此类运行资料。未来只有完整文档本身在问题建模、总体方案、关键机制、取舍和证据上确实有参考价值，且与评测材料隔离时，才重新考虑。当前重构不以补一份示例为完成条件。

角色和过程不依赖思考帽、固定专家角色或并行 Agent。多角度审视从当前设计的参与者、依赖和目标中选取有作用的角度。它由同一个 Designer 完成，不依赖另外一个 Review Skill。

## 3. SKILL.md 完整候选正文

以下正文定义先后依赖清楚、允许反馈与复用的设计过程。它不要求固定章节、工作记录或每一步同等投入。英文运行指令按用户语言生成产物。

````markdown
---
name: designer
description: Use when explicitly invoked as $designer to create, complete, or revise a technical design for a system, feature, workflow, or mechanism, combining overall reasoning with substantive detail. Not for implementation, current-state explanation, read-only review, or delivery acceptance.
---

# Designer

## How to Approach the Work

Act as the designer responsible for a coherent solution to the user's problem. Work between an understanding of the problem and an explanation of how a solution produces the result. Use the overall picture to decide what needs deeper design; use what you learn in the details to correct the overall picture. A design can be broad or local in scope and still require both views.

Follow the process below: understand and model the task, identify the consequential design questions, develop answers with investigation where needed, choose and assemble the solution, then examine and improve it. These are dependencies in the work, not required output sections. Reuse sound prior work and return only to the conclusions affected by new evidence. A small, well-understood task may pass through the process quickly. An expression-only correction needs no new design exploration.

## 1. Understand the Task and Build a Working Model

Read the request and the relevant existing material. Establish what result is wanted, why it matters, what happens now, and what change is needed. Separate user requirements and adopted decisions from suggestions, inherited implementation choices, and assumptions. Identify constraints, important quality priorities, available capabilities, the requested scope, and the decisions you may make. Check current-system facts that could change the design; do not inventory the whole repository by default.

Form a concise account of the task in domain language: the starting situation, desired result, important constraints, and what remains unresolved. For an existing design, recover its valid decisions and the specific change requested. For a new system, describe the starting conditions without inventing an existing defect. Resolve discoverable facts yourself; ask about consequential user-owned choices only when the available context cannot settle them.

Build a working abstraction of the problem. Identify the actors or objects, relevant information and state, and the relationships or transformations that govern the result. Choose a representation that helps explain those relationships: a short narrative, flow, domain model, dependency relation, or another appropriate form. State the distinctions and assumptions on which the model depends. An abstraction should make an important case easier to reason about; it does not automatically require a new module, schema, or persistent store.

Test the model against a representative use. Can it explain the intended result, the current difficulty, and the material constraints? If not, correct the model or recover the missing fact before committing to a dependent design. Keep a provisional model when uncertainty remains, and mark which conclusions depend on it. Share a concise task summary when it helps alignment; do not require a separate modeling artifact.

## 2. Identify the Key Designs and an Initial Direction

Use the model to outline how the whole result might be produced. Locate the decisions that determine the approach, the difficult transformations, and the interactions where independently reasonable parts could fail together. Ask which choices would materially change behavior, usefulness, quality, or total cost. These are the places to deepen; they need not align with modules or service boundaries.

For each consequential question, decide whether the answer is sufficiently clear from the requirements, existing capabilities, and known methods. A familiar label is not enough: you must be able to explain how the approach handles a representative case and why its conditions hold. Develop clear answers directly. If a current-system premise is missing, verify it. If the design approach is unclear, look for established industry solutions and relevant research that could provide or distinguish viable methods. Keep routine details subordinate instead of treating every parameter as a design decision.

Order the work by dependency and consequence. Resolve questions that can invalidate the overall direction or force substantial rework before polishing their dependents. Update the provisional overall direction as those answers emerge. A local request still needs enough surrounding context to establish its inputs, effects, and obligations, but does not authorize redesigning the surrounding system.

## 3. Develop the Answers

For a clear question, develop the chosen mechanism to the depth needed by its consequences. Explain how the relevant input becomes the result, including the representation, operation, rule, or interaction that performs the decisive work. If an actor must select, coordinate, optimize, validate, or repair, settle how that action is supported when its method determines success. Human or model judgment may remain; specify its information, discretion, feedback, and handling of unresolved cases without pretending judgment is deterministic.

When the design approach is unclear, identify the underlying technical problem and look for established solutions before inventing a new mechanism. Search relevant industry designs, maintained projects or libraries, and research papers. Use engineering sources to understand practical composition, operating constraints, and maintenance; use papers to understand algorithms, alternative formulations, assumptions, and evaluated tradeoffs. Prefer methods that fit the task over novelty or popularity, and do not require both source types for every decision. A known approach whose applicability is already supported needs no ceremonial literature search.

Select promising material from its problem and conditions, then read the method, algorithm, relevant implementation, and evidence deeply enough to reconstruct how it works. Do not stop at an abstract, product feature list, or architecture diagram. Follow an explicitly supplied reference to the part needed for the task. If applying the method depends on an unknown local capability or contract, return to the current system and verify that fact; repository investigation alone does not supply the missing design approach.

Extract the mechanism rather than a slogan: how it represents the problem, chooses or produces results, receives feedback, and handles its limits. Compare its assumptions with the current task. Identify work the source leaves to a person, external system, or unavailable capability, and design the missing part if the proposed use depends on it. Distinguish the source's observed behavior from your adaptation and from an untested expectation.

Develop plausible alternatives where the choice remains consequential. Change the representation, decomposition, order, information acquisition, or feedback when this could solve the difficulty more effectively. Include the strongest direct or maintained approach. Apply alternatives to the same relevant case so their differences become concrete. Do not manufacture a candidate count or compare labels whose mechanisms remain unspecified.

Continue investigation while a reachable fact or method could change an important decision. Switch to construction or a bounded check when more reading no longer resolves the gap. If essential evidence is unavailable, preserve supported work and explain the dependent uncertainty. If a mechanism remains a list of responsibilities, return to the relevant method or implementation and work through its decisive operation on the current task. Do not substitute a generic illustrative story for the missing design.

## 4. Choose and Form the Whole Solution

Compare viable answers against the established requirements and priorities. Discard those that cannot satisfy a hard requirement. Judge the remaining differences by actual benefit, uncertainty, and the cost to users, builders, operators, and maintainers. Give alternatives the same constraints and permission to change existing arrangements. Prefer the simpler approach when benefits are comparable; accept additional complexity for a supported benefit that warrants its obligations.

For an important choice that remains unclear, read `references/design-decisions.md`. Identify what fact or preference could reverse the choice and seek the smallest evidence that can settle it. Explain the selected approach, its decisive reason, the cost accepted, and its conditions. Do not ask the user to make routine technical choices or present speculative scores as objective comparison.

Combine the selected mechanisms into an end-to-end solution. Trace how work starts, which information is available, how decisions and effects occur, and what result reaches the user or consumer. Resolve interfaces, responsibilities, shared assumptions, and applicable state or failure behavior at the places where the mechanisms meet. A set of good local designs is not yet evidence of a good whole.

Check whether combination changes the earlier tradeoffs: one part may create extra latency, lost information, coordination, or user effort elsewhere. Revise the affected choice when needed. Reuse existing contracts and capabilities that already meet an obligation; add mechanisms only for a real gap or supported benefit. Keep the whole model and the developed details consistent.

## 5. Examine, Reflect, and Improve

Once a coherent candidate exists, examine it from the perspectives that can expose a material mistake in this task. Consider the intended user or business result, the information and behavior inside the system, the feasibility of construction and operation, and the cost of maintaining and changing it. Select concrete questions from the actual participants, dependencies, and constraints; do not fill a fixed matrix of roles and failure categories.

From the user's perspective, trace a meaningful case and ask whether the result actually meets the need, including unresolved situations. From the system's perspective, check whether information, dependencies, and local rules compose into that behavior. From the delivery and maintenance perspectives, test the important assumptions about capability, cost, change, and responsibility. Give attention to a credible simpler alternative or a counterexample that could invalidate the choice, not only reasons supporting it.

Apply the proposed mechanism to a discriminating case using only information available at each point. If it succeeds only because you supply an unstated strategy, develop that missing design. For uncertain claims, use an appropriate calculation, contract check, or bounded local experiment within scope. Distinguish a worked example and planned validation from an executed result; formal validity alone does not establish intended meaning or practical quality.

Respond to what the examination finds. A missing fact returns to understanding or investigation; a wrong framing changes the model and its dependent designs; a failing mechanism requires redesign; a justified local omission can be filled locally. Do not automatically add a fallback, layer, or state to every objection. Test whether removing or changing a choice eliminates the problem more cleanly, and use the decision reference when the tradeoff is unclear.

End the reflection when material objections are resolved or bounded, the solution still meets its priorities, and further work is unlikely to change a consequential decision. Recheck the parts affected by a revision rather than restarting a universal review. State a condition when an unresolved fact can change the design; do not hide it behind a named owner or claim a complete solution prematurely.

## 6. Express the Design at the Needed Depth

Read `references/design-standard.md` when organizing and reconciling the deliverable. Explain the whole approach and develop the parts needed to understand, decide, or implement it. Scope follows the request; depth follows design significance. A complex design may need detailed strategy inside one component, while an established part needs only its role and contract.

Write in the user's language and use the project's terms. Keep the task, operating model, mechanisms, and important tradeoffs connected. Use prose, cases, diagrams, or pseudocode where each helps. Do not reproduce the Skill's process, working notes, or a mandatory overall/detail chapter split. Read the actual final artifact to confirm that the whole and its important details describe one coherent solution.

The design is ready at the requested scope when its result and operation are understandable, its consequential choices have sufficient basis or explicit conditions, and implementation can proceed without inventing its central strategy. Interchangeable coding details may remain open. If the user requested only a direction or bounded exploration, deliver that level and identify what remains to be designed instead of expanding the assignment.

## Scope and Evidence Boundaries

Preserve valid adopted decisions and the user's limits. When facts invalidate an adopted route that you may not replace, stop extending the invalid part, explain the conflict and available alternatives, and continue independent work. Do not turn a correction of evidence or expression into an unauthorized redesign.

Update revised designs coherently: retain valid content, incorporate accepted changes, and remove superseded mechanisms and their dependents. Add compatibility, migration, recovery, history, or persistent state only for an active need. Use existing project conventions when status or revision records matter.

Investigation and bounded local analysis must stay within the request. A design task does not authorize implementation, production changes, publication, or contacting others. Distinguish current facts, proposed behavior, measured results, estimates, design adoption, implementation, and external validation where the distinction affects the decision.
````

## 4. design-standard.md 完整候选正文

该文件指导同一方案在不同尺度上的表达。总体方案与关键细节可以在同一产物中组织，也可以按用户请求拆分；不由 Skill 固定划分为概要和详细两类产物。主体提供理解、设计、审视的过程，参考文件避免重复该过程。

````markdown
# Design Artifact Standard

Write for the people who must understand, choose, implement, or maintain this design. Use the user's language and established project terms. Respect an existing required format; otherwise choose a small structure that makes the operating idea and important choices clear. Do not organize the artifact around the Skill's process or give every module equal space.

## Overall Design

Open with the required result, the proposed approach, and the principal reason it fits. Include only background and constraints needed to understand the design. Keep proposed behavior distinguishable from current implementation where that distinction matters.

Establish enough overall context for the requested scope, then explain the details on which its result depends. Return from an important detail to its effect on the whole, especially when it changes another decision or assumption.

For a whole-system design, explain how the main mechanisms cooperate and trace a representative input or use to its visible result. Make the important responsibilities, information dependencies, and effects understandable. Use a relationship or flow diagram when it clarifies the mechanism. A module diagram or tool-call list alone cannot explain the decisive work.

For a local design, state its result and relationship to the adopted surrounding design, then develop that mechanism directly. Do not reconstruct the entire system merely to fill an overview structure.

## Key Mechanisms and Choices

Give a key design its own explanation when its internal choices materially determine the outcome or a major quality or cost. Name it for the problem or result it addresses. Open with the mechanism selected and the reason for that choice.

Explain how the relevant input becomes the result. Include the representation, operation, selection rule, interaction, or feedback that performs the decisive work, together with only the contracts and state needed to understand it. Use a worked case, diagram, decision table, or pseudocode when it makes the mechanism easier to inspect. No particular form is required.

Keep the strongest material alternative, selection basis, costs, and reconsideration condition beside the choice they explain. Describe research at the point where it supports or limits the mechanism; distinguish a source's method and evidence from the adaptation proposed here. A literature survey is not required unless requested.

Allocate detail by design significance. Preserve a difficult internal strategy even if it belongs to one module. Leave ordinary code organization and interchangeable implementation details to implementation.

## Conditions, Validation, and Change

Place assumptions and unresolved conditions with the affected design. State what they can change and what evidence or decision is needed. A final open-issues list is useful only for matters that affect the overall next step; omit an empty list.

Explain the few checks or experiments that can establish the important behavior or discriminate among remaining alternatives. Clearly distinguish actual results from proposed validation. Formal validity, intended meaning, and practical quality may require different evidence.

Include transition, compatibility, rollout, or recovery details only where an active obligation or the chosen mechanism makes them material. Use the existing owners and paths where they suffice. Do not add a roadmap for hypothetical requirements.

For revisions, make the current text internally consistent and preserve still-valid content. Use existing project conventions for status and change history when needed by the reader. Do not invent version identifiers, revision tables, or approval claims. A historical note cannot substitute for updating the design itself.

## Final Reading

Read the actual artifact and resolve these questions proportionately to scope:

- Can the reader explain the whole or local result and how it is produced?
- Can the decisive behavior be applied to a concrete case without supplying an unstated strategy?
- Are the important choices, costs, evidence, and conditions understandable?
- Do the prose, diagrams, cases, and existing contracts describe a consistent design?

Remove repeated governance statements and text that adds no understanding. When a mechanism is missing, repair the design instead of adding a heading, responsibility declaration, or surrounding implementation detail.
````

## 5. design-decisions.md 完整候选正文

在选择重要且不明确、多个目标冲突、继续调查是否值得，或反思引发反复扩展时读取。以下方法同样用于选择路线、内部策略、设计深度和停止继续工作。

````markdown
# Design Decisions and Proportionate Effort

Use this reference to resolve a consequential tradeoff, not to score every design detail. Start with the decision in its context: what result it affects, which alternatives are actually viable, and what is currently preventing a choice.

## Establish What Matters

Separate conditions every acceptable solution must meet from qualities that can trade against one another. Ground priorities in the user's goal, actual constraints, and affected parties. Do not manufacture a stronger guarantee to favor a design. If a required value judgment is unclear and would reverse the choice, ask its owner; settle ordinary technical choices yourself.

Make each criterion concrete enough to distinguish the alternatives. Replace “more flexible” with the supported change it makes easier; replace “more reliable” with the failure and result it improves. A criterion that does not affect the choice needs no elaborate analysis.

## Compare Real Mechanisms Fairly

Describe the actual behavior of the alternatives under the same input and permitted conditions. Include the strongest simple or maintained option, and give it the same opportunity to make authorized changes as a more complex candidate. Eliminate an option for a specific violated requirement, not for lacking a preferred pattern.

Identify the differences that matter: benefit, what is lost, who bears the cost, and whether a choice can be changed later. Include coordination, learning, operation, and transition where they are real. Remove options that offer no relevant advantage while imposing extra cost. When remaining options trade different advantages, follow the established priorities rather than adding an arbitrary total score.

Use quantities when there is a meaningful basis. Keep measured values, estimates, and assumed ranges distinct. For qualitative comparison, explain a concrete consequence instead of inventing numeric weights. A conditional recommendation is more useful than a precise-looking unsupported ranking.

## Resolve the Uncertainty That Could Change the Choice

Identify the assumption or preference that could reverse the recommendation. Ask what observable evidence would discriminate between the options: a contract, a representative trace, a calculation, a prototype result, or an affected user's answer. Prefer evidence about the decisive difference over a broad inventory of advantages.

Consider the value of further investigation: could its result realistically change the decision, is that decision consequential, and is the information obtainable at reasonable cost? If yes, make the bounded check. If another reference repeats known information, stop reading. If the uncertainty requires an experiment, do not substitute more citations. If no practical check can settle it, bound the conclusion and state the consequence.

Where the result depends on an estimate, vary it over a plausible range. If the recommendation remains unchanged, refinement may add little value. If a modest change reverses it, obtain better evidence or prefer a reversible choice when that still meets the need. Do not defer a necessary commitment merely because perfect certainty is unavailable.

## Choose, Limit, or Remove

State the recommendation with its decisive basis, accepted disadvantage, and the condition that would change it. Resolve clear choices directly. Do not keep incompatible options as simultaneous implementation paths merely to avoid choosing.

Before adding a layer, configuration, state, fallback, or workflow, identify the actual problem it resolves and compare the cost with a direct change, reuse, or removal. Before deleting an existing mechanism, identify the active behavior or consumer it still serves. “Simpler” does not justify losing required meaning; “more robust” does not justify an unsupported obligation.

Apply the same reasoning to the amount of design work. Deepen a decision when a plausible answer can change the outcome, approach, or material cost. Stop when remaining variation is interchangeable implementation detail or when the next investigation is unlikely to affect the choice. A reversible low-impact choice usually needs less evidence than an expensive commitment that is hard to undo.

## Use Reflection to Improve, Not Accumulate

Treat an objection as a hypothesis about a specific failure or cost. Test whether it is credible under the task's conditions and whether existing behavior already addresses it. If it matters, compare changing the core approach, filling the local gap, and accepting a permitted limitation. Do not automatically add another mechanism.

After revising, inspect the affected consequences in the whole solution. Reopen unrelated decisions only when their assumptions changed. Stop the loop when material objections have answers or explicit decision conditions and there is no new reason to expect further work to change the design.

````

## 6. 入口元数据完整候选

````yaml
interface:
  display_name: "Designer"
  short_description: "Develop coherent designs with global and local depth"
  default_prompt: "Use $designer to understand and model the task, develop its key designs with research where needed, choose a coherent solution, and examine and refine it at the appropriate depth."
policy:
  allow_implicit_invocation: false
````

保持现有 `allow_implicit_invocation: false`。不增加其他 Skill 依赖，不绑定特定研究工具、模型或多 Agent 运行方式。

## 7. 旧内容迁移与删除清单

| 原内容 | 处理 |
| --- | --- |
| overview 或关键局部设计的角色边界 | 统一为对技术方案负责的 Designer；以请求范围和设计重要性决定尺度 |
| 旧五阶段的阶段退出、状态分类和重复约束 | 删除治理脚手架，保留理解、形成、检验之间的必要依赖 |
| 上一版“按缺口找下一步”的主体组织 | 替换为理解建模、识别关键设计、发展答案、整合方案、审视修正、表达结果 |
| 目标、现状、质量优先级和既定决定 | 集中到任务理解，形成任务概括及工作模型 |
| 模型只在局部卡住时出现 | 在选择方案前先形成全局模型，后续允许由局部发现修正模型 |
| selection proof、handoff guarantee 和统一状态术语 | 移除术语；必要依据、合同、未决条件进入具体设计 |
| 分散在主体的大量取舍规则 | 主体保留基本决策动作，深入方法进入 design-decisions.md |
| 仅有局部场景推演和风险检查 | 形成整体方案后，主动从相关角度检查目标、全局行为、可行性和代价 |
| 统一修订枚举和强制历史表达 | 按用户与项目约定表达必要变更，保持当前方案一致 |
| SOP 困难作为整体验收目标 | SOP 是综合设计案例之一；按架构、算法策略及组合能力重新构建评测 |
| 现有教学示例和逐步累积的 17 例 | 删除候选示例；重写评测集，不以原用例和旧结论约束新角色 |
| 笼统的“调查事实” | 区分现状核实与方案研究；方法不明确时优先学习成熟方案及相关论文 |

### 7.1 名称迁移

采用新名称时迁移原目录，更新 frontmatter、入口元数据、evals.json 的 skill_name 与执行题面，并将 overview-standard.md 改名为 design-standard.md。只保留一个可调用入口。

本次已定位的维护引用还包括：

- `/Users/lvjigen/Workspace/skills/README.md` 中的能力入口与说明。
- `/Users/lvjigen/Workspace/skills/skills/coordination/supervisor/references/capability-fallback.md` 中的能力名。
- `/Users/lvjigen/Workspace/skills/skills/coordination/supervisor/evals/files/18/task/root-intent.md` 中的调用说明。

实施时再次检索调用名称和旧路径，区分活跃调用与历史记录。更新活跃引用；历史证据不批量改名。安装版本的旧入口随获选版本同步时迁移，不能因为改名而并存两份职责相同的 Skill。此处是迁移规格，本轮没有重命名现有 Skill。

## 8. 评测完整重写

### 8.1 评什么

以 Designer 的能力重新定义 `evals.json` 和输入材料。旧 17 例不再作为必须兼容的验收集，只在版本记录及冻结基线中保留。仍然有价值的真实约束，如保持用户要求、只修改授权产物、区分已知与推测，按新任务重新嵌入。

评测分为四组：整体架构、难点算法策略、架构与算法结合、工作范围和投入控制。每组单独报告结果。架构题不能只靠算法深度通过，算法题不能只靠正确的职责边界通过，综合题必须同时体现两者及其连接。

### 8.2 全新用例集

以下为拟新建的十个用例。编号属于新评测集，与原 1–17 例无对应关系。输入是自然任务与原始材料，不能出现“需要建模”“请比较某算法”等考点提示；裁判单独持有判据。

| 新编号 | 类型 | 任务 | 主要设计能力 |
| --- | --- | --- | --- |
| 1 | 架构 | 多入口订单处理 | 业务身份、责任划分、外部效果及完整协作 |
| 2 | 架构 | 多区域配置发布 | 版本与依赖、可用性取舍、发布到实际生效 |
| 3 | 架构 | 大数据量导出 | 数据路径、资源约束、交付方式与整体代价 |
| 4 | 算法策略 | 维修工单分配 | 约束表示、候选选择、整体可行性与修正 |
| 5 | 算法策略 | 用户反馈归并 | 语义依据、整体分组、歧义和质量检查 |
| 6 | 算法策略 | 增量构建计划 | 变化影响、依赖与缓存有效性、重算范围 |
| 7 | 综合 | 文档到 SOP 模板 | 文档解释与生成策略、作者系统和整体完成 |
| 8 | 综合 | 依赖升级诊断助手 | 证据获取与诊断策略、工具环境及人机协作 |
| 9 | 克制 | 只读构建版本展示 | 已有能力明确时直接完成适度设计 |
| 10 | 修订 | 已采用方案的条件变化 | 重新建模和取舍、保留有效设计与范围 |

#### Case 1：多入口订单处理

**题面：** `$designer 根据 evals/files/1/context/ 的业务要求和现有系统资料，设计网站、客服和合作方创建订单的统一处理方案，写入 evals/files/1/design/solution.md。只交付设计。`

**材料：** 三个入口的真实或明确构造的业务身份与请求样本，订单、支付和履约现有接口，超时和重复提交记录；包含同一购买意图被重新提交，也包含同一商品的两次真实购买。接口事实说明哪些支持查询或稳定请求身份，不能假定全部支持事务。

**判据：** 整体业务结果定义清楚；方案能区分重试与新的购买意图；订单、支付和履约的职责及效果一致；未知结果得到与现有能力相符的处理。不预设必须新建编排服务或特定事务模式。仅说明 API 去重或列服务图不满足。

#### Case 2：多区域配置发布

**题面：** `$designer 根据 evals/files/2/context/ 设计配置从编辑、发布到多个区域运行时生效的方案，写入 evals/files/2/design/solution.md。`

**材料：** 已有配置存储和分发设施、明确的生效目标、区域断连条件、版本兼容范围，以及依赖更新顺序的配置样本。可接受延迟与是否要求区域同时生效必须作为业务输入给出，不能由裁判隐含补造强保证。

**判据：** 区分发布与各区域生效，完整解释版本、依赖与实际运行行为；根据给定要求选择一致性和可用性取舍；对断连与兼容条件给出可行设计。接受复用现有路径或有依据的新机制，不强制统一平台、全局同步或固定状态枚举。

#### Case 3：大数据量导出

**题面：** `$designer 根据 evals/files/3/context/ 为分析产品设计数据导出能力，写入 evals/files/3/design/solution.md。`

**材料：** 数据来源、典型和最大规模、内存与请求时间限制、现有对象存储或流式接口能力、用户对等待和数据一致性的实际要求。小任务与大任务均有样本。参数应来自可信观测或明确标注的合成测试条件。

**判据：** 数据读取、处理、传输和用户获取结果形成完整路径；对同步/异步、流式/物化等真正相关选择说明依据；不能在任一步暗中要求全量数据进入内存；规模不同是否需要不同处理有具体理由。错误与过期行为与选定路径相容，不要求添加不必要的通用作业平台。

#### Case 4：维修工单分配

**题面：** `$designer 根据 evals/files/4/context/ 设计维修工单分配策略，写入 evals/files/4/design/solution.md，供维护主管判断、工程师实现。`

**材料：** 工单的技能、位置、时限以及人员能力、可用时间和行程限制；明确业务优先级。原始数据应包含单次贪心选择影响后续可行性、多个合理分配、整体不可行三类情况。题面不命名调度算法。

**判据：** 问题表示保留关键约束；候选产生、选择、必要的修正及不可行情形可解释；能将所选方法应用于数据，并说明质量与计算代价。成熟求解器、直接策略或其他方法都可接受。仅写“调度引擎选择最合适人员”不满足；不要求保证未被证明的最优性。

#### Case 5：用户反馈归并

**题面：** `$designer 根据 evals/files/5/context/ 为客服反馈整理功能设计归并方法，写入 evals/files/5/design/solution.md。已有服务边界不变。`

**材料：** 重新收集或构造未用于旧第 17 例的反馈，保留否定、版本、操作和结果；包含描述相似但问题不同、局部相似链、语义不确定三种情况。不得附上旧答案和提示性问题清单。

**判据：** 解释同一问题的判断依据、分组形成方式与整体一致性；不靠一条模糊反馈将不相容问题连接；歧义得到有用的处理；完整覆盖与保留原意有可执行的检查。允许模型判断，但必须说明上下文、约束、反馈和验证。不得以固定相似度分数、向量库或 Agent 数量作为答案。

#### Case 6：增量构建计划

**题面：** `$designer 根据 evals/files/6/context/ 设计项目变更后的增量构建计划，写入 evals/files/6/design/solution.md。`

**材料：** 任务依赖、工具链和参数、输入输出关系、既有缓存能力、变更记录；包含内容未变但时间戳变化、工具版本变化、共享生成物影响多个任务等情况。依赖声明是否完整必须明确，不能把未知依赖当作已经可计算。

**判据：** 解释有效性依据、影响传播、任务选择及执行顺序；计算路径能避免错误复用，重算范围的代价有依据；对不完整依赖作出正确限制。接受成熟构建系统机制或合理的本地方案，不强制内容寻址、特定哈希或图算法名。只有缓存服务职责和依赖图概述不满足。

#### Case 7：文档到 SOP 模板

**题面：** `$designer 根据 evals/files/7/context/ 中的业务文档和现有系统资料，设计将这类文档转换为可编辑 SOP 模板的能力，写入 evals/files/7/design/solution.md。`

**材料：** 从原任务取得完整原始业务文档、原目标及适用能力资料；去掉后来生成的算法、问题清单和最终设计。当前原案例目录没有单独的完整原文，应从原会话条目恢复；恢复不了时明确改为构造用例，不能宣称原案复现。

**判据：** 全局解释来源、创作、工具和最终结果之间的关系；自主识别原文解释、结构形成、配置选择和修正中的难点；关键策略可用于具体原文；系统的形式校验与业务正确性有各自的支撑。既不能只交付模块边界，也不能只有脱离实际工具能力的算法。

#### Case 8：依赖升级诊断助手

**题面：** `$designer 根据 evals/files/8/context/ 设计帮助维护者理解依赖升级失败并提出修复建议的助手，写入 evals/files/8/design/solution.md。本次不修改被分析项目。`

**材料：** 升级前后依赖声明、变更范围、失败输出、可用的源码读取和隔离验证工具；包含 API 变化、传递依赖冲突和多个独立失败。给定权限、时间与计算预算，明确建议是否需要人工采纳。

**判据：** 从维护者目标到证据获取、诊断、建议和验证形成完整方案；能区分解释并选择有区分力的调查动作；策略有停止或未决条件，输出有依据；工具环境和权限支持该策略。不能将“诊断 Agent 找根因”作为核心机制，也不要求自动修改或新建多 Agent 架构。

#### Case 9：简单明确的任务

**题面：** `$designer 根据 evals/files/9/context/ 为管理员查看当前构建版本设计最小改动，写入 evals/files/9/design/solution.md。`

**材料：** 已有受保护版本接口、Gateway、页面入口、明确字段和不可用语义；没有历史查询、实时推送或高频大规模需求。

**判据：** 直接复用能力，完整解释读取和呈现；深度适合任务；无需为方法研究而搜索论文、生成候选表或新增平台。允许与某项实际未知直接相关的短调查，不以零搜索次数或固定字数作为标准。

#### Case 10：既定方案的条件变化

**题面：** `$designer 根据 evals/files/10/context/ 中的新条件修改已采用的分配方案，更新 evals/files/10/design/solution.md。允许调整分配策略，保留未受影响的业务要求与系统边界。`

**材料：** 一份完整可理解的既定设计及独立来源的新事实：由已知批次任务变为持续到达，已确认分配不能随意撤回；不附替代路线。约束变化要实际影响原策略的成立前提。

**判据：** 定位失效假设，修正模型、策略与整体行为；保留未受影响部分；解释新条件下的取舍；不只修改措辞，也不无界扩写周边系统。给定历史的修订评测不宣称验证了真实多轮交互能力。

### 8.3 研究能力的对照变体

对 Case 2、4、6、7、8 按需要设置两个相同任务的资料条件，用来区分寻找方法与迁移方法：

- **开放研究条件：** 提供目标、原始输入、系统事实和可用搜索能力，不提供方法目录。观察是否自主寻找成熟方案或论文，是否读到支撑关键设计的内容。已知适用方法能充分支持设计时，不能仅因未搜索而判其设计无效；这类运行对自主检索能力不提供正面证据。
- **参考转化条件：** 在同样任务下，提供版本明确的相关项目和论文原文入口或许可允许的快照，以及表面相关但前提不同的材料。不给借鉴总结。观察能否判断适用性、读懂具体机制，并补上当前任务的缺口。

只在真正需要研究方法的题目上测试这项能力。设计选用已有成熟方法同样可以是高质量答案，不要求提出新算法，不奖励论文数量、项目热度或新颖程度。

保存来源 URL、版本或 commit、获取时间和范围；不将已加工的参考答案注入执行环境。用于研究的资料与用于评分的答案严格分离。材料不可访问时记录为环境限制，不能把访问失败当作方法研究通过。

### 8.4 评分依据

共同检查任务理解、实质内容、取舍依据、证据诚实与范围控制，但按任务类型判断主次：

| 维度 | 不充分的表现 | 有效证据 |
| --- | --- | --- |
| 任务理解与模型 | 复述需求或照搬模块名 | 保留决定行为的对象、关系与限制，能解释具体情形 |
| 整体架构 | 只有服务边界或组件清单 | 数据、控制、效果与用户结果连贯，局部前提相容 |
| 算法和策略 | 将关键动作委托给引擎或模型 | 表示、操作、选择与反馈可应用于原始材料 |
| 方法研究 | 引用名称、摘要或宣传特性 | 读到机制和限制，明确复用、适配或排除理由 |
| 取舍 | 空泛优缺点、伪造权重 | 相同条件下比较真实差异，说明接受的代价与改变选择的条件 |
| 审视和修正 | 声称已多角度审查 | 重要反例、组合冲突和限制得到解决或有依据地界定 |
| 克制与可信度 | 新增无关机制或声称未做的验证 | 深度与风险相称，事实、推断和待验证内容清楚 |

架构类 1–3 必须在整体架构和任务所需的关键内容上成立；算法类 4–6 必须形成可推演的策略，并与给定外围条件相容；综合类 7–8 同时满足两者；9–10 重点检验明确任务不扩展、变化时能够正确修改。

不把以上维度机械加权成总分。每例定义少量与具体业务结果相关的必要断言，报告逐项通过、失败、证据不足与解释。严重语义错误不能被篇幅、引用或其他维度的优点抵消。

评测读取实际最终文件及必要执行证据，使用 `[artifact-markdown path=...]` 采集。过程自述、章节标题、规定术语、候选数量和伪代码数量都不是通过条件。对等价但不同的合理设计，裁判按同一目标和约束判断，不匹配唯一标准架构或指定算法。

### 8.5 对照与隔离

设置三组：A 为本方案起点的当前工作区 Skill，B 为本次候选主体及两个参考文件，C 为只包含以下角色要求的短指令。三组使用同一套全新测试材料，不用旧用例充当 A 的专属评测。

> Act as the designer for the requested technical solution. Understand the goal and current situation, model the problem, identify and develop the key designs, seek established approaches and relevant research when needed, then choose, examine, and refine a coherent solution. Balance global understanding, substantive detail, and effort with the task's importance. Preserve the user's constraints and distinguish proposed behavior from verified facts.

内容对照在隔离副本中临时统一调用名 `overview-designer`，只替换名字、调用文本和 evals.skill_name；所有组的任务、原始材料、工具权限、模型和预算一致。真实采用后再以 `designer` 检查入口迁移。实验别名不进入发布版本。

先冻结材料和判据，再运行模型。执行环境不得包含裁判答案、缺陷诊断和本重构方案。即使只安装目标 Skill，也要核实 evals 是否被一并安装并可被搜索；必要时从运行安装副本排除整个 evals 目录，原始任务材料由独立工作区提供。裁判可以读取原始输入、最终产物和执行证据，执行者不能读取裁判材料。

A/B/C 以交错顺序运行，对盲评隐藏版本标签。未来若提供高质量方案文档作参考，需要另外评估它的内容增益与答案泄漏风险；当前没有这一变量。

### 8.6 运行和采用

先在架构、算法、综合和简单任务各选一例做每组一次的诊断运行，例如 2、4、7、9。修复明确的问题后，再在冻结的十例上各组三次独立运行，研究变体单独报告。次数用于观察稳定性，不宣称统计显著。

报告按架构、算法策略、综合和范围控制四组展开，附有代表性的原始设计内容、关键失败、token、耗时和工具成本。研究资料变化或不可访问另列，不混入版本质量归因。

采用候选 B 需要：

1. 在架构和算法两类任务上均有可靠表现，相对 A 有可重复、可解释的改善；一类变好不能掩盖另一类退步。
2. 综合任务体现全局结构与内部机制的衔接，而非分别填充两组内容。
3. 研究改善体现在方法选择、适配与设计质量，且不会让简单任务无故扩展。
4. 相对 C，完整指令的额外成本带来实质增益；若短指令同样好，缩减 B。
5. 范围、真实事实和验证声明保持可信，评测结论有实际产物支撑。

结果摇摆时针对相关用例重复或做有限消融，例如去掉取舍参考、缩短研究操作。若都失败，先检查任务材料、工具条件和模型能力，不能默认继续加长 Skill。旧例可以用于定位已知问题，但不恢复为必须全部通过的兼容门槛。

### 8.7 文件与运行接线

继续用现有 `evals/evals.json` 格式：`skill_name`、`evals`，每例含 `id`、`prompt`、`expected_output`、`files`、`expectations`。保留仓库已有执行器，不新建测试框架。

实际替换时先冻结旧基线，再用新 1–10 例原子替换 evals.json 和对应目录，删除不再使用的旧 fixtures，避免同号混用。旧测试历史由版本记录或基线副本保存，不进入运行参考。

现有 `evals/run-evals` 支持绝对 Skill 路径、`--case`、`--iteration`、`--output-root`、`--skill-context target`。来源条件变体用隔离套件切换同一题面和资料，不给运行 Agent 暴露变体的预期结论。

实施迁移后的静态命令：

```sh
ruby scripts/validate-skills.rb --base HEAD
python3 /Users/lvjigen/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/design/designer
evals/run-evals --model ci-placeholder --dry-run designer
```

静态检查和 dry-run 只证明格式与配置。真实运行使用已配置模型及授权预算，执行产物保存在隔离输出目录，不把 placeholder 或评测计划当成效果证据。

## 9. 实施顺序与交付

1. **冻结起点。** 保存实际工作区 A 副本、旧评测和当前 diff；为 B/C 建立隔离目录。没有必要创建第二个用户可调用 Skill。
2. **重建并冻结评测。** 按架构、算法策略、综合和范围控制制作新套件，完成原始资料恢复、脱敏及裁判审查，确认执行与裁判隔离。原案资料和研究资料的限制分别记录。
3. **落地候选。** 按本方案替换 B 的主体、成稿规范、元数据和取舍参考。候选不包含 examples。核对所有运行引用的可达性。
4. **静态与小样本。** 完成格式检查及第一轮行为观察，针对真实失败修正候选或有缺陷的用例，并记录修正原因。
5. **分类型对照。** 执行架构、算法、综合及范围控制的重复对照和研究变体；根据具体结果做有限消融，删除没有增益的内容。
6. **采用和交付。** 满足采用条件后，用获选版本迁移为 Designer，更新活跃引用并检查调用，交付最终 diff、评测证据、已知限制。安装同步、提交和发布分别按当时授权执行，不将设计采用等同于这些动作完成。

最终报告包含：主体改动与删减、新评测集、架构与算法等每类能力的结果、研究转化效果、成本、仍未解决的问题，以及仓库和安装版本各自状态。

本次方案的交付物是本文件，其中候选正文可直接用于下一步实施。验收关注模型能否先形成正确的任务理解和模型，兼顾全局与关键内容，作出适度取舍，并通过审视形成更好的完整方案。章节顺序只是工作指导，不能代替这些能力。
