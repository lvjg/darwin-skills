---
name: judge-evidence
description: 仅用于本仓库的评测裁判，从同一次 case 的原始执行轨迹和采集产物核对证据；不用于被评测 Agent 的任务执行。
---

# 核对执行证据

先按 case 的 criteria 判断；本说明只补充证据位置，不增加、删除或放宽验收要求。

标准 transcript 可能遗漏工具参数、文件修改和 Worker 返回；generated_files 也可能未列出已采集的工作区产物。需要这些证据时：

1. 从当前 generated_files 中的 `outputs/agent/run/stdout.json` 或 `last-message.txt` 路径，确定这一次 case、configuration 的 `outputs/` 目录。不得猜测其他运行目录。
2. 读取该目录的 `workspace/` 下与断言直接相关的文件。这些是执行后采集的实际文件；不要用 Skill 源目录里的原始 fixture 代替最终状态。检查文件实际内容，不用摘要或最终回复代替。
3. 需要执行顺序、写入、派发或返回时，按事件类型与相关路径筛选该目录 `agent/run/rollout-*.jsonl` 的原始轨迹。核对工具调用及对应结果；`agent_message` 的非空返回是 Worker 证据，Supervisor 自己写入 checkpoint 的声明不是独立证据。只读取当前断言需要的片段。
4. 原始轨迹仍可能缺少子执行轨迹或包含加密交接。不得解密、猜测内容或用父任务自述补齐。缺失时，在对应 criterion 的 evidence/failures 中明确写“证据不可用”及具体缺口，继续核对其他可独立判断的要求。

所有访问只读且限于这一次 case 的材料。不执行产物、不修复文件、不改写原始裁判结果；不将一次本地 fixture 的证据扩展为外部环境或其他候选的证明。
