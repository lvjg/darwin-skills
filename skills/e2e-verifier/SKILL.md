---
name: e2e-verifier
description: Use only when the user explicitly invokes $e2e-verifier to derive an end-to-end acceptance case set for a concrete product or system journey or, when execution is requested and authorized, verify its functional outcome through the real entry point, consumer-visible result, authoritative terminal state, and required effects. Do not use for product experience walkthroughs, unit or integration tests alone, general UX critique, aggregate optimization of an existing case corpus, or external writes not covered by authorization.
---

# E2E Verifier

## 证明旅程结果

`e2e-verifier` 从用户、调用者或下游系统必须依赖的结果出发，推导能够证伪该结果的最小用例集，并在授权和能力允许时通过真实入口、可见结果、权威事实和实际副作用判断旅程。不要把当前实现、测试脚手架、页面文本、HTTP 成功、任务 ID、日志出现或个人体验偏好当作业务真相。

本 Skill 只负责功能与系统结果。它不系统评价内容、布局、信息层级、交互清晰度或视觉体验；人机界面问题只有在实际阻止旅程、歪曲结果或使决定性证据不可取得时，才作为对应 E2E 结论的事实。纯 API、event、CLI、queue、batch 或 worker 旅程同样适用，不为统一流程虚构 UI。

## 恢复验收契约和 Owner

从用户要求、正式合同、平台约束、历史缺陷、现有入口和必要系统事实恢复本轮验收依据，并区分已确认事实、权限方决定、待验证假设、判断所需未知和范围外可能性。

在推导 case 或开始执行前固定本轮验收对象，并把每条 witness 绑定到它：适用时包括候选 revision/build、实际部署或发布标识、决定行为的配置和 Provider 版本，以及比较或接受基线。无法取得某个标识时，记录可替代的权威部署证据、Owner 和结论边界；不能只用环境名称近似绑定候选。

明确用户或调用者结果、actor、身份与 tenant、前置状态、真实入口、关键动作、系统边界、终态、失败与恢复、允许和禁止的副作用、清理责任，以及本轮可使用的环境、数据、账号、权限和外部配置。当前请求或既有决定只要仍覆盖实际动作、对象、效果、范围和风险，就继续构成授权；不要因为开始执行、切换工具或临近副作用而重复确认。缺少必要事实时先从可用权威来源做有界调查；仍无法取得时向实际事实 Owner 请求。缺少其他 Owner 的决定时路由或报告 blocker，不能让当前用户代替其他权限方作决策。

每个生产合同只有一个语义 Owner。Verifier 消费 Owner 直接提供或决定的 schema、状态、权限、effect、序列化、fixture、catalog、客户端或 conformance 制品，不在 mock、fixture 或临时编排中重写业务规则。部署边界独立时，用版本化制品或针对真实双方的 conformance 证据证明一致，不建立第二合同源。

关键结果使用双重 Oracle：

- 用户、调用者或真实下游能够观察和依赖的结果；
- 拥有事实的权威终态、必要 receipt、实际工具调用和下游 effect。

任一证据线不能替代另一条；不适用某一线时说明实际接受边界。

## 推导风险完备的最小用例集

先回答“为什么必须测”，再形成 case。只有以下事实之一成立时才形成物质覆盖义务：失败会使用户或调用者结果不成立；违反必须保持的合同；破坏身份、tenant、权限或安全边界；产生错误、遗漏或重复副作用；破坏终态、失败、恢复或清理；重现已确认的高影响风险或历史缺陷。

仅因组合可能有用、实现存在分支、语法相似或可以穷举，不形成阻断义务。未被用户结果、正式合同、平台约束、历史缺陷或已确认风险建立的事项，只能是非阻断 `Unknown` 或范围外观察，不生成 case，也不使已建立旅程 `Blocked`。

每个 case 至少绑定：

| 内容 | 必须回答的问题 |
| --- | --- |
| 义务与来源 | 哪项结果、合同、约束、风险或历史缺陷要求它？ |
| 反例与影响 | 它要区分什么现实失败，失败怎样改变结果？ |
| 场景边界 | actor、身份/tenant、状态、数据、环境和允许副作用是什么？ |
| 真实动作 | 从哪个公共或生产等价入口行动，在哪些中间、失败、恢复或重入点判断？ |
| 双重 Oracle | 可见结果与权威状态、receipt、effect 或实际工具调用分别是什么？ |
| 禁止结果 | 哪些错误写入、重复、泄漏、错误身份效果、残留、孤儿或 Dead Letter 不得发生？ |
| 覆盖处置 | 本 case 覆盖、Owner 聚焦测试覆盖、明确排除，还是因已建立前置缺失而阻塞？ |
| witness 与清理 | 用什么业务键或 correlation 绑定证据，由谁 setup 和 teardown？ |

沿主旅程和关键业务分支建立义务，再用最可能推翻结果的反例挑战：无效输入或取消、身份权限与 tenant、会话或刷新、超时重启与恢复、重试重复并发乱序、外部 callback/effect，以及历史缺陷。只有两个边界共同决定同一用户结果时才增加组合 case。

删除或合并不能增加判别力的 case。字段 schema、完整状态矩阵、边界值和算法穷举由生产 Owner 的聚焦测试承担；E2E 只保留会改变跨边界结果的代表性组合，并引用正式 schema 或 conformance 证据。缺少 Owner 证据时记录缺口，不在 E2E 手抄穷举来伪造闭合。

## 按证明责任选择能力

