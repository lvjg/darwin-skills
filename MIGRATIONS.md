# Darwin migrations

## 从 v0.1.0 升级到下一版本

下一版本重命名了全部 Skill，并把原来混合的交付验收和端到端责任分别拆开。`skills update` 只能更新已经安装的名称，不能完成这次迁移。

先安装当前仓库中的全部新 Skill：

```sh
npx skills add lvjg/darwin-skills --skill '*' --global --agent codex --yes
```

再根据原来的使用意图核对映射：

| v0.1.0 名称 | 当前名称 | 选择说明 |
| --- | --- | --- |
| `plan-to-delivery` | `supervisor` | 仅在任务需要跨多个物质动作、交接、等待或权威状态变化保持可恢复控制时使用。 |
| `system-overview-design` | `overview-designer` | 创建、补全或重写系统级设计产物。 |
| `plan-review` | `design-reviewer` | 对尚未实施的技术或行为路线做只读设计判断。 |
| `delivery-review` | `code-reviewer` / `behavior-reviewer` | 前者验收确定性代码候选；后者验收由指令、模型、工作流、工具路径或呈现渠道共同决定的行为候选。需要哪一种取决于实际接受边界，并非默认两者都执行。 |
| `code-cleanup` | `code-simplifier` | 在目标结果和保留行为已经决定后收敛实现。 |
| `workflow-e2e` | `e2e-verifier` / `ux-reviewer` | 前者证明具体功能旅程；后者沿真实用户任务检查产品体验。需要哪一种取决于实际接受目标，并非默认两者都执行。 |

确认新 Skill 已安装并备份过任何直接修改的本机安装副本后，删除旧的全局名称：

```sh
npx skills remove plan-to-delivery system-overview-design plan-review delivery-review code-cleanup workflow-e2e --global --yes
```

最后检查全局清单；目标是只保留需要的当前名称，不让旧、新两套指令同时参与后续选择：

```sh
npx skills list --global
```

如果旧 Skill 曾安装给 Codex 以外的 Agent，需对相同 Agent 范围重复安装和移除；不要使用 `remove --all`，它会扩大到本次迁移之外的 Skill。

## 从未发布的 `proof-*` 候选迁移

如果本机曾安装本仓库尚未发布的角色化候选，先安装当前全集，再按以下映射确认新名称：

| 旧候选名称 | 当前名称 |
| --- | --- |
| `proof` | `supervisor` |
| `proof-overview-design` | `overview-designer` |
| `proof-design-review` | `design-reviewer` |
| `proof-code-review` | `code-reviewer` |
| `proof-behavior-review` | `behavior-reviewer` |
| `proof-cleanup` | `code-simplifier` |
| `proof-e2e` | `e2e-verifier` |
| `proof-walkthrough` | `ux-reviewer` |

确认新名称可见后，移除旧候选，避免同一责任出现两套调用名：

```sh
npx skills remove proof proof-overview-design proof-design-review proof-code-review proof-behavior-review proof-cleanup proof-e2e proof-walkthrough --global --yes
```
