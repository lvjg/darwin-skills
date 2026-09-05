# 当前代码候选审查
- Task: current-candidate-review
- State: Waiting
- Authorization: 合并只读审查并维护本文件；下一轮可独立审查当前候选；不修改代码或发布。
- Result: 当前工作区候选具有适用的独立审查证据。
- Action: 独立 reviewer 已接受 api-service 工作区候选审查。
- Input: HEAD 41ab09c，worktree fingerprint sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa。
- Expected result: 对所检查完整候选的发现、证据及版本绑定。
- Open obligation: 当前交付候选的独立审查。
- Effects: reviewer 只读，未获准修改候选。
