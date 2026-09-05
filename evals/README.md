# Skill 评测

本仓库以 Anthropic `skill-creator` 的 case 格式作为唯一 case Schema。每个发布 Skill 在自己的目录中维护一份 `evals/evals.json`。

## 定位与权威边界

这些 eval 是针对已知失败、关键合同和高风险边界的回归测试，不是 benchmark、产品规范、Skill 行为真源、通用质量分数或发布充分条件。它们只能回答“候选版本在这些受控 case 中是否重现了已知问题”，不能证明候选在真实任务分布上最优，也不能把 fixture 中的局部假设提升为通用流程。

行为判断的优先级是：当前用户目标与授权、适用的上层指令、领域 Owner 和权威现状，随后才是 Skill 合同；eval 从这些合同和真实缺陷中派生，不反向拥有它们。真实任务证据与既有 case 冲突时，先判断 case 是否陈旧、过拟合或写错；错误 case 应被修正或删除，不得为了通过 eval 扭曲 Skill、制造流程或保留已经失效的义务。

通过表示没有观察到这些 case 覆盖的回归；失败表示需要调查候选、case、fixture、runner 和 judge 中哪一层不成立。无论通过或失败，都不能脱离实际任务的 Owner、消费者、状态、失败语义和验收边界直接决定设计。

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
- `supervisor` 包含恢复后专业委派准备、异步状态守护、合并既有普通 Worker 结果后收敛终态、删除专业能力后的负向路由、四个真实 Worker 闭环，以及针对真实使用缺陷的回归：能力目录只在正确时机刷新、兼容查询合并为一个 explore Worker、不兼容授权边界保持拆分、新 checkpoint 优先使用有效既有载体或 Owner 项目 `.supervisor/`、无项目时回退系统临时目录、使用真实 Markdown 内容并在没有保留义务时清理；另外覆盖派发前核对版本、使用证据时识别同 HEAD 下的候选漂移、固定提交证据复用、实现结果版本与输入版本的区别，以及专业前提缺失时不自行补出结论；保留重复障碍和慢性控制消耗的进展回归。Case 17 真实委派查询本地操作 Owner，检查预制 checkpoint 恢复后不重复发布；完整跨上下文恢复按下述方法另行验证；
- `overview-designer` 覆盖完整设计重写、greenfield 目标设计、责任边界无法闭合时的正向系统重构，以及显式调用但实际不是目标设计任务时的退出；同时验证错误理论或技术边界导致的问题表述偏差、已采纳路线失效但无替换授权、证据修正与已接受 intent change 的分类、局部 Key Design 不扩张为全系统结构、两个均满足硬约束的可行方向间的质量与生命周期取舍，以及仅改变规则更新频率就应翻转选择的配对场景；验证必要的 API 边界和已有 SDK 抽象，条件未知下继续独立设计、路线受阻时有界交付，未承诺未来不产生当前机制，以及通过责任归属调整消解同步问题。

Prompt 只陈述真实任务、目标和用户授权；决定结论的事实放在 fixture 中。Expectations 以彼此可区分的必需结果为单位，同时覆盖副作用边界、证据范围和等价合法实现，避免把一种实现措辞当作唯一答案。`evals/run-evals` 使用 `pass_threshold: 1.0`，任一必需结果失败都会使 case 失败，不能由其他次要结果抵消。Reviewer 的正向 case 用于抑制“总是拒绝”的偏差；planning-only E2E case 必须把未执行门禁标为 `Not Requested`，不能把 fixture 未提供的 cleanup owner 当作 Skill 应当臆造的事实。它应把缺失 owner 或 retention policy 记录为未来执行前置或事实恢复缺口。本地执行 case 只证明其隔离 fixture，不代表真实外部产品旅程。

这些 case 用于开发回归和人工审阅，不单独证明全部任务分布、隐式触发准确率或发布质量，也不作为 Skill 修改的独立决策者。触发评测应使用 Anthropic 的独立 `{ "query", "should_trigger" }` 数据集，不能与调用后的行为回归混为一个分数。

### Supervisor 跨上下文恢复验证

Case 17 的预制 checkpoint 只测试恢复后的行为。验证实际生成到恢复的完整链时，复用它的 fixture，在隔离临时目录进行以下操作；不另建 case Schema 或运行框架：

