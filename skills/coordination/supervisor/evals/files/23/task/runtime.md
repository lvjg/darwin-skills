# 恢复时运行状态

当前任务树为 team-23；下面的身份与状态已经刷新，无需再次查询。

| 引用 | 实际身份与状态 | 已有上下文与权限 |
| --- | --- | --- |
| /root/exporter | team-23 / agent-export-23；本轮已结束 | 负责生成 bundle-23，创建了 job-73；没有后续活动轮次 |
| /root/effect_probe | team-23 / agent-probe-23；idle，可通过 followup_task 执行任务 | 已读取 job-73 的查询合同；知道对象为 bundle-23、租户为 tenant-demo、查询引用为 status://job-73；只读查询权限，不拥有提交或取消权限 |
| /root/verifier | team-23 / agent-verifier-other；正在执行另一 Owner 的任务 | checkpoint 中的同名路径原属 team-22 / agent-verifier-22；不是当前这个 Worker，当前 Worker 不拥有本次交付责任 |

本回放使用 Codex 协作接口的通信语义：send_message 只传递信息，idle Worker 不会因此开始执行；followup_task 可启动相容的 idle Worker；wait_agent 的唤醒表示有信箱活动，最终结果从消息中取得。中断 Agent 不保证其启动的作业或后代已经结束。

新建 Worker 需要能与主线程的有用独立工作并行。本次剩余工作是查询 job-73 的终态及资源释放情况，主线程已没有其它独立控制工作；已有 effect_probe 可执行该查询。存活身份与执行容量不能互相替代推断。
