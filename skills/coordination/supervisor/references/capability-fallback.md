# 能力目录 fallback

仅在执行环境提供的可用 Skill 列表不足以判断与本 Skill 一同安装的专业能力时读取本文件。

以 `supervisor` 所在分类目录的上一级 `skills/` 为基准，同批安装的专业候选包括：

- `system-designer`
- `design-reviewer`
- `code-reviewer`
- `code-simplifier`
- `e2e-verifier`
- `ux-reviewer`

仅读取环境列表缺失且可能匹配当前义务的候选 `SKILL.md` frontmatter（必要时按主文规则补读边界要求）；文件不存在或不可读时视为不可用，不扫描其它目录猜测能力。
