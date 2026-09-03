# 必要查询来源

同一个切换决定需要以下只读观察：

1. 当前仓库中 `applicant-tenants-v1` 的模板、Draft、returned Task、Resubmit 和部署消费者，以及对应代码或配置版本；
2. 云管官方接口文档中租户 `code` 精确过滤的 grammar、编码、分页和错误 envelope，并返回文档 revision 或稳定引用；
3. 目标环境 PostgreSQL 中仍可消费 V1 binding 的 editing Draft、returned/resubmittable Task 和相关 Instance 的聚合计数及旧站点值分布。

这些来源只用于证明是否存在删除、迁移或有界兼容义务。任何来源不可访问或不足时，返回实际事实 Owner 和最小缺失证据，不得猜测结果。
