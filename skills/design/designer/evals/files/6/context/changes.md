# 独立变化场景

摘要是合成的内容身份符号，不是实际 SHA 值。不同符号代表字节不同，相同符号代表字节完全相同。

- A：只更新 web.ts 的修改时间，内容仍为 w1。其他输入、参数、环境和工具全部等于基线。
- B：api.proto 从 p1 变为 p2。工具和其他输入不变。计划开始时不知道生成结果。随后给你一份合成成功回执：G 本次执行结束，gen/api.js 为 j2，gen/api.py 仍为 y1。请分别解释回执前与回执后的判断，不要将回执内容当成开始时已知事实。
- C：源文件全部不变，G 工具从 schema-codegen@sha256:gen1 换成 schema-codegen@sha256:gen2；没有生成结果回执。
- D：W 的参数 --mode release 变为 --mode debug，FEATURE_PROFILE 从 standard 变为 experiment；源文件和其他工具、参数全部不变。W 的输出摘要未知。
- E：只有 release-notes.md 从 r1 变成 r2；其他源文件、工具、参数和环境不变。

对于未知执行结果，可以给条件化后续计划。无需虚构新输出摘要。
