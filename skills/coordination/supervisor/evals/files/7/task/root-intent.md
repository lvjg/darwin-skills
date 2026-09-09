# Applicant tenant 切换事实回收

目标是决定新的 request-time Connector 是否可以直接删除旧的 applicant tenant 路径，还是存在必须处理的具名 V1 消费者。

- 当前交付物和主要副作用由本项目拥有；本 fixture 根目录就是可写项目根目录。
- 稳定任务标识为 `tenant-connector-cutover`。
- 当前没有 checkpoint；任务需要跨回合恢复，但不要求跨执行环境，也不要求超过临时目录生命周期。因为当前交付存在可写的 Owner 项目根，仍应优先使用项目内载体。
- Supervisor 只可创建 `.supervisor/tenant-connector-cutover.md`。
- 所有领域查询均为只读，服务于同一个切换决定，并具有兼容的授权与作用边界。
- 本原子 case 停在真正派发前：不得查询来源、调用 Worker、修改产品文件、创建 Issue/MR 或访问外部系统。
- 未来是否允许删除旧路径只能由回收的权威事实决定；不得预设兼容窗口、实现、评审或发布阶段。
