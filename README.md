# Codex 系统变更设计与交付

一组面向 Codex 的系统级工程 Skills，覆盖设计形成、方案评审、交付控制、实现验收和代码收敛。每个 Skill 都有独立职责，可以单独调用；当系统变更需要持续对齐意图、权威设计、实现候选、专业判断和最终证据时，可由 `plan-to-delivery` 控制完整闭环。

## Skills

| Skill | 定位 | 适用场景 |
| --- | --- | --- |
| [`plan-to-delivery`](skills/plan-to-delivery/SKILL.md) | 系统级交付控制器 | 用户明确调用，且工作需要在设计、实施、独立验收和清理之间持续保持对象与证据一致时，建立闭环并把专业工作路由给对应 Worker。 |
| [`system-overview-design`](skills/system-overview-design/SKILL.md) | 系统设计 | 创建、补全或重写架构概览、目标技术方案、高层设计或系统 RFC，以当前事实为基础形成最小完整设计。 |
| [`plan-review`](skills/plan-review/SKILL.md) | 实施前方案评审 | 对技术方案、RFC、迁移或重构路线进行独立只读评审，判断它是否基于真实系统、路线有效且足够简单、责任与语义闭合。 |
| [`delivery-review`](skills/delivery-review/SKILL.md) | 实施后交付验收 | 对补丁、分支、提交、PR、迁移或配置变更的精确候选进行独立只读验收，判断交付是否完整、正确、范围合理、迁移安全且证据充分。 |
| [`code-cleanup`](skills/code-cleanup/SKILL.md) | 实现收敛 | 在目标已经确认且获得修改授权后，删除不受支持或重复的行为、状态、实现与兼容路径，保持既定行为、合同、失败语义和数据。 |

这些 Skills 不是必须顺序执行的固定阶段：单项设计、评审、验收或清理应直接调用对应 Skill；只有满足自身准入条件的系统级变更才使用 `plan-to-delivery`。

## 安装

使用 [Agent Skills CLI](https://github.com/vercel-labs/skills)。需要 Node.js 18 或更高版本。

查看仓库中可安装的 Skills：

```sh
npx skills add lvjg/skills --list
```

将全部 Skills 全局安装给 Codex：

```sh
npx skills add lvjg/skills --skill '*' --global --agent codex --yes
```

只全局安装一个 Skill：

```sh
npx skills add lvjg/skills --skill plan-review --global --agent codex --yes
```

如需项目级安装，去掉 `--global`。

## 更新

更新已全局安装的 Skills：

```sh
npx skills update --global --yes
```

## 全局工程约束

[`codex/AGENTS.md`](codex/AGENTS.md) 是独立的 Codex 全局工程原则模板，不是 Skill，也不会由 Agent Skills CLI 安装。使用前应先审阅其内容，再决定是否作为全局 `AGENTS.md`。