1. 复制该 case 的 `root-intent.md`、`operation.rb` 和当前 Skill；不复制预制 checkpoint，将 `operation.json` 初始化为 `{"start_count":0,"operations":{}}`。
2. 在新上下文中显式调用 Supervisor 完成同一发布目标，要求它在操作被接受后交还控制。保存实际生成的 checkpoint、接受回执和执行轨迹，然后结束该执行上下文。
3. 由验证执行者模拟 Owner 独立完成操作：只将原操作改为 `succeeded`、`running_revision: release-27`、`healthy: true`。保留操作标识和 `start_count`，不修改生成的 checkpoint。
4. 用第二个不继承第一段对话的新上下文恢复，只提供 Skill、项目位置、原任务及实际生成的 checkpoint。不得传第一段对话、操作回执或预期答案来补齐丢失的控制信息。
5. 核对第二段真实查询的是原操作；`start_count` 仍为 1、操作仍只有一个、脚本与任务合同未改、checkpoint 保留正确授权并在权威证据成立后完成。保存两段上下文身份、交接输入、轨迹和最终文件。

这证明隔离本地 Owner 下，接受后交还控制再以新上下文恢复的路径；不等价于真实外部部署、进程崩溃注入，或 Waiting 尚未落盘时的恢复证明。只运行 Case 17 或 dry-run 不得声称完整链已验证。

## 校验

本仓库固定使用 Skill-Up v0.10.0，并以 Anthropic `evals.json` 作为唯一 case 存储格式；这里的“唯一”只表示 runner 不维护第二份配置，不表示 case 拥有 Skill 或领域行为。实际运行和 CI 统一通过 `evals/run-evals`：runner 从 `files` 引用读取 fixture 内容，生成临时 Skill-Up 配置，并为 Codex 显式使用 `.agents/skills/<skill-name>` 安装目标。

Codex 在每个 Session 的系统提示词中提供初始 `Available skills` 清单；显式调用专用的仓库 Skill 不一定出现在该清单。行为评测不承担触发评分，因此适配器会临时物化一份 `AGENTS.md`，要求执行 case 的根 Agent 完整读取已经显式调用的 `.agents/skills/<skill-name>/SKILL.md`。`supervisor` case 还明确把这条根 Supervisor 指令与子 Worker 分开：Worker 不继承 Supervisor 角色，只按交接完整读取其中显式调用的专业 Skill。`supervisor` 优先使用 Session 能力目录；目录不足以判断与本 Skill 一同安装的专业能力时，只读取一次 `references/capability-fallback.md` 并解析其中缺失的同级 Skill frontmatter。原始 prompt、fixture 和授权边界不变。触发能力仍应由独立的触发数据集评测。

评测安装上下文分为两种证据边界：

- `target` 只安装被评 Skill，适合验证它独立承担的组件行为；
- `repository` 安装仓库全部 Skill，适合验证 `supervisor` 能否在 Session 目录不完整时通过 capability fallback 解析同级专业 Skill，并显式委派真实存在的专业能力。

`--skill-context auto` 是默认值：`supervisor` 使用 `repository`，其他 Skill 使用 `target`。这不是固定依赖流水线；case 仍须从当前义务选择能力，未建立的设计、评审、E2E 或清理义务不得仅因 Skill 已安装而出现。若要隔离诊断，可显式传入 `--skill-context target` 或 `--skill-context repository`。

`--dry-run` 只物化并校验配置，不调用模型：

```sh
evals/run-evals --skill-up /path/to/skill-up --model ci-placeholder --dry-run
```

`ruby scripts/validate-skills.rb --base HEAD` 另外要求每个发布 Skill 都有 eval set，并检查 `skill_name`、整数 ID、必需字段和 fixture 引用。CI 执行相同检查并校验固定版本的 Skill-Up。

Supervisor 的真实闭环 case 依赖目标执行环境提供真实、可观测的 Worker 能力。修改委派、等待、恢复或收敛合同时，应在目标 harness 和凭据可用时运行相关真实 case，作为回归证据之一；`--dry-run` 只能证明 case、fixture、Skill 安装与 runner 配置能够物化，不能替代委派、Skill 加载、Worker 交回和 Supervisor 合并的运行证据。真实任务已经暴露缺陷时，不得因为旧 eval 曾通过而否认缺陷，应先补齐或修正覆盖。

