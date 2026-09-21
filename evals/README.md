# Skill 评测

用例保存在 `skills/<category>/<skill-name>/evals/evals.json`，由 Skill-Up 0.10.0 执行。以下命令均在仓库根目录运行。默认运行所有带 eval 集的 Skill；显式指定没有 eval 的 Skill 会报错。

## 校验与运行

静态校验和配置检查，不调用模型：

```sh
ruby scripts/validate-skills.rb --base HEAD
evals/run-evals --model ci-placeholder --dry-run
```

运行前安装 Skill-Up 0.10.0，并配置所选执行引擎的登录或凭据。将 `MODEL_NAME` 替换为实际模型名：

```sh
evals/run-evals --model MODEL_NAME \
  --output-root /tmp/skill-evals \
  --case case-20 supervisor
```

末尾指定 Skill；省略 `--case` 运行该 Skill 全部用例。默认引擎为 Codex，裁判使用同一模型；可通过 `--engine`、`--judge-model` 修改。`--iteration N` 可重复运行，其他参数见 `evals/run-evals --help`。

Supervisor 和 Intent Clarifier 默认安装仓库全部 Skill，后者用于检验自动选用的正反例；其他用例只安装被评 Skill。需要隔离诊断时使用 `--skill-context target` 或 `--skill-context repository`。依赖其他 Skill 的组合用例需要 repository 上下文。

运行器只安装 Skill 的运行资料，排除 `evals/` 和 `.git/`；用例只注入 `files` 明确列出的输入。`expected_output` 保留在定义中供维护者阅读，`expectations` 交给裁判评分；两者不作为任务描述或 Skill 资料交给被测模型。

**当前限制：** Codex 通道缺少完整 Worker 执行证据，Supervisor Case 4、5、21 在真实运行前会报错退出。请选其他用例，或在能提供完整证据的执行环境中验证；dry-run 不受此限制。

## 查看结果

报告位于 `<output-root>/<skill-name>/iteration-N/result.json`，单个用例的评分在 `case-<id>/with_skill/grading.json`，采集文件在其 `outputs/workspace/` 下。

真实运行要求对应 Skill 的结果目录为空，已有结果时使用新的 `--output-root`。同目录的 `run-metadata.json` 保存本次物化的 Skill、case、输入文件与执行配置哈希，以及模型和工具版本；不保存输入正文或凭据。它证明交给运行器的内容，不代替实际加载和 Worker 执行证据。修改前后比较应使用相同输入、模型和执行条件，并同时检查结果质量与新增执行负担；单次通过不证明稳定提升，harness 哈希因临时安装路径变化可不同。

所有必需断言通过才算通过；命令退出码为 0 表示本次运行通过，非零表示失败或错误。失败时结合断言和执行证据检查原因。通过只证明本次用例，不能替代真实任务验收；dry-run 只证明配置可加载。

## 维护用例

`[artifact-json path=相对路径]` 与 `[artifact-markdown path=相对路径]` 都会生成文件存在性检查并收集最终产物，不会将产物预置到任务输入中。JSON 的解析与内容要求写在该断言中，由裁判直接检查收集文件；标签本身不提供自动 JSON 内容判定。

### 核心覆盖

每个 Skill 保留少量代表性任务，题面给出业务目标、当前材料和必要权限，让模型自行发现问题和选择方法。通过完整任务的结果判断能力，不把每条指令拆成一道题，也不把旧断言堆进综合题。合成代码和受控数据用于可重复判断，不冒充真实项目或生产证据。输入可以包含待审方案和作者的验证报告，但不直接写出裁判应发现的缺陷；报告中的测试主张应有可检查的材料，缺失时须明确其证据边界。判定允许满足业务约束的合理替代实现，不按文件名、类名或代码写法判分。

UX 两例使用模拟 QA 走查记录，检查从既有记录开展评审的能力，不证明现场浏览器操作能力。Code Reviewer 4、5 提供可运行的本地测试；内存存储和受控传输替身只支持对应的单元与调用方验证，不证明外部存储、网络或生产结果。

| Skill | 保留 ID | 核心任务 |
| --- | --- | --- |
| `system-designer` | 1、4、11 | 订单处理架构、维修分配算法、文档到 SOP 综合设计 |
| `intent-clarifier` | 5、12、14 | 根据部分回答继续澄清、将模糊目标变成具体取舍、已知事实下直接交付 |
| `supervisor` | 4、5、20、21、22、23 | 有界设计委派、协调实现与验证、未知效果恢复、等待本地作业、容量受限时补证、Codex 消息与身份恢复回放 |
| `design-reviewer` | 1、3、11 | 发现系统方案的关键缺口、认可成立的方案、识别空泛的 Agent 行为设计 |
| `code-reviewer` | 1、4、5 | 跨合同缺陷与证据不足、接受合理实现、识别功能正确但维护负担过重的改动 |
| `code-simplifier` | 1、6、9 | 简化多余转发、保留不同失败策略、统一真正相同的业务规则 |
| `e2e-verifier` | 1、4、5 | 规划完整旅程、实际复验故障分支、清理资料并保全已有证据 |
| `ux-reviewer` | 1、2 | 工作区删除与密码重置两个体验评审，分别检验实质问题发现和合理接受 |
| `skill-doctor` | 1、2、3 | 组合触发冲突、维护指令的完成与授权边界、多模型共享指令中的冗余及必要约束 |

共 29 个用例。ID 保留原编号，允许不连续，便于追溯已有报告。已删除的用例及其专属输入不再维护；这是一组核心能力样本，不声称覆盖所有边界。

