# Darwin 迁移指南

## 从 `designer` 或 `overview-designer` 迁移到 `system-designer`

| 旧名称 | 当前名称 | 选择说明 |
| --- | --- | --- |
| `designer`、`overview-designer` | `system-designer` | 创建、补全或修订技术方案，兼顾全局理解与关键机制的内容深度，覆盖系统、功能、流程和局部算法策略。 |

本次从 `designer` 更名不改变设计职责、思考流程和三个核心用例。

调用入口改为 `$system-designer`，源码位于 [System Designer](skills/design/system-designer/SKILL.md)，调用条件仍为显式调用。原 `references/overview-standard.md` 由 [设计产物规范](skills/design/system-designer/references/design-standard.md) 替代，负责方案表达及最终文档检查；新增的 [设计取舍参考](skills/design/system-designer/references/design-decisions.md) 按需辅助比较收益、代价和不确定性，设计流程仍由 `SKILL.md` 维护。直接引用旧名称、路径或参考文件的交接指令需同步更新；仓库更新不会自动迁移已安装副本。

发布包含此次变更的版本后，先安装并核对新入口；若已安装 `supervisor`，同时更新其设计能力路由。再移除旧名称，并保留本机自定义修改的备份：

```sh
npx skills add lvjg/darwin-skills --skill system-designer --global --agent codex --yes
npx skills add lvjg/darwin-skills --skill supervisor --global --agent codex --yes
npx skills remove designer overview-designer --global --yes
```

## 从平铺目录迁移到分类目录

Skill 源码从 `skills/<skill-name>/` 移至 `skills/<category>/<skill-name>/`，分类见 [README](README.md#skills)。Skill 名称与调用方式不变，按名称运行的安装和 eval 命令继续适用；直接引用源码路径的脚本或链接需改用分类后的路径。

新增的 `skill-doctor` 位于 `skills/maintenance/skill-doctor/`。可单独安装，也可使用 README 中的全量安装命令补齐：

```sh
npx skills add lvjg/darwin-skills --skill skill-doctor --global --agent codex --yes
```

全局工程指令模板由 `codex/AGENTS.md` 移至 [templates/AGENTS.md](templates/AGENTS.md)。引用旧模板路径时需更新；已复制到全局配置的文件不会因此自动变化。仓库根目录不放置该模板，避免与已加载的全局指令重复。

## 从 v0.1.0 迁移到当前版本

当前版本重命名了全部 Skill，并把原来混合的交付验收和端到端责任分别拆开。`skills update` 只能更新已经安装的名称，不能完成这次迁移。

先安装当前仓库中的全部新 Skill：

```sh
npx skills add lvjg/darwin-skills --skill '*' --global --agent codex --yes
```

再根据原来的使用意图核对映射：

| v0.1.0 名称 | 当前名称 | 选择说明 |
| --- | --- | --- |
| `plan-to-delivery` | `supervisor` | 仅在任务需要跨多个关键操作、交接、等待或权威状态变化保持可恢复控制时使用。 |
| `system-overview-design` | `system-designer` | 创建、补全或修订系统、功能、流程及局部机制的技术方案。 |
| `plan-review` | `design-reviewer` | 对尚未实施的技术或行为路线做只读设计判断。 |
| `delivery-review` | `code-reviewer` | 验收精确代码交付。尚未实施的 Agent/Harness 设计使用 `design-reviewer`；精确运行行为需按实际接受边界取得相称的运行或评估证据，不由设计评审替代。 |
| `code-cleanup` | `code-simplifier` | 在行为目标和代码候选边界明确后，删除非必要实现并重组必要代码，同时保持既定行为。 |
| `workflow-e2e` | `e2e-verifier` / `ux-reviewer` | 前者推导功能旅程验收或在获准执行时验证结果；后者沿真实用户任务评价产品体验。需要哪一种取决于实际接受目标，并非默认两者都执行。 |

确认新 Skill 已安装并备份过任何直接修改的本机安装副本后，删除旧的全局名称：

```sh
npx skills remove plan-to-delivery system-overview-design plan-review delivery-review code-cleanup workflow-e2e --global --yes
```

最后检查全局清单；目标是只保留需要的当前名称，不让旧、新两套指令同时参与后续选择：

```sh
npx skills list --global
```

如果旧 Skill 曾安装给 Codex 以外的 Agent，需对相同 Agent 范围重复安装和移除；不要使用 `remove --all`，它会扩大到本次迁移之外的 Skill。

## 从包含 `behavior-reviewer` 的中间版本迁移

| 中间版本名称 | 当前归属 | 选择说明 |
| --- | --- | --- |
| `behavior-reviewer` | `design-reviewer`（仅设计评审）/ 运行或评估证据 | 尚未实施的 Agent/Harness 设计由 `design-reviewer` 评审；精确运行行为没有直接替代 Reviewer，需按实际接受边界取得相称证据。 |

若曾单独安装 `behavior-reviewer`，完成当前 Skill 安装并确认不再需要本机自定义副本后删除旧名称：

```sh
npx skills remove behavior-reviewer --global --yes
```
