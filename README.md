# Codex 全局配置与 Skills 快照

这个仓库保存一组可直接安装的 Codex 全局配置快照。Git 仓库中的内容是发布快照的权威版本；制作快照时读取的本机全局文件不是安装时的数据源。

## 快照范围

仓库只管理以下 6 个安装目标：

- `~/.codex/AGENTS.md`
- `~/.agents/skills/plan-to-delivery`
- `~/.agents/skills/system-overview-design`
- `~/.agents/skills/plan-review`
- `~/.agents/skills/delivery-review`
- `~/.agents/skills/code-cleanup`

其中实际技能名是 `system-overview-design`。

目录结构：

```text
.
├── README.md
├── codex/
│   └── AGENTS.md
├── scripts/
│   ├── install.sh
│   └── update.sh
└── skills/
    ├── code-cleanup/
    ├── delivery-review/
    ├── plan-review/
    ├── plan-to-delivery/
    └── system-overview-design/
```

安装采用精确替换，不合并文件。每次安装都会覆盖上述 6 个目标中的全部本地编辑；`~/.agents/skills` 下的其他技能不受影响。

## 安装

默认安装到 `~/.local/share/codex-global-skills`。下面是一条可直接复制、对含空格路径安全的命令：

```sh
repo_dir="$HOME/.local/share/codex-global-skills"; mkdir -p "$(dirname "$repo_dir")" && git clone https://github.com/lvjg/skills.git "$repo_dir" && sh "$repo_dir/scripts/install.sh"
```

自定义 clone 路径：

```sh
repo_dir="/path/with spaces/codex skills"; mkdir -p "$(dirname "$repo_dir")" && git clone https://github.com/lvjg/skills.git "$repo_dir" && sh "$repo_dir/scripts/install.sh"
```

安装脚本会先检查全部仓库源和目标父目录，在每个目标所在文件系统中完成暂存复制与逐字节验证，然后才逐个替换目标。每个目标单独回滚；6 个目标不构成跨目标事务。如果某个目标失败，脚本会以非零状态退出并指出该目标，可以修复原因后安全重跑。

## 更新已有 clone

使用默认 clone 路径：

```sh
sh "$HOME/.local/share/codex-global-skills/scripts/update.sh"
```

使用自定义 clone 路径：

```sh
sh "/path/with spaces/codex skills/scripts/update.sh"
```

`update.sh` 只接受完全干净的 Git 工作树，包括 tracked、staged 和 untracked 状态；它只执行 `git pull --ff-only`，成功后调用安装脚本。网络错误、分叉、Git 错误或安装失败都会以非零状态退出。

## 回退到旧快照

在已有 clone 中 checkout 所需的旧提交，再重新安装：

```sh
repo_dir="/path/with spaces/codex skills"; git -C "$repo_dir" checkout <commit> && sh "$repo_dir/scripts/install.sh"
```

如需恢复到最新分支，之后显式 checkout 对应分支并运行 `update.sh`。

## 运行边界

- 支持 macOS 或 Linux、POSIX `sh`、Git，以及系统常见的标准命令行工具。
- 安装按文件内容精确复制；不承诺保留或管理 ACL、扩展属性（xattr）等平台元数据。
- 不支持原生 Windows shell。可在满足上述工具和路径语义的兼容环境中自行验证。
