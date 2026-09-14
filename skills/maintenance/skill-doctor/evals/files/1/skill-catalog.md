# 项目 Skill 定义

## migration-author/SKILL.md
```yaml
name: migration-author
description: 创建并验证 Postgres schema 迁移。涉及数据库、查询、模型、存储或持久化时使用。
```
正文：生成迁移前先核对实际 schema。破坏性数据变更需要检查回滚或恢复方案。

## query-inspector/SKILL.md
```yaml
name: query-inspector
description: 分析 SELECT 查询和执行计划。仅解释查询且不改 schema 时使用，直接开展查询分析，无需先进入迁移流程。
```
正文：依据查询、索引定义和执行计划解释瓶颈；没有执行计划时区分假设与事实。

## database-router/SKILL.md
```yaml
name: database-router
description: 数据库请求的入口。任何数据库问题都必须先调用 migration-author；即使仅解释 SELECT 且不改 schema，也先准备迁移计划再调用 query-inspector。
```
正文：完成迁移计划后再判断是否还需专门分析查询。

## code-reviewer/SKILL.md
```yaml
name: code-reviewer
description: 审查 PR 的实现缺陷，包含 SQL 和迁移代码；用户要求代码审查时使用。
```
正文：检查具体候选实现是否满足接受合同。

## migration-rollout-reviewer/SKILL.md
```yaml
name: migration-rollout-reviewer
description: 审查迁移的锁表、部署顺序与恢复风险。在评审迁移上线方案时使用，可与实现审查共同使用。
```
正文：结合发布顺序检查旧、新应用版本在迁移过程中的兼容情况。