需要真实 Worker 委派的 case 使用 harness 无关的行为标记：通用闭环使用 `[worker-roundtrip]`，要求不得拆成多个 Worker 时使用 `[single-worker-roundtrip]`。它们只规定可观测结果：真实 Worker 在未继承完整会话的新鲜、有界上下文中完成委派并返回非空结果；如果 harness 将委派与等待分开，还须观察到非超时的完成返回。Case 不指定子 Agent API、事件名、上下文参数或 trace 存储格式。Supervisor 的 `[checkpoint-markdown path=...]` 和 `[checkpoint-absent path=...]` 会分别转换为最终 workspace 的确定性存在或不存在断言；前者还采集文件并由 runner 检查首个非空行是真实 Markdown H1。语义内容、状态转换和中间写入顺序仍由 case expectation 判断。每个 case 还会用 Skill-Up 的 `collect_artifacts` 采集其 `files` 引用中仍存在的文件，保留实际 Owner 状态、输入和结果对象；已按任务删除的文件不要求恢复。

设计文档使用 `[artifact-markdown path=...]` 时，程序检查文件存在、非空且为有效 UTF-8 文本，并采集最终文件及输入 fixture；该 expectation 同时保留给 judge，要求直接读取采集文件判断其是否为可直接使用的 Markdown 设计内容。程序不强制标题写法，也不把文本编码合法等同于内容合格。原有 `[checkpoint-markdown]` 的专用 H1 检查保持不变。输入 fixture 必须是有效 UTF-8 文本，不能经 YAML binary 编码替换原文。

Skill-Up v0.10.0 的 Codex judge transcript 可能遗漏 namespaced collaboration 调用和子 Worker 返回；因此 runner 仅在 `--engine codex` 时用引擎证据适配器从原始 trace 验证同一通用合同。该适配器接受不继承会话或只继承有界回合的上下文，不把某个固定参数写进 case 合同。其它 Skill-Up 引擎由 agent judge 根据标准执行 transcript 判定这两个标记；如果目标 harness 未暴露必需事件，应报告“证据不可用”而不是降级接受 checkpoint、最终回复或产物中的自述。新增引擎证据适配器不需要修改 case。适配器只证明委派拓扑和往返；explore 职责、来源权威、交接内容、checkpoint 语义和最终决定仍由 case 的语义 expectation 判断。 当前 Codex 如果只暴露加密交接，runner 将该用例标为 `ERROR` 并注明证据不可用，保留已取得的断言和模型裁判结果；不把它改记通过，也不将缺失证据认定为已观察到的行为违规。

使用 Skill-Up 的 `judge.skills` 仅为裁判加载 `evals/judge-evidence`，引导它从当前 case 的输出目录读取已采集文件和原始轨迹。该辅助 Skill 不安装到被评测 Agent，不提供 case 答案；加密交接或缺失的子执行轨迹仍须标明证据不可用。

## 最终结果与本地回归

`result.json`、`report.json` 和各用例 `grading.json` 是合并模型裁判及程序检查后的最终结果，命令退出码使用同一结论。程序检查在模型裁判失败后仍执行：已观察到的格式或委派约束违反记为 `FAIL`；本次所需文件、可读交接等证据不可用记为 `ERROR`，同时保留已有失败断言。不会复用旧运行的文件或报告来补出通过。

每次运行的原始 Skill-Up 结果、分数摘要和 grading 保存在该 iteration 的 `skill-up/` 下，仅供归因；原始 benchmark 摘要不再与最终报告并列。模型用量和时间仍保留原记录。

运行 `ruby evals/test-run-evals.rb` 可在不调用模型、网络或凭据的情况下，验证证据采集配置、程序失败覆盖模型 PASS、证据不可用、模型失败后继续程序检查，以及多轮和陈旧产物的处理。CI 执行同一组回归。

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

末尾可追加 Skill 名称只运行选定 Skill，或用 `--case case-2` 选择 case。普通回归只需在明确的 engine、model、权限和 fixture 边界下运行候选版本；只有诊断具体行为变化时才需要对照旧版本，并且对照结果仍不是 benchmark 或因果提升证明。

Skill-Up 负责 workspace、重复运行、judge 和 JSON 报告。当前适配器明确关闭 benchmark，只执行 with-Skill 回归；报告中的通过率只汇总本次 case 结果，不解释为 Skill 相对无 Skill、旧版本或其它实现的因果提升。模型运行结果不提交到仓库。
