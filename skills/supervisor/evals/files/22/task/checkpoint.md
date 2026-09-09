# Export local delivery

Task: export-22
State: Active
Result: export-22@f4ac901 的本地完整导出结果。
Constraints: 只允许本地验证；保留导出审计记录，禁止重置数据库和生产发布。
Basis: root-intent.md；不可变候选 export-22@f4ac901。
Open: CSV 正确性、租户隔离、峰值内存边界、独立代码验收、真实本地下载结果都未闭合。
Action: 接纳原执行者已返回的 CSV 结果；不实际派发。
Effects: 无活动命令或未知效果。
