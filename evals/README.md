# Skill 评测

本仓库以 Anthropic `skill-creator` 的 case 格式作为唯一 case Schema。每个发布 Skill 在自己的目录中维护一份 `evals/evals.json`。

格式以 [Anthropic skill-creator schemas](https://github.com/anthropics/skills/blob/main/skills/skill-creator/references/schemas.md#evalsjson) 为准：

```json
{
  "skill_name": "example-skill",
  "evals": [
    {
      "id": 1,
      "prompt": "A realistic user request",
      "expected_output": "A human-readable description of success",
      "files": ["evals/files/1/context/input.md"],
      "expectations": ["A verifiable outcome"]
    }
  ]
}
```

- `id` 是 Skill 内唯一整数。
- `files` 相对 Skill 根目录；fixture 放在 `evals/files/<id>/`，避免不同 case 相互覆盖。
- `expected_output` 说明整体成功结果；可判定要求写入 `expectations`。
- 评测 prompt 必须像真实请求，并明确只允许执行用户已经授权的副作用。

## 当前覆盖

仓库目前为全部 7 个 Skill 维护行为 case；数量和明细以各 Skill 的 `evals/evals.json` 为准：

- `code-reviewer` 覆盖应当接受与应当拒绝的代码候选；`design-reviewer` 还覆盖 Agent/Harness 设计、精确运行材料的设计证据边界、用户决定未决、治理独立性门禁和方案版本漂移；
- `code-simplifier` 覆盖候选代码中的层级、开关、重复决策和形状测试过度实现，离开主路径的配置与注册残留，保留跨进程权威 checkpoint 同时删除无义务内存影子，以及两类主动结构优化：增加最小 vendor 协议边界、集中真实共同规则；反例覆盖候选已经最小、单消费者薄层仍拥有真实协议责任、相似语法承载不同失败策略，并保留公共兼容义务未决时的停止边界；
- `ux-reviewer` 覆盖有证据支持的体验问题与不应臆造问题的完整路径；
- `e2e-verifier` 包含两个 planning-only case 和一个可真实执行的隔离 CLI 旅程；
- `supervisor` 包含恢复后专业委派准备、异步状态守护、合并既有普通 Worker 结果后收敛终态、删除专业能力后的负向路由，以及两个真实 Worker 闭环：从仓库内置清单显式调用专业 Skill、在没有匹配专业 Skill 时委派普通 Worker；
- `overview-designer` 覆盖两个不同领域的完整设计重写、greenfield 目标设计、责任边界无法闭合时的正向系统重构，以及显式调用但实际不是目标设计任务时的退出；同时验证错误理论锚定、已采纳路线失效但无替换授权，以及仅证据修正时保持设计稳定。

Prompt 只陈述真实任务、目标和用户授权；决定结论的事实放在 fixture 中。Expectations 以彼此可区分的必需结果为单位，同时覆盖副作用边界、证据范围和等价合法实现，避免把一种实现措辞当作唯一答案。`evals/run-evals` 使用 `pass_threshold: 1.0`，任一必需结果失败都会使 case 失败，不能由其他次要结果抵消。Reviewer 的正向 case 用于抑制“总是拒绝”的偏差；planning-only E2E case 必须把未执行门禁标为 `Not Requested`，不能把 fixture 未提供的 cleanup owner 当作 Skill 应当臆造的事实。它应把缺失 owner 或 retention policy 记录为未来执行前置或事实恢复缺口。本地执行 case 只证明其隔离 fixture，不代表真实外部产品旅程。

这些 case 用于开发回归和人工审阅，不单独证明全部任务分布、隐式触发准确率或发布质量。触发评测应使用 Anthropic 的独立 `{ "query", "should_trigger" }` 数据集，不能与调用后的行为评测混为一个分数。

## 校验

本仓库固定使用 Skill-Up v0.10.0，并以 Anthropic `evals.json` 为 case 真源。实际运行和 CI 统一通过 `evals/run-evals`：runner 从 `files` 引用读取真实 fixture 内容，生成临时 Skill-Up 配置，并为 Codex 显式使用 `.agents/skills/<skill-name>` 安装目标。项目不维护第二份 case 数据。

Codex 在每个 Session 的系统提示词中提供初始 `Available skills` 清单；显式调用专用的仓库 Skill 不一定出现在该清单。行为评测不承担触发评分，因此适配器会临时物化一份 `AGENTS.md`，要求执行 case 的根 Agent 完整读取已经显式调用的 `.agents/skills/<skill-name>/SKILL.md`。`supervisor` case 还明确把这条根 Supervisor 指令与子 Worker 分开，并把读取前的 Skill 使用声明限制为任务层目的：Worker 不继承 Supervisor 角色，只按交接完整读取其中显式调用的专业 Skill。`supervisor` 使用正文中的仓库内置专业 Skill 清单，并在派发时解析同一安装根下的同级 Skill；原始 prompt、fixture 和授权边界不变。触发能力仍应由独立的触发数据集评测。

评测安装上下文分为两种证据边界：

- `target` 只安装被评 Skill，适合验证它独立承担的组件行为；
- `repository` 安装仓库全部 Skill，适合验证 `supervisor` 能否从仓库内置清单解析同级专业 Skill，并显式委派真实存在的专业能力。

`--skill-context auto` 是默认值：`supervisor` 使用 `repository`，其他 Skill 使用 `target`。这不是固定依赖流水线；case 仍须从当前义务选择能力，未建立的设计、评审、E2E 或清理义务不得仅因 Skill 已安装而出现。若要隔离诊断，可显式传入 `--skill-context target` 或 `--skill-context repository`。

`--dry-run` 只物化并校验配置，不调用模型：

```sh
evals/run-evals --skill-up /path/to/skill-up --model ci-placeholder --dry-run
```

`ruby scripts/validate-skills.rb --base HEAD` 另外要求每个发布 Skill 都有 eval set，并检查 `skill_name`、整数 ID、必需字段和 fixture 引用。CI 执行相同检查并校验固定版本的 Skill-Up。

Supervisor 的真实闭环 case 依赖目标 Codex runtime 提供隔离 Worker 能力。它们必须在接受 Supervisor 行为变更前执行真实评测；`--dry-run` 只能证明 case、fixture、Skill 安装与 runner 配置能够物化，不能替代委派、Skill 加载、Worker 交回和 Supervisor 合并的运行证据。

需要真实 Worker 委派的 case 使用 `[actual-worker-dispatch]` expectation 作为程序判定标记，不把它交给 agent judge。Skill-Up v0.10.0 的 judge transcript 可能在流式事件多于 Session 事件时选用前者，从而遗漏 Codex 的 namespaced collaboration 调用和子 Worker 返回；因此 runner 会在其余语义要求通过后直接检查本次保存的原始 Codex rollout，只有同时存在已返回的 `fork_turns=none` `collaboration.spawn_agent` 调用、非超时的 `collaboration.wait_agent` 返回，以及来自该已派发 Worker 的非空 `agent_message` 才接受该 case。checkpoint、最终回复或产物中的自述不能替代这项运行事件。

## 运行

运行真实评测：

```sh
evals/run-evals \
  --skill-up /path/to/skill-up \
  --model <model> \
  --judge-model <judge-model> \
  --skill-context auto \
  --iteration 3 \
  --timeout 1200 \
  --output-root /tmp/proofloop-skill-evals
```

末尾可追加 Skill 名称只运行选定 Skill，或用 `--case case-2` 选择 case。评估已有 Skill 的新版本时，应在相同 engine、model、权限和输入下分别运行精确旧版本与候选版本；无 Skill 对照不能代替旧版本。

Skill-Up 负责 workspace、重复运行、judge 和 JSON 报告。当前适配器关闭 benchmark，只评估 with-Skill 候选，不把本次分数解释为 Skill 相对无 Skill 的因果提升。模型运行结果不提交到仓库。
