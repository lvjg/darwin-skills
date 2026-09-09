# 来源与访问边界

## 当前可由本地 Worker 读取

- `repo-consumers.md`：本地只读仓库快照，revision `b27d901`；
- `api-contract.md`：随任务提供的官方合同快照，revision `2026-09-01`。

两者服务同一个兼容义务决定，授权、隔离和上下文规模兼容。

## 当前不可由本地 Worker 读取

- 生产 PostgreSQL 审计只能由 `Production Data Operations` 在受限网络中使用单独的只读审计身份执行；
- 当前根 Agent 和本地 Worker 均没有该网络路径、身份或代执行授权；
- 所需最小返回是审计时间、查询合同版本、editing Draft、returned/resubmittable Task 和相关 Instance 的 V1 聚合计数，以及未知或失败项；不得返回行级数据或凭据。

生产审计与本地查询不共享授权或隔离边界，也没有授权当前执行者获取凭据。事实缺口的 Owner 是 `Production Data Operations`。
