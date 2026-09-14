# Darwin

> 帮助 Codex 理清需求、审视方案、改进代码，并验证交付结果。

使用 Codex 完成工程任务时，你可能遇到过这些情况：代码写出来了，需求却理解偏了；方案不断补充，复杂度也不断增加；测试全部通过，真实流程仍然走不通。

Darwin 是一组面向 Codex 的工程 Skills，把需求澄清、技术方案设计、专业评审和结果验证落实到具体任务中。你可以从一次方案评审开始，也可以在长任务中使用 `supervisor` 协调推进。

[快速开始](#快速开始) · [选择 Skill](#skills) · [使用示例](#使用示例) · [安装与更新](#安装与更新)

## 为什么需要 Darwin

| 工作中遇到的问题 | Darwin 的处理思路 |
| --- | --- |
| 实现完成后，才发现需求理解有偏差 | 提前暴露关键假设，用调查、问题和样例澄清目标。 |
| 方案写清了模块职责，却没解释关键问题如何解决 | 建立整体理解，深入关键机制，按需研究成熟方法并作出设计取舍。 |
| 方案和代码不断增加，必要性却说不清 | 从实际问题、消费者和约束判断哪些结构值得保留，寻找更简单可靠的实现。 |
| 测试通过，但还不能确认用户目标已经实现 | 沿真实使用路径检查可见结果、最终状态和必要副作用。 |
| 任务跨越多个回合后，目标、决定和进度逐渐失真 | 持续维护目标、有效决定、未完成事项和结果证据。 |

每个 Skill 承担一项明确的专业责任。按当前问题选择需要的能力；跨多项工作的长任务可以交给 `supervisor` 协调。评审和验证围绕实际方案、代码版本或运行环境展开，让结论能够追溯到依据。

## 快速开始

先尝试一次设计评审。使用 [Agent Skills CLI](https://github.com/vercel-labs/skills) 安装 `design-reviewer`，需要 Node.js 18 或更高版本：

```sh
npx skills add lvjg/darwin-skills --skill design-reviewer --global --agent codex --yes
```

在 Codex 中打开你的项目，将下面的路径替换为实际设计文档。评审会读取相关材料并给出判断，保持只读：

```text
$design-reviewer 评审 docs/design.md。
结合当前代码判断：方案是否解决了原问题，
关键假设是否成立，是否存在更简单且可靠的路线。
```

评审会给出影响方案成立的主要问题、对应依据、改进建议，以及仍需确认的条件。没有发现实质问题时，也应说明结论所依据的范围。

没有设计文档、但已有代码改动时，可以安装 `code-reviewer`，从下面的[代码审查示例](#使用示例)开始。

## Skills

从你当前要完成的任务选择 Skill，点击名称查看详细用法。

| 你现在需要 | Skill | 主要产出 |
| --- | --- | --- |
| 明确需求、关键假设和取舍 | [`$intent-clarifier`](skills/coordination/intent-clarifier/SKILL.md) | 经澄清的任务理解与必要决定 |
| 创建或完善系统、功能、流程或局部机制的技术方案 | [`$system-designer`](skills/design/system-designer/SKILL.md) | 范围相称、机制具体、有取舍依据的设计 |
| 只读评审未实施的方案 | [`$design-reviewer`](skills/design/design-reviewer/SKILL.md) | 设计评审结论与改进建议 |
| 只读审查具体代码交付 | [`$code-reviewer`](skills/development/code-reviewer/SKILL.md) | 有依据的发现与验收判断 |
| 直接修改代码，在保持行为的前提下简化实现 | [`$code-simplifier`](skills/development/code-simplifier/SKILL.md) | 更易维护的代码与验证说明 |
| 推导或执行端到端验收 | [`$e2e-verifier`](skills/verification/e2e-verifier/SKILL.md) | 验收用例或执行证据 |
| 评价真实任务中的产品体验 | [`$ux-reviewer`](skills/verification/ux-reviewer/SKILL.md) | 可复现的体验发现 |
| 诊断 AGENTS.md 和 Skill 指令，默认不修改 | [`$skill-doctor`](skills/maintenance/skill-doctor/SKILL.md) | 指令问题、保留项与修改建议 |
| 协调跨操作、交接和等待的长任务 | [`$supervisor`](skills/coordination/supervisor/SKILL.md) | 任务推进、进度与结果证据 |

`intent-clarifier` 和 `skill-doctor` 支持按任务描述自动选用，也支持显式调用；其他 Skill 需要显式调用。自动选用取决于运行环境的技能发现和匹配结果。

## 使用示例

安装相应 Skill 后，在 Codex 中描述任务并用 `$名称` 调用。以下示例可独立使用；请将路径、比较分支和业务场景替换为实际对象。

**审查一次代码交付**

```text
$code-reviewer 审查当前分支相对 main 的订单取消实现。
以需求文档约定的取消和退款规则为准，
沿实际调用路径检查必要的状态更新、退款处理及失败恢复是否完整。
```

**简化一段已经实现的代码**

```text
$code-simplifier 简化当前分支新增的配置加载逻辑。
保持现有对外行为，检查新增抽象是否必要，以及能否复用项目已有能力。
```

**先明确如何验收真实流程**

```text
$e2e-verifier 为“用户取消订单并收到退款”推导端到端验收用例。
覆盖正常流程和关键失败情况，说明每个用例需要观察什么结果。先不执行。
```

**协调一项需要持续推进的任务**

```text
$supervisor 按 docs/requirements.md 完成订单取消功能。
范围包括实现、代码评审和本地验证；遇到需要我决定的业务取舍时提出。
完成后说明实际结果、验证依据和未完成事项。
```

## 工作原理

各 Skill 可以独立使用，按任务需要组合。设计负责形成方案，评审负责独立判断，简化负责修改实现，验证负责取得结果证据。用户可以直接调用任意一项，无需走完固定流程。

`supervisor` 适合需要跨多项操作、交接、等待或状态变化保持一致的长任务。它在已有任务范围和授权内，把工作委派给匹配的专业执行者，持续检查目标、进度和证据，并向用户报告结果、需要决定的事项和阻塞。使用它需要运行环境支持委派；恢复机制等细节见 [Supervisor 文档](skills/coordination/supervisor/SKILL.md)。

![Darwin 系统变更控制闭环](assets/system-delivery-loop.png)

*一条系统变更路径示例：围绕目标选择当前需要的设计、评审和验证工作，根据结果证据决定下一步。*

## 安装与更新

查看可安装的 Skills：

```sh
npx skills add lvjg/darwin-skills --list
```

全局安装全部 Skills，或重新运行同一命令更新、补齐：

```sh
npx skills add lvjg/darwin-skills --skill '*' --global --agent codex --yes
```

只安装一项时，将 `'*'` 替换为 Skill 名称；项目级安装去掉 `--global`。目录调整和历史名称迁移见 [迁移指南](MIGRATIONS.md)。

## 维护

Skill 源码统一放在 `skills/<category>/<skill-name>/`，分类不改变安装和调用名称：

| 目录 | 用途 |
| --- | --- |
| `skills/coordination/` | 任务协调与需求澄清 |
| `skills/design/` | 技术方案设计与评审 |
| `skills/development/` | 代码审查与实现简化 |
| `skills/verification/` | 功能验收与体验走查 |
| `skills/maintenance/` | 指令维护 |

`.agents/` 用于本地开发辅助技能，不属于发布目录。修改发布文件后，运行静态包校验：

```sh
ruby scripts/validate-skills.rb --base HEAD
```

九个 Skill 均已有 eval 集。需要验证模型行为时，按 [Skill 评测指南](evals/README.md) 运行；真实任务中的缺陷与用例冲突时，应修正用例，避免为通过评测扭曲 Skill。

[Validation workflow](.github/workflows/validation.yml) 在 PR 和 `main` 上执行静态包校验及 eval 格式检查，不调用模型。这些检查验证发布结构；模型评测只支持对应环境和用例的结论，实际交付仍需取得相应结果证据。

## 全局工程指令模板

[`templates/AGENTS.md`](templates/AGENTS.md) 提供可复用的 Codex 全局工程原则。使用前请审阅，并与已有全局指令合并去重。模板不会由 Agent Skills CLI 安装，也不会在仓库根目录执行任务时作为项目指令自动加载。

## 许可证

本项目采用 [MIT License](LICENSE)。
