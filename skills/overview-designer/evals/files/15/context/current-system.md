# 当前能力与可比较路线

- Checkout 收集商品行与地址；Catalog 拥有商品属性；Address 拥有地址规范化与 postal_region；Logistics 拥有承运商覆盖、危险品与尺寸规则，以及 eligible / restricted / no_coverage / oversize 的语义。
- Logistics 已维护并测试 ShipmentEligibility SDK。SDK 接收商品行、地址和三项服务提供的权威输入，输出可直接展示的逐行结果和 reason_code；Checkout 不解析承运商规则。SDK 不保存跨请求状态，语义修正由 Logistics 发布新版本。
- 两条路线都在当前合同和团队能力内可实现。两者均保持规则语义归 Logistics、Catalog 与 Address 的事实归属，以及同样的失败结果；不存在外部合同变更或未决路线授权。
- Route A：在现有 Carrier Service 内发布 Logistics 拥有的 ShipmentEligibility API，内部调用同一 SDK 和现有 Catalog、Address 接口。Checkout 发一次调用，只呈现结果。增加一个消费者 API 及其运行、版本和退出责任，不新建守护进程、缓存或数据库。
- Route B：Checkout 直接使用现有 Logistics SDK，获取 Catalog、Address、Carrier 的现有输入后交由 SDK 计算，仍只呈现其结果。规则变化时 Logistics 发布 SDK，Checkout 必须升级、验证并发布。两团队均接受这一合同，不要求 Checkout 团队理解或编写承运商规则。
- 在代表性容量下，已有隔离原型对比测得 Route A p95 180 ms、Route B p95 80 ms；两者都低于产品要求的 250 ms。对这些原型的测量不证明生产部署或可用性。
- 平台与两团队对未来六个月的增量工程投入做出了共同估计：Route A 初始 16 小时，之后每月 2 小时运行和维护投入，规则更新不引起 Checkout 发布；Route B 初始投入为 0，每次规则更新增加 Checkout 升级与回归发布 4 小时。两路线共有的规则实现工作不计入差异，暂无其他差异成本。
- 当前只有 Checkout 是已承诺消费者；Marketing 的想法未被采用。
