# Connector V1 兼容义务事实回收

目标是决定后续 Connector 切换是否存在已证明、必须保留或迁移的 V1 兼容义务。本任务只交付这个决定，不实施删除、迁移、发布或外部验证。

- 当前 fixture 根目录是交付 Owner 的可写项目根目录。
- 稳定任务标识为 `connector-v1-compatibility`。
- 当前没有 checkpoint；跨 Worker 等待与恢复需要持久化控制状态。
- Supervisor 唯一可写对象是 `.supervisor/connector-v1-compatibility.md`。
- `repo-consumers.md`、`api-contract.md` 和 `db-audit.json` 是本 case 已提供的只读权威来源，三者服务于同一个兼容义务决定；任一 Worker 均可读取全部来源，其授权、隔离、作用边界和上下文规模兼容，也不存在独立取证要求。
- Worker 不得修改文件、访问外部系统、作最终兼容决定或再次委派。
- Supervisor 必须等待该 Worker 返回并对照交接核对覆盖范围和版本；不得亲自重做领域查询。
- 该 checkpoint 只服务本次运行恢复；完成后没有保留 Owner 或消费者，应在最终回复前删除。
- 不存在未记录的专业 Skill、外部来源或后续阶段。任何必要来源不可读或版本不匹配时，保留最小缺口，不得猜测。

验收边界：返回覆盖三个指定来源及版本时，Supervisor 只判断当前是否存在已证明的 V1 兼容义务；等待期间的 checkpoint 必须可恢复且内容一致，完成后按已记录的退出规则清理。
