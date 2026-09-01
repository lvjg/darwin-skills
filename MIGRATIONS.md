# Darwin 迁移指南

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
| `system-overview-design` | `overview-designer` | 创建、补全或重写系统级设计产物。 |
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
