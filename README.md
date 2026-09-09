# Darwin

> 让复杂任务从意图出发，以清晰责任和明确对象为边界，以可验证证据闭环。

![Darwin 系统变更控制闭环](assets/system-delivery-loop.png)

*图 1：一条代表性系统变更路径中的控制、专业工作与收敛关系。设计、交付及其评审按当前义务选择，不构成固定流水线；外环表达观察、关键缺口、控制检查、最小动作、Guard 与结果检查。*

Darwin 是一组面向 Codex 的系统级工程 Skills，用于在复杂任务中持续对齐目标、事实、责任、交付对象和完成证据。它不增加一套固定流程，而是让意图澄清、系统设计、方案评审、代码验收、E2E、体验走查、实现简化和长程控制各自拥有清晰边界。

其中八个专业 Skill 可以独立使用；`supervisor` 用于需要跨多项关键操作、交接、等待或权威状态变化保持一致的长程任务。

## 为什么需要 Darwin

复杂任务真正困难的地方，通常不是缺少生成方案或代码的能力，而是工作跨越多个角色、对象和回合后，原始意图、权威事实、决定与授权、专业判断和完成证据逐渐失去一致性。Darwin 通过持续缩小目标与当前结果之间的差距推进长程任务，同时让意图澄清、系统设计、方案评审、代码验收、E2E、产品走查和实现简化保持为彼此独立的专业责任。

| 要解决的痛点 | 整体思路 |
| --- | --- |
| 重要解释和默认假设直到成品阶段才显露，用户难以及时纠正 | 用简短的任务理解、问题或样例暴露影响结果的解释，借助调查和反馈明确必要上下文与取舍；只暂停依赖未决答案的工作。 |
| 用户想要的结果在设计和实施过程中逐渐漂移 | 把原始结果、范围、授权和完成标准作为稳定根基；后续方案、动作与判断都必须说明它们如何缩小当前结果差距。 |
| 已经明确授权的动作被反复确认，尚未授权的变化却被自动推进 | 区分信息澄清、用户决定、已有动作授权和平台审批；复用有效授权，只暂停确实依赖未决回答或新增授权的工作。 |
| 设计、代码实现、行为交付、评审和测试讨论的不是同一个对象 | 为每次设计、交付和验收绑定精确来源与版本；对象变化时只保留仍然有效的结论，并重新判断受影响部分。 |
| 专业作者、修改者和判断者相互替代，责任和结论失真 | 每个专业 Skill 只负责自己的产物或判断；`supervisor` 维护目标、对象、责任方和证据，但不替代事实来源、设计者、评审者、验收者或权限方。 |
| 固定流程关注“进行到哪一步”，却不能回答“现在最该解决什么” | 每轮根据最新事实定位会改变下一决策或完成判断的关键缺口，确认责任方、能力和授权，再选择一个能够产生判别证据的动作。 |
| 测试通过、PR 合并或状态完成被误当成最终结果 | 完成判断回到用户可观察结果：最终对象、有效专业结论和结果证据必须相互绑定，范围内义务、副作用和真实阻塞均已闭合。 |
| 功能 E2E 与产品体验走查混在一起，既无法准确证明系统结果，也容易把审美意见变成阻塞 | E2E 从结果义务和反例推导最小用例集；获准执行时，再用真实入口、可见结果、权威终态和必要副作用验证功能旅程。产品走查独立沿真实用户任务评价体验并报告有边界发现。 |
| 连续修补不断引入兼容、恢复和中间状态，维护路径和长期负担持续增加 | 当动作不再缩小原始缺口或责任面持续扩大时停止当前路线并重新建立基线；结果确认后删除没有现存义务的重复和过时路径，只保留必要的维护路径。 |

## 工作机制

各 Skill 可以独立使用，不存在设计、评审、实施、验收和清理的默认流水线。`intent-clarifier` 支持模型按任务需要自动选用，也支持显式调用；`skill-doctor` 也支持按描述自动选用；其他 Skill 保持显式调用。自动选用依赖运行环境能够发现该 Skill 及其描述匹配，不保证每次触发。执行 Agent 可以在设计等任务中应用澄清方法；控制角色仍通过原有委派机制处理澄清，不因此接管专业工作。

用户显式调用 `supervisor` 后，它只运行控制循环，不亲自执行领域工作，而是在原任务范围和副作用边界内，根据当前未闭合义务显式委派匹配的专业 Worker；没有匹配专业 Skill 时委派普通 Worker。它不会因此创建固定阶段、扩大授权或代替专业 Owner。只有控制信息需要跨上下文保留、且无法仅从领域权威状态恢复时，Supervisor 才维护私有 Markdown checkpoint。会话面向用户报告领域结果、决定性证据和必要阻塞；恢复需要时提供 checkpoint 引用。

## Skills

源码按用途分为五类；分类目录不改变 Skill 名称，安装和调用仍使用原名称。

| 类别 | 目录 | Skills |
| --- | --- | --- |
| 任务协调 | `skills/coordination/` | `supervisor`、`intent-clarifier` |
| 系统设计 | `skills/design/` | `overview-designer`、`design-reviewer` |
| 代码工程 | `skills/development/` | `code-reviewer`、`code-simplifier` |
| 产品验证 | `skills/verification/` | `e2e-verifier`、`ux-reviewer` |
| 指令维护 | `skills/maintenance/` | `skill-doctor` |

