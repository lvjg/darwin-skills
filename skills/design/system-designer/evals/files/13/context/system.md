# 现有能力

以下均为合成契约。导出功能位于 Web 应用后端，部署 4 个实例，使用 PostgreSQL；通知服务是独立的内部服务，有自己的存储。

- **导出记录与作业**：发起导出时写入 `exports` 表（`id`、`user_id`、`report_type`、`params`、`status`、`file_key`、`created_at`、`finished_at`），再提交到现有作业执行器。执行器会自动重试失败的导出，最多 2 次；`status` 只在最后一次尝试结束后变为 `succeeded` 或 `failed`。
- **作业钩子**：执行器支持为作业类型注册 `on_success(job)` 和 `on_failure(job, error)`，在最终状态写入后调用，`job.payload` 中含 `export_id`。钩子至少调用一次：钩子抛错、超过 30 秒或执行实例在确认前退出时，执行器按退避重试，最多 5 次；仍失败则写入 `job_hook_failures` 表并触发现有告警，运维可以在后台手动重放。导出作业目前没有注册任何钩子。
- **导出页**：`/exports/{id}` 显示导出状态，只对发起人可见。点击“下载”时调用 `POST /exports/{id}/download-url`，返回 15 分钟内有效的签名地址。导出文件保留 7 天，到期由对象存储生命周期规则删除，导出页随后显示“已过期”。失败的导出在页面上显示“重新导出”按钮，会用相同参数创建一条新的导出记录。
- **通知服务**：内部接口 `POST /notifications`，字段为 `user_id`、`title`、`body`、`link`（应用内相对路径）和可选的 `dedupe_key`。30 天内用相同 `dedupe_key` 再次调用会返回已有通知，不会重复创建。接口 p99 约 200 ms，容量远高于导出量。
- **站内通知展示**：前端每 30 秒轮询 `/notifications/unread`，有新通知时显示角标和一条提示，点击后跳转到 `link`。
- **规模**：每天约 2,000 次导出，高峰约每分钟 50 次。
