# 固定候选的独立审查
目标只验收用户指定的不可变提交 41ab09c 的审查结果。checkpoint.md 记录先前控制状态；worker-return.md 为已经完成的独立审查返回。
- 该提交内容可由不可变对象标识解析；candidate-state.json 是当前引用元数据。
- 只允许读取这些控制输入并更新既有 checkpoint.md，不读取候选代码、不重做审查、不派发 Worker、不修改其他文件或访问外部系统。
- checkpoint 是用户指定的既有载体，完成后保留为不可恢复终态。