| Skill | 适用场景 | 核心做法 |
| --- | --- | --- |
| [`$supervisor`](skills/coordination/supervisor/SKILL.md) | 在跨操作、交接、等待和状态变化的长程任务中维持可恢复控制。 | 维护目标、决定与授权依据、权威对象、未完成事项、证据和活动动作；每轮确认实际责任方，把一个受控动作派给匹配的专业 Worker 或普通 Worker，并处理等待、交回、未知副作用、恢复和重新建立基线。 |
| [`$intent-clarifier`](skills/coordination/intent-clarifier/SKILL.md) | 在任务开始或进行中，澄清必要上下文、重要假设与属于用户的关键取舍。 | 通过调查、提问、简短 Brief 和样例，让用户检查并纠正任务解释；承担已委托的专业判断，复用既有授权，澄清后继续或交回原任务。 |
| [`$overview-designer`](skills/design/overview-designer/SKILL.md) | 创建目标系统设计产物，或对既有设计进行补全、修订、重写，包括对某个关键设计或局部的下钻设计。 | 从真实结果、约束和重要质量目标理解问题，塑造抽象与责任边界，比较方案收益和生命周期代价；用运行与变化场景检验整体设计，表达取舍、演进边界和未决条件。 |
| [`$design-reviewer`](skills/design/design-reviewer/SKILL.md) | 独立评审尚未实施的技术设计，包括 Agent/Harness 设计。 | 重建问题和真实起点，挑战关键设计判断；涉及 Agent/Harness 时检查模型自由度、有效组合、确定性约束、权威效果和验证设计，但不把设计判断扩张为交付或运行验收。 |
| [`$code-reviewer`](skills/development/code-reviewer/SKILL.md) | 验收指定的代码交付，而不是根据 diff 大小、测试数量、已批准设计或实现者声明判断完成。 | 从真实消费者和实际选中路径检查实现、接线、合同、状态、依赖、失败语义、迁移、运维和验证证据；对模型等非确定性运行行为的结论不超出相应证据。 |
| [`$code-simplifier`](skills/development/code-simplifier/SKILL.md) | 在行为目标和代码候选边界已明确后，优化实现过程中产生的候选代码。 | 逐项解释候选的实质改动，删除没有现存义务的内容；对必要实现按实际问题选择复用既有能力、调整责任、简化流程或重组结构，并只为已成立的不变量、消费者或真实边界增加最小结构，最终证明行为不变且总维护负担下降。 |
| [`$e2e-verifier`](skills/verification/e2e-verifier/SKILL.md) | 为具体产品或系统旅程推导端到端验收用例，或在获准执行时验证功能结果。 | 先固定验收对象和环境，再从关键结果义务与反例形成最小用例集；执行时选择真实入口，以可见结果和权威事实共同判定，并区分产品、验证器、脚手架与环境问题。 |
| [`$ux-reviewer`](skills/verification/ux-reviewer/SKILL.md) | 从目标用户完成真实任务的过程评价产品体验，而不是预设存在问题或证明后台功能正确。 | 沿代表性人机路径检查内容、信息层级、导航、动作、反馈、布局、可达性和恢复，用可复现证据判断缺陷、风险、偏好或有边界的未发现实质问题结论。 |

| [`$skill-doctor`](skills/maintenance/skill-doctor/SKILL.md) | 审查或精简 AGENTS.md 与 Agent Skill 指令。 | 根据实际义务诊断冗余、模糊、僵化流程和过度约束，报告问题、保留项与修改建议；默认只诊断，已授权修复时完成最小修改。 |

## 安装

使用 [Agent Skills CLI](https://github.com/vercel-labs/skills)，需要 Node.js 18 或更高版本。

查看仓库中的 Skills：

```sh
npx skills add lvjg/darwin-skills --list
```

将全部 Skills 全局安装给 Codex：

```sh
npx skills add lvjg/darwin-skills --skill '*' --global --agent codex --yes
```

只安装一个 Skill：

```sh
npx skills add lvjg/darwin-skills --skill design-reviewer --global --agent codex --yes
```

如需项目级安装，去掉 `--global`。

## 更新

目录调整和历史名称迁移见 [迁移指南](MIGRATIONS.md)。

重新运行全量安装命令，更新或补齐 Darwin 仓库中的全部 Skill：

```sh
npx skills add lvjg/darwin-skills --skill '*' --global --agent codex --yes
```

## 维护

`.agents/` 用于本地开发辅助技能，不属于发布目录；受版本管理的 Skill 源码统一放在 `skills/<category>/<skill-name>/`。

`skill-doctor` 当前没有行为评测；其余八个 Skill 保留现有 eval 集。

修改 Skill、评测或其他发布文件后，运行静态 Skill 包校验：

```sh
ruby scripts/validate-skills.rb --base HEAD
```

需要回归已覆盖的模型行为时，再按 [Skill 评测指南](evals/README.md) 运行独立 eval。eval 不是 benchmark 或行为真源；真实任务中的用户目标、领域权威和实际缺陷优先，不能为了通过 case 扭曲 Skill。静态包校验不证明行为正确，eval 也不替代发布结构检查。

Pull Request 和 `main` 分支上的两类检查由 [Validation workflow](.github/workflows/validation.yml) 执行：`skill-packages` 校验全部 Skill 的静态发布合同，`eval-format` 用固定 Skill-Up 版本校验 Anthropic `evals.json`。PR 不调用模型；真实行为运行需要在目标 engine/model 和权限边界下另行执行。

## 全局工程原则

[`templates/AGENTS.md`](templates/AGENTS.md) 是供分发和复用的 Codex 全局工程指令模板。它不是 Skill，不会由 Agent Skills CLI 安装，也不会在仓库根目录执行任务时作为项目指令自动加载。作为全局指令使用前，请先审阅其内容。

## 许可证

本项目采用 [MIT License](LICENSE)。
