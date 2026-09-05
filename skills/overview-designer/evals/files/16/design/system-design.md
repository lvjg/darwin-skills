# 报表导出状态展示

状态：设计已确认，未提供实现、部署或真实外部验证证据。

## gateway/export-status.ts

调用 Export Service 的状态接口，传递认证参与者。返回此用户可见的导出状态和结果文件身份。不要缓存。读取失败时传递暂时不可用，不生成导出失败状态。

## gateway/export-status-schema.ts

返回字段包含 status、完成时的结果文件引用，以及失败时的 failure_code。failure_detail 不进入网关或 UI。字段类型由已维护合同定义。

## ui/ExportPanel.tsx

展示 Gateway 的实时返回。完成时显示下载链接，失败时显示 failure_code。暂时无法获取时说明读取不可用，不修改导出状态。状态和结果文件身份由 Export Service 唯一拥有。

## tests/export-status.test.ts

检查完成、失败和状态读取不可用三个场景。核对认证参与者传递、结果文件引用和 failure_code 保真，failure_detail 不离开 Owner。上述是计划验证，不是已通过证据。

## 实施清单

1. 修改 Gateway 调用。
2. 修改投影 schema。
3. 修改 Operations UI。
4. 执行针对这三个场景的测试。
