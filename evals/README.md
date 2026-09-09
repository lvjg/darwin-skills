# Skill 评测

用例保存在 `skills/<category>/<skill-name>/evals/evals.json`，由 Skill-Up 0.10.0 执行。以下命令均在仓库根目录运行。默认运行所有带 eval 集的 Skill；显式指定没有 eval 的 Skill 会报错。`skill-doctor` 当前尚无 eval 集。

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
  --case case-2 supervisor
```

末尾指定 Skill；省略 `--case` 运行该 Skill 全部用例。默认引擎为 Codex，裁判使用同一模型；可通过 `--engine`、`--judge-model` 修改。`--iteration N` 可重复运行，其他参数见 `evals/run-evals --help`。

Supervisor 和 Intent Clarifier 默认安装仓库全部 Skill，后者用于检验自动选用及与设计技能的组合；其他用例只安装被评 Skill。需要隔离诊断时使用 `--skill-context target` 或 `--skill-context repository`。依赖其他 Skill 的组合用例需要 repository 上下文。

运行器只安装 Skill 的运行资料，排除 `evals/` 和 `.git/`；用例只注入 `files` 明确列出的输入。`expected_output` 保留在定义中供维护者阅读，`expectations` 交给裁判评分；两者不作为任务描述或 Skill 资料交给被测模型。

**当前限制：** Codex 通道缺少完整 Worker 执行证据，Supervisor Case 4、5、8 在真实运行前会报错退出。请选其他用例，或在能提供完整证据的执行环境中验证；dry-run 不受此限制。

## 查看结果

报告位于 `<output-root>/<skill-name>/iteration-N/result.json`，单个用例的评分在 `case-<id>/with_skill/grading.json`，采集文件在其 `outputs/workspace/` 下。

所有必需断言通过才算通过；命令退出码为 0 表示本次运行通过，非零表示失败或错误。失败时结合断言和执行证据检查原因。通过只证明本次用例，不能替代真实任务验收；dry-run 只证明配置可加载。

## 维护用例

### Designer

[Designer 用例](../skills/design/designer/evals/evals.json) 包含 10 个基础场景和 1 个研究条件变体：

| 用例 | 设计任务 |
| --- | --- |
| 1–3 | 多入口订单、多区域配置发布、大数据导出 |
| 4–6 | 维修分配、反馈归并、增量构建策略 |
| 7–8 | 文档到 SOP、依赖升级诊断助手的系统与内部策略 |
| 9–10 | 简单版本展示、批次分配改为持续到达后的方案修订 |
| 11 | Case 7 的相同输入，另给论文原文入口，检查方法理解与适配 |

Case 7/11 的业务文档为历史输入的脱敏节选，当前系统合同是模拟条件；其余材料为合成条件。它们不等于原任务完整复现。研究变体需要实际读取方法内容，来源不可访问时应单列为研究证据不足，不能据此声称 Skill 研究能力通过或退步。

Designer 的产物质量、Skill 加载证据和研究证据分别核对。`skill-execution` 检查实际运行资料是否进入执行者上下文；缺少记录时不能把合格产物归因为 Skill，也不能直接断言没有加载。SOP 用例要求展开阻断业务结果的已知能力缺口，列出能力名称或推迟核心设计不足以通过；缺失的业务决定可保持明确的条件化结论。

基础场景和研究变体可分别运行，以免混合来源可用性与设计质量：

```sh
evals/run-evals --model MODEL_NAME --case 'case-[1-9]' --case case-10 --output-root /tmp/designer-base designer
evals/run-evals --model MODEL_NAME --case case-11 --output-root /tmp/designer-research designer
```

### 通用格式

参考[已有用例](../skills/coordination/supervisor/evals/evals.json)。每个用例包含唯一整数 `id`、任务 `prompt`、预期结果 `expected_output` 和可判定的 `expectations`；输入文件通过 `files` 引用，路径相对 Skill 根目录，放在 `evals/files/<id>/` 下。

`intent-clarifier` 用例检查首次响应、给定历史后的续接和授权产物写入。给定历史不等于真实多轮交互；用户隐藏意图能否被及时表达、回答能否持续改变后续工作，需要另做多轮验证，不能把未来回答预先放入被测 Agent 的输入。

带 `[implicit-invocation]` 断言的用例测试自动选用：题面不点名被测 Skill，Codex 入口不注入强制读取它的 `AGENTS.md`，让运行环境正常发现已安装能力。正例检查实际读取并应用，反例允许读取发现元数据，但不应加载正文开展多余澄清。仅回答符合预期不能证明 Skill 已被选用，须结合执行记录判断；缺少读取证据时不能报告触发通过。未带该标记的显式用例保留原有加载要求。

例如仅检查 Intent Clarifier 的自动选用用例配置：

```sh
evals/run-evals --model ci-placeholder --dry-run --case 'case-1[2-5]' intent-clarifier
```

`[checkpoint-markdown path=...]`、`[artifact-markdown path=...]` 增加文件存在性检查并采集文件；`[checkpoint-absent path=...]` 检查文件不存在。格式和内容仍由裁判读取本次工作区中的实际文件判断。

可使用 `skill-upper` 协助维护，继续以 `evals.json` 为唯一用例来源，通过本仓库入口运行。真实缺陷与用例冲突时先修正用例，不为通过评测扭曲 Skill。模型运行产物不提交到仓库。
