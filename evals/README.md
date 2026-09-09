# Skill 评测

用例保存在 `skills/<skill-name>/evals/evals.json`，由 Skill-Up 0.10.0 执行。以下命令均在仓库根目录运行。

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

**当前限制：** Codex 通道缺少完整 Worker 执行证据，Supervisor Case 4、5、8 在真实运行前会报错退出。请选其他用例，或在能提供完整证据的执行环境中验证；dry-run 不受此限制。

## 查看结果

报告位于 `<output-root>/<skill-name>/iteration-N/result.json`，单个用例的评分在 `case-<id>/with_skill/grading.json`，采集文件在其 `outputs/workspace/` 下。

所有必需断言通过才算通过；命令退出码为 0 表示本次运行通过，非零表示失败或错误。失败时结合断言和执行证据检查原因。通过只证明本次用例，不能替代真实任务验收；dry-run 只证明配置可加载。

## 维护用例

参考[已有用例](../skills/supervisor/evals/evals.json)。每个用例包含唯一整数 `id`、任务 `prompt`、预期结果 `expected_output` 和可判定的 `expectations`；输入文件通过 `files` 引用，路径相对 Skill 根目录，放在 `evals/files/<id>/` 下。

`intent-clarifier` 用例检查首次响应、给定历史后的续接和授权产物写入。给定历史不等于真实多轮交互；用户隐藏意图能否被及时表达、回答能否持续改变后续工作，需要另做多轮验证，不能把未来回答预先放入被测 Agent 的输入。

带 `[implicit-invocation]` 断言的用例测试自动选用：题面不点名被测 Skill，Codex 入口不注入强制读取它的 `AGENTS.md`，让运行环境正常发现已安装能力。正例检查实际读取并应用，反例允许读取发现元数据，但不应加载正文开展多余澄清。仅回答符合预期不能证明 Skill 已被选用，须结合执行记录判断；缺少读取证据时不能报告触发通过。未带该标记的显式用例保留原有加载要求。

例如仅检查 Intent Clarifier 的自动选用用例配置：

```sh
evals/run-evals --model ci-placeholder --dry-run --case 'case-1[2-5]' intent-clarifier
```

`[checkpoint-markdown path=...]`、`[artifact-markdown path=...]` 增加文件存在性检查并采集文件；`[checkpoint-absent path=...]` 检查文件不存在。格式和内容仍由裁判读取本次工作区中的实际文件判断。

可使用 `skill-upper` 协助维护，继续以 `evals.json` 为唯一用例来源，通过本仓库入口运行。真实缺陷与用例冲突时先修正用例，不为通过评测扭曲 Skill。模型运行产物不提交到仓库。
