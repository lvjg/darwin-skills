# CI 记录（合成，不是已确定归因）

## Job install-linux，head b200

Node 18.20，linux-x64，冷缓存。总时长 71 秒，exit=1。
```
WARN Unsupported engine query-core@3.0.1 expected node>=20 current v18.20
WARN optional query-native prebuilt download: ETIMEDOUT mirror.internal.invalid
INFO optional dependency query-native skipped
ERROR packages/search-client: engine-strict rejects query-core@3.0.1
```

## Job smoke-local，head b200

工程师手动运行，Node 20.11，macOS-arm64，使用本地安装缓存；跳过 typecheck，只跑共享库 mock 单测。23/23 passed。无法据此确认 Linux 容器或真实 query-core 路径。

## Job compatibility，head b200，工程师试验补丁 p1

Node 20.11，linux-x64。p1 将 result.map 改为 result.items.map；暂时禁用了 engine-strict。query-native 因镜像超时缺失，使用纯 JS。
```
PASS packages/search-client unit: 23 tests
PASS catalog integration: first page shows results
FAIL catalog integration: next page
HTTP 400 {"code":"UNSUPPORTED_CURSOR_VERSION"}
```
模拟 query-server 版本记录为 5.1。仅保留以上摘要，read_log 可获得请求与测试上下文。

## Job legacy-baseline-retry，base a100

Node 18.20，linux-x64，冷缓存，exit=1。
```
ERROR fetch query-core@2.8.4: EAI_AGAIN mirror.internal.invalid
```
此 Job 与绿色基线并非同次运行，也没有完成安装或业务测试。

以上材料尚无：生产 query-server 版本、Node20 下完整 typecheck、未加 p1 时真实搜索路径的运行结果、关闭缓存且镜像健康时的独立对照、启用重试后的下游调用数量记录。可以继续设计检查，不保证所有缺项都需要补齐。
