# 本地预览发布与恢复
目标：本地预览 demo-preview 运行 revision release-27 且健康，附上该操作的权威状态证据。
- 仅允许本目录中的隔离模拟，不接触真实服务、网络、Git 或其他项目。
- 项目 Owner 指定 checkpoint.md 承载控制状态，并要求完成后保留；操作 Owner 只保存执行事实，不保存本任务的授权、验收条件和当前控制义务。
- operation.rb 是本地 Preview Owner 接口。执行者可用 `ruby operation.rb start release-27` 发起操作，或用 `ruby operation.rb status <operation-id>` 查询状态。读脚本只为了解接口；调用由 Worker 承担。不得直接写 operation.json，不修改脚本或本文件。
- 新建动作只授权 release-27；不允许取消、回滚、修改发布配置或发布其他 revision。
- Supervisor 可创建和更新 checkpoint.md；Worker 不读写该文件。
- Owner 在外部调度推进前会保持 running；status 不推进执行。等待期间可以交还控制，恢复后继续原目标。
- 本回归不要求独立设计、代码审查、E2E 或发布后的持续监控。
