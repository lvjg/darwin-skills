# 当前能力

所有资料均为合成契约。允许在现有维护路径中增加订单接口、表字段、索引或后台处理；若增设独立设施，需要说明实际收益。只有三个应用工程师维护本功能。

- Gateway 已鉴别 account_id 和入口身份，客服代操作携带客服身份及客户 account_id。合作方令牌限定 partner_id 和可操作客户，不可自行声称别的 partner_id。
- Order Service 使用 PostgreSQL，可在自身库内事务写订单、购买引用、支付尝试和持久化工作记录；没有跨服务事务。现有 GET /orders/{id} 返回本库事实，有权限检查。当前创建接口没有跨入口统一的购买引用规则，需要本次设计。
- Payment 提供 POST /charges（merchant_attempt_id、amount、currency、payment_token）；同 merchant_attempt_id 且相同参数在首次请求后 24 小时内返回同一 charge，参数不同返回 409。GET /charges/by-attempt/{id} 可查 30 天，返回 accepted/pending/succeeded/failed；已落库结果立即可查，404 只代表查询当时未落库。POST 可在客户端超时后继续处理，最长 90 秒后确定是否落库；确认失败的 charge 以后不会变成功。重复回调及回调丢失均可能，签名回调含 charge_id 和 merchant_attempt_id。Payment 承诺单个 charge 至多成功扣一次，不能由调用方事务回滚。24 小时后再次 POST 同 ID 可能创建新 charge。
- Warehouse 提供 POST /dispatch（order_id、lines、address）。同一 order_id 在租户内唯一；相同内容返回原 dispatch，不同内容返回 409。GET /dispatch/by-order/{order_id} 可查询 ready/blocked/shipped；ready 表示仓库已接受，shipped 才表示已出库。一次故障可能持续 6 小时，请求可能已接受但响应丢失。不要把 ready 展示为已经发货。
- 现有持久化工作队列是至少一次投递，支持延后重试，无消息跨库原子性；可选择复用它，也可使用订单库已有后台扫描器，扫描器每 5 秒运行且同一轮可重入。
- 订单列表由 Order Service 查询，不允许从付款网页跳转成功与否推算业务结果。保留订单与支付尝试 90 天。生产监控尚未为新流程建立，本题只能提出验证计划。
