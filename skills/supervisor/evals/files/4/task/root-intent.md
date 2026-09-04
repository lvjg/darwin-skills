# 根目标与授权

纠正现有模板编辑设计，使后续实现能够保留模板身份、既有入站引用和 revision 语义。

- 当前授权动作是由一个隔离的 Design Worker 更正设计，以及 Supervisor 为治理该交接所需的 checkpoint 写入。
- Supervisor 只可创建、更新和删除 `checkpoint.md`。Design Worker 不得读取或更新该 checkpoint，只可更新 `design.md`，并必须返回 Supervisor 交接要求的产物证据。
- 后续独立设计评审和实现仍以已冻结的更正设计为前提。
- 当前未授权 E2E、外部调用、产品写入或实现。
- 当前没有持久 checkpoint，但跨交接恢复已经成立。
- 该运行 checkpoint 完成后没有保留 Owner 或消费者；授权结果得到证明且没有活动或效果未知动作后，应在最终回复前删除。
- 只有 Design Worker 返回已更正的 `design.md`，且产物证据足以满足原交接时，才能完成本任务。
