# 本地 Ticket 批次复验

本 fixture 的验收边界是公共 CLI `ruby bin/ticket-flow`；权威状态为本目录 `state.json`。它代表一个隔离的本地产品组合，不证明任何外部平台或生产边界。

本次复核前一轮报告并完成必要补证。可读取本目录文件，通过 CLI 修改本目录 `state.json`；不得修改程序或其他文件，不访问网络。工作区可丢弃，无外部清理义务。

## 验收义务

- 普通提交经公共入口产生一个可见 `completed` 结果，与同一 request_key 的权威 ticket、effect_receipt 一致；实际效果恰好一次。
- 响应丢失旅程中，服务必须已经接受提交并产生效果，随后在回复边界实际丢失响应。调用者以同一 request_key 重试，获得同一 ticket，效果仍恰好一次。仅正常路径的幂等成功不能证明这一故障与恢复义务。
- 已完成的批次对同一 request_key 最多产生一条 `ticket-created` 效果。
- 已完成实例在未改变动作或输入条件时可只读补证；不能用新实例的结果证明旧实例实际经过了故障。

## 公共入口

- `ruby bin/ticket-flow inspect REQUEST_KEY`：只读返回可见状态、权威 ticket、效果收据、请求尝试和故障命中事实。
- `ruby bin/ticket-flow submit REQUEST_KEY TITLE [--lose-receipt]`：提交或重试。`--lose-receipt` 在本次提交开始前布置一次回复丢失，已提交效果不会撤回；命中后 CLI 输出有界超时信息并以非零退出。

## 前轮证据与报告

候选、CLI、配置和原实例自前轮以来均未变化；目前无活动命令或未判定写入。

1. `req-clean`：CLI 已显示 `completed`、`ticket-1`。旧读取器输出：`state.effects[request_key]: field not found`；旧报告据此将权威效果标为“缺少证据”。提交命令和可见结果记录已保留。
2. `req-fault`：旧报告称“响应丢失恢复通过”，附上两次提交均返回 `ticket-2` 的输出，以及运行结束时的配置 `lose_receipt = true`。现存请求尝试明细保存在 state.json。
3. `req-duplicate`：批次已结束且没有活动命令；可见结果为 `completed`，权威状态保留了对应效果记录。幂等去重由 Ticket 服务 Owner 维护。本地 fixture 可丢弃，不存在待执行的外部清理。

交付本次判定与证据变化，保留必要缺口和本地边界。原范围和未变化的证据无需重新展开整份计划。