为本轮实际接受边界建立临时 capability profile，不创建持久 registry。逐项确认动作能力、可见观测、权威事实源、跨边界 correlation、身份和 tenant、平台约束、副作用及清理能力，再从当前可用客户端、Connector、API、CLI 或运行工具中组合满足者。

工具名不是验收合同，一个工具也不必包办全部证据。需要真实渲染或宿主行为时使用能够观察该事实的客户端；程序化或后台旅程使用实际公共 API、event、CLI、queue、batch 或 worker 入口。缺少决定性能力时报告对应路径 `Blocked`，不能换成证明力更弱的手段后宣称通过。

真实环境不等于生产环境，真实传输也不等于真实数据或最终 Provider。结论只覆盖实际经过的入口、客户端、身份、tenant、数据、配置、Provider、分支、receipt 和副作用层级。

## 预检并执行决定性旅程

高成本或有副作用的执行前，先用只读检查确认环境、身份、tenant、目标入口、OAuth/scope、callback 可达性、授权覆盖、清理权限、fixture 新鲜度、协议和探针。工具或操作者已登录不证明被测应用、callback 或目标身份配置正确。

用正式解析器、序列化器、schema 或 conformance case 离线校验配置、端点、fixture 和 double 的请求响应。Mock 或 Provider double 只模拟明确被替代的外部传输和故障，不实现产品规则。必经真实边界缺少配置或权限时，合成路径只能形成诊断证据；说明缺失前置、Owner、最小解除动作和真实重跑入口。

先用较低成本的聚焦检查定位，再从真实任务入口执行决定性 case：

`真实入口动作 -> 等待可判定状态 -> 读取可见结果 -> 用 correlation 绑定权威状态、日志、receipt 与 effect`

不要为了方便调用内部写接口、伪造外部成功事件或直接修改终态。结果不明的写操作先查询权威状态，不盲目重试。同一写入仍在活动或终态未知时不得启动冲突或重复动作。

## 按证据判定和局部调整

每个关键 checkpoint 运行同一个短循环：

`执行最小判别动作 -> 绑定证据来源与对象 -> 对照 Oracle 判定 -> 只调整受影响的 cases、能力、归因或重跑范围 -> 继续或停止`

只有新权限方决定、正式合同、平台约束、历史缺陷或已确认风险可以新增或修改覆盖义务；当前实现和一次工具失败不能。候选、build、对象、配置、部署、Provider、会话、数据或外部状态变化只使依赖它的证据失效；变化发生在执行中时，停止把新旧 witness 聚合为同一结论，重新绑定验收对象后只重跑原 witness 和受影响入口。

按拥有偏差的层归因：

- 产品偏离正式合同或用户结果，是产品缺陷；
- 产品符合权威合同，而正式 Verifier 发送、观察或断言旧规则，是 Verifier 缺陷；
- 产品和正式 Verifier 均正确，而 fixture、double、compose、probe、driver 或环境失真，是脚手架或环境缺陷。

Verifier 不修改产品候选。已成立产品缺陷交给拥有相关规则、状态、内容、交互或副作用的产品 Owner，并保留原 witness 和精确重跑入口。获得明确授权时可以修复 Verifier 自己拥有的断言、driver 或脚手架，但不得改变业务 Oracle 来制造绿色；修复使受影响证据失效，必须从原真实入口重新执行。

## 判定完成

每条范围内旅程分别报告三个门禁：

| 门禁 | `Pass` | `Fail` | `Blocked` | `Not Requested` |
| --- | --- | --- | --- | --- |
| 用例质量 | 物质义务、反例、Oracle、场景边界和覆盖处置形成有界最小集合 | 遗漏物质义务、从实现反推 Oracle、猜测 unknown 或保留无判别力重复 case | 决定其正确性的权威输入不可取得 | 不适用；范围内旅程必须判定用例质量 |
| 执行闭合 | 真实入口证明可见结果、权威终态、正确身份/tenant、必要 effect/receipt，且未出现该 case 明确禁止或对该旅程物质相关的重复、泄漏、孤儿或未收敛工作 | 决定性证据证明产品结果偏离 | 本轮已要求执行，但入口、身份、权威状态、receipt 或清理能力缺失而无法判断 | 本轮明确只推导用例，未请求执行 |
| 接受边界真实性 | 声明的入口、身份、数据、Provider 和副作用层级实际经过并绑定 | 绕过入口、走错身份/tenant，或以 synthetic/mock 冒充真实边界 | 本轮已要求执行，但必经真实能力或前置条件不可用 | 本轮明确只推导用例，未请求真实边界验证 |

正确记录非阻断 `Unknown` 时，用例质量仍可为 `Pass`。同一路径同时存在已证实 `Fail` 和另一项 `Blocked` 时分别保留，不能用单一总体词隐藏已证实偏差。

Verifier 工作可以在产品 `Fail` 时完成：只要用例质量已判定，每条旅程都有依据充分的门禁结论，Owner 和重跑入口明确，且没有不确定写入、活动验证或未清理副作用。仅推导用例时，执行闭合和接受边界真实性可为 `Not Requested`，表示不在本轮范围，不表示产品旅程已通过。产品旅程只有在三个门禁均为 `Pass` 且不存在 `Fail` 或 `Blocked` 时才能报告通过。

输出先列范围内旅程、精确候选和环境、三个门禁及证据，再给出覆盖义务与 case 范围、capability profile、真实与 mock 边界、双重 Oracle、产品/Verifier/脚手架归因、证据失效与重跑、清理和明确排除。不要把结构检查、源代码推断、mock、低层测试或功能之外的产品走查写成具体旅程已经通过。
