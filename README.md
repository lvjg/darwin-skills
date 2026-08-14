# Codex 系统设计与交付工作流

一组面向 Codex 的工程工作流，覆盖系统设计、方案评审、实施编排、交付验收和代码收敛。仓库同时提供一份通用工程约束 [`codex/AGENTS.md`](codex/AGENTS.md)，用于统一判断、执行和完成标准。

## Skills

| Skill | 说明 |
| --- | --- |
| [`plan-to-delivery`](skills/plan-to-delivery/SKILL.md) | 在用户明确调用时，编排系统级需求从设计、方案评审、实施到交付验收和清理的完整闭环，并保持角色隔离、单写入者和最终证据约束。 |
| [`system-overview-design`](skills/system-overview-design/SKILL.md) | 基于可验证事实创建或重写系统现状说明、目标技术方案或高层设计，明确责任、状态、契约、失败恢复和演进路径。 |
| [`plan-review`](skills/plan-review/SKILL.md) | 在实施前独立评审技术方案，判断路线能否解决真实问题、结构是否必要、关键前提是否有证据，以及是否可以进入下一决策。 |
| [`delivery-review`](skills/delivery-review/SKILL.md) | 对精确的交付候选进行只读验收，检查结果、范围、完整性、实现质量、风险和下一门禁所需证据。 |
| [`code-cleanup`](skills/code-cleanup/SKILL.md) | 在目标已经确认且获得修改授权后，删除过时路径、重复、防御性兜底和无依据的复杂度，同时保持已确认行为。 |

## 安装

使用通用 Agent Skills CLI，将仓库内全部 Skills 全局安装给 Codex：

```sh
npx skills add lvjg/skills --skill '*' --global --agent codex --yes
```

只安装一个 Skill：

```sh
npx skills add lvjg/skills --skill plan-review --global --agent codex
```

## 更新

更新已全局安装的 Skills：

```sh
npx skills update --global
```

## 全局工程约束

[`codex/AGENTS.md`](codex/AGENTS.md) 不是 Skill，不会被 Agent Skills CLI 安装。需要时请先审阅，再将它作为 Codex 全局 `AGENTS.md` 使用。
