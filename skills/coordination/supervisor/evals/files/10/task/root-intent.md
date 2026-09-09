# 运行实例本地状态观察恢复边界

目标是在下一回合继续观察 provider operation `op-local-174`，直到 Owner 返回可判定的终态，并据此决定当前只读状态观察是否完成。

- 当前控制信息必须跨越本回合，但不需要跨执行环境，也不需要超过操作系统临时目录的生命周期。
- Provider 只拥有 operation 状态；它不保存本任务的验收边界、授权、已排除的重复动作或下一项受控查询，因此不能仅从 Owner 状态安全恢复完整控制决定。
- 当前没有用户、任务或执行环境指定的 checkpoint，也没有当前任务已经建立且仍有效的 checkpoint。
- 本评测 workspace 只是一次性输入容器，不是代码仓库，不拥有交付物或主要副作用；当前任务不存在适用的交付 Owner 项目根。
- 运行环境提供可写的操作系统临时目录。稳定任务标识为 `runtime-local-status-observation`。
- 下一项动作只允许未来的 explore Worker 查询 provider Owner 对 `op-local-174` 的只读状态，返回 Owner 状态、版本、已知效果和未知项；不得发起或重试 operation。
- 本原子 case 停在写文件和派发前：不得创建 checkpoint、调用 Worker、查询 provider、修改文件或访问外部系统。
