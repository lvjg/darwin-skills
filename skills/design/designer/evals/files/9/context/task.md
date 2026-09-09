# 管理员查看构建版本

本题全部接口与记录均为合成测试条件。请为现有后台补充查看当前构建版本的最小设计，只写 `evals/files/9/design/solution.md`。不实现代码，不修改资料。

产品已经确定：管理员在“系统设置”现有页面查看 version、commit 的前 12 位和 build_time（UTC）。只需打开页面时读取以及用户点击刷新；没有历史版本、订阅、发布管理或线上诊断需求。部署目前每个环境只有一个后端实例，暂不考虑滚动升级的混合实例展示。

已经实现并完成团队验收的能力如下，作为本题给定事实，不需要重新访问真实接口：

- Build Service 从镜像内只读 build-manifest.json 提供 GET /internal/build，响应字段 version、commit（40 位十六进制）、build_time（RFC3339 UTC）。文件缺失或任一字段非法时返回 503 BUILD_INFO_UNAVAILABLE，不返回上一次版本。
- 现有 Gateway GET /admin/system/build 已经过 admin 鉴权：登录失效 401，非管理员 403，成功时原样投影三个字段；上游 503 或超时映射为 503 BUILD_INFO_UNAVAILABLE。Gateway 不缓存此接口，最多等待 2 秒。浏览器不得直连 Build Service。
- 管理后台已有 authFetch：按用户会话调用 Gateway，401 跳转现有登录流程、403 呈现现有无权限页；网络错误抛出 NetworkError。路由 /settings/system 已在管理员菜单中，现有 SettingsPanel 可呈现标签和值，LoadingPlaceholder 可呈现加载中，InlineRetry 可呈现失败和刷新按钮。前端只缓存当前组件内状态，页面卸载即丢弃。
- 页面语言中文；合法响应示例 {"version":"3.4.7","commit":"7d06a1fa2b6e190dde30f54d6dcfe7096c920ae1","build_time":"2026-09-01T08:30:00Z"}。

显示规则：加载失败、网络失败或收到非法成功响应时显示“当前版本暂不可用”，不能展示上次成功值冒充当前结果。刷新期间可以显示加载态；不要求保留旧值。所需能力明确，无需添加其他数据字段、部署能力或额外平台。
