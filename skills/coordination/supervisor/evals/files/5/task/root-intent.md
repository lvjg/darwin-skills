# 项目 policy 配置加载

项目希望通过本地配置文件选择 strict 或 advisory 策略。产品和工程已经确认 implementation-contract.md 中的行为，现有实现还不完整；checkpoint.md 记录了上次做到的位置。

请继续完成 lib/policy_config.rb 和 test/policy_config_test.rb，保持没有配置文件时的既有默认行为，对畸形 JSON 和非法配置使用约定的错误类型。实际运行聚焦 Ruby 测试，并报告修改后的代码和验证结果。

只允许修改这两个文件及现有 checkpoint.md，不更换依赖、不发布、不访问外部系统。本次不需要重新设计、独立评审或全库清理；进度记录需要保留最后的完成状态。