Supervisor Case 21 使用约 70 秒的受控本地作业，观察真实委派、等待和独立核对；这个等待窗口不代表产品性能，不模拟容量拒绝。E2E Case 5 检查本地回执与清理行为，不证明生产旅程。Codex 协作工具可用于补充执行证据；其结果单独记录，不冒充 Skill-Up 通道已支持完整 Worker 取证。

Supervisor Case 20 检查恢复时保留未知效果、接纳收紧后的授权、撤销失效证据并复用有效交付。Case 22 使用权威暂停点材料回放容量拒绝后的调度与整体完成判断；只更新控制记录和准备交接，不调用真实 Worker 接口，不能证明运行环境的容量处理或委派往返。

Supervisor Case 4 的单一设计责任没有建立持久化义务，不要求创建 checkpoint；具备宿主委派条件时，专业工作仍由真实 Worker 执行；若无相容 Worker 且宿主不允许新建，须如实报告能力阻塞，不为测试绕过限制。Worker 往返允许最终消息与等待工具返回分开送达，普通信箱活动不算完成。

Supervisor Case 23 是 Codex 协作接口语义下的离线恢复回放：区分唤醒、最终消息、旧身份返回和未知作业效果，准备对相容 idle Worker 的续派，并把遗留进度整理为当前快照。它检查既有防膨胀、授权和有界交接约束在 Codex 中是否保持，不证明真实 Codex 委派、自动压缩恢复或长期 token 收益。需要这些结论时另取实际运行证据，不能用回放或最终文件替代。

### Skill Doctor 的三个任务

[Skill Doctor 用例](../skills/maintenance/skill-doctor/evals/evals.json) 使用合成指令、请求背景和消费者材料，检查只读诊断是否发现具体问题并保留有依据的约束。Case 1 将多个 Skill 定义作为审查材料，检查建议能否消除仅解释 SELECT 时的强制迁移准备，并保留合理重叠；不测试运行时自动选用或描述截断。Case 2 根据脚本源码区分本地测试事实与未知数据库目标，不运行脚本或验证真实环境。Case 3 检查冗余验证、真实操作顺序和阶段停止边界，区分纯文档拼写交付与提交的测试豁免、行为改动的必要验收；题面中的模型配置只提供消费者背景，不证明各模型的能力或跨模型兼容性。

```sh
evals/run-evals --model MODEL_NAME --output-root /tmp/skill-doctor-core skill-doctor
```

### System Designer 的三个任务

[System Designer 用例](../skills/design/system-designer/evals/evals.json) 只保留三个完整任务：

| ID | 场景 | 主要判断 |
| --- | --- | --- |
| 1 | 网站、客服和合作方统一创建订单 | 整体业务结果、数据与控制关系、职责以及跨系统取舍是否成立 |
| 4 | 维修主管安排具备不同技能的人员处理工单 | 问题表示、候选形成和选择是否具体，能否得到可行日程并识别无法全部完成的情况 |
| 11 | 业务文档生成与修改 SOP | 架构是否支持内部创作策略，策略能否保留真实业务含义，并将研究方法适配到当前能力 |

Case 11 的业务文档是历史任务的脱敏节选，当前系统合同是模拟条件；其他材料为合成条件。算法题用小样本核对可行性，同时要求考虑日常规模，不把小样本推演当作生产性能证明。

三个任务同时覆盖交付方式：Case 1 从项目约定确定仓库 Markdown 位置，Case 4 直接在会话内交付完整局部设计，Case 11 写入用户指定文件。三者都检查实际输出是否遵循设计标准，读取过标准不等于内容合格。

分别核对产物质量、Skill 加载和研究证据。`skill-execution` 要求可核实的实际加载证据；合格产物本身不证明 Skill 已应用。Case 11 提供论文原文入口，要求读到相关方法并说明其对方案的影响，不指定采用路线；来源不可访问时单列研究证据不足，不把来源故障解释为设计能力退步。只列能力名称或把核心机制推迟到后续设计，不能通过内容质量判断。

```sh
evals/run-evals --model MODEL_NAME --output-root /tmp/system-designer-core system-designer
```

### 通用格式

参考[已有用例](../skills/coordination/supervisor/evals/evals.json)。每个用例包含唯一整数 `id`、任务 `prompt`、预期结果 `expected_output` 和可判定的 `expectations`；输入文件通过 `files` 引用，路径相对 Skill 根目录，放在 `evals/files/<id>/` 下。

`intent-clarifier` 用例检查意图形成、给定对话后的续接及清晰任务下的直接交付。给定历史不等于真实多轮交互；用户隐藏意图能否被及时表达、回答能否持续改变后续工作，需要另做多轮验证，不能把未来回答预先放入被测 Agent 的输入。

带 `[implicit-invocation]` 断言的用例测试自动选用：题面不点名被测 Skill，Codex 入口不注入强制读取它的 `AGENTS.md`，让运行环境正常发现已安装能力。正例检查实际读取并应用，反例允许读取发现元数据，但不应加载正文开展多余澄清。仅回答符合预期不能证明 Skill 已被选用，须结合执行记录判断；缺少读取证据时不能报告触发通过。未带该标记的显式用例保留原有加载要求。

例如仅检查 Intent Clarifier 的自动选用用例配置：

```sh
evals/run-evals --model ci-placeholder --dry-run --case case-12 --case case-14 intent-clarifier
```

`[checkpoint-markdown path=...]`、`[artifact-markdown path=...]` 增加文件存在性检查并采集文件；`[checkpoint-absent path=...]` 检查文件不存在。格式和内容仍由裁判读取本次工作区中的实际文件判断。

可使用 `skill-upper` 协助维护，继续以 `evals.json` 为唯一用例来源，通过本仓库入口运行。真实缺陷与用例冲突时先修正用例，不为通过评测扭曲 Skill。模型运行产物不提交到仓库。
