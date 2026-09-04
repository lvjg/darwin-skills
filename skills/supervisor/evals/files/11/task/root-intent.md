# 当前候选独立代码审查

目标是对 `connector-service` 的当前代码候选进行一次独立代码审查，审查对象必须绑定派发时的真实候选版本。

- 当前 case 只准备交接并停在派发前，不调用 Worker。
- `candidate-state.json` 是执行环境导出的当前候选元数据。
- Supervisor 不得读取候选代码、运行测试或自己作出代码质量判断。
- 没有跨回合恢复义务，不创建 checkpoint。
- 当前能力目录已经提供 `$code-reviewer` 的名称、描述和路径。
- Reviewer 只读，不得修改候选；后续返回必须绑定实际审查的 repository、checkout、branch 和 HEAD。
