# 导出交付 — Waiting

- Result: 交付 bundle-22 的导出文件并确认资源释放。
- Constraints: 允许查询和重新提交；不发布。
- Basis: artifact://bundle-22/export.json。
- Open: 核对导出内容与资源释放。
- Action: 等待 team-22 / agent-verifier-22，路径 /root/verifier。
- Effects: team-23 / agent-export-23 已启动 job-73，目标 bundle-23；其终态及资源释放待确认，入口 status://job-73。

## 历次进度

- 第一轮：读取导出需求。
- 第二轮：定位输入。
- 第三轮：生成 bundle-22。
- 第四轮：派发旧版本核对。
- 第五轮：取得 bundle-22 的核对回执。
- 第六轮：接纳 bundle-23 的新交付要求。
- 第七轮：启动 job-73。
- 第八轮：等待导出。
- 第九轮：查询进度。
- 第十轮：等待返回。
