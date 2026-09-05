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

Supervisor 默认安装仓库全部 Skill，其他用例只安装被评 Skill。需要隔离诊断时使用 `--skill-context target` 或 `--skill-context repository`。

**当前限制：** Codex 通道缺少完整 Worker 执行证据，Supervisor Case 4、5、8 在真实运行前会报错退出。请选其他用例，或在能提供完整证据的执行环境中验证；dry-run 不受此限制。

## 查看结果

报告位于 `<output-root>/<skill-name>/iteration-N/result.json`，单个用例的评分在 `case-<id>/with_skill/grading.json`，采集文件在其 `outputs/workspace/` 下。

所有必需断言通过才算通过；命令退出码为 0 表示本次运行通过，非零表示失败或错误。失败时结合断言和执行证据检查原因。通过只证明本次用例，不能替代真实任务验收；dry-run 只证明配置可加载。

## 维护用例

参考[已有用例](../skills/supervisor/evals/evals.json)。每个用例包含唯一整数 `id`、任务 `prompt`、预期结果 `expected_output` 和可判定的 `expectations`；输入文件通过 `files` 引用，路径相对 Skill 根目录，放在 `evals/files/<id>/` 下。

`[checkpoint-markdown path=...]`、`[artifact-markdown path=...]` 增加文件存在性检查并采集文件；`[checkpoint-absent path=...]` 检查文件不存在。格式和内容仍由裁判读取本次工作区中的实际文件判断。

可使用 `skill-upper` 协助维护，继续以 `evals.json` 为唯一用例来源，通过本仓库入口运行。真实缺陷与用例冲突时先修正用例，不为通过评测扭曲 Skill。模型运行产物不提交到仓库。
