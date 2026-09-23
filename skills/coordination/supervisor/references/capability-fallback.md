# 能力目录 fallback

只在执行环境提供的能力目录不足以判断与本 Skill 一同安装的专业能力、且当前义务可能与其中一种能力匹配时读取本文件。它是能力发现的补充，不是 Supervisor 的固定流程或完整 Skill 注册表。

以 `supervisor` 安装目录的父目录为基准，以下同级 Skill 是与本 Skill 一同安装时可补读的专业候选：

- `system-designer`
- `design-reviewer`
- `code-reviewer`
- `code-simplifier`
- `e2e-verifier`
- `ux-reviewer`

建立目录快照时，只读取环境目录缺失候选的 `SKILL.md` YAML frontmatter。候选匹配当前义务后，按主 Skill 的路由规则补齐执行边界和交付要求；不因选中就要求控制者完整加载专业步骤。文件不存在、不可读或补读后仍不能确认适用条件时，该候选不可用；不要扫描其它同级目录来猜测能力。Worker 的完整读取义务不变。
