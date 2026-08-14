#!/bin/sh

set -u

PROGRAM=${0##*/}

fail() {
  printf '%s\n' "$PROGRAM: $*" >&2
  exit 1
}

command -v dirname >/dev/null 2>&1 || fail "缺少必需命令：dirname"
command -v git >/dev/null 2>&1 || fail "缺少必需命令：git"

SCRIPT_DIR=$(CDPATH= cd "$(dirname "$0")" 2>/dev/null && pwd -P) ||
  fail "无法定位脚本目录"
REPO_ROOT=$(CDPATH= cd "$SCRIPT_DIR/.." 2>/dev/null && pwd -P) ||
  fail "无法定位仓库根目录"

git_root=$(git -C "$REPO_ROOT" rev-parse --show-toplevel 2>/dev/null) ||
  fail "脚本所在目录不是 Git 工作树：$REPO_ROOT"
git_root=$(CDPATH= cd "$git_root" 2>/dev/null && pwd -P) ||
  fail "无法定位 Git 工作树根目录：$git_root"
[ "$git_root" = "$REPO_ROOT" ] ||
  fail "脚本必须位于仓库根目录的 scripts/ 中：$REPO_ROOT"

if ! dirty_state=$(git -C "$REPO_ROOT" status --porcelain --untracked-files=all); then
  fail "无法检查 Git 工作树状态：$REPO_ROOT"
fi
[ -z "$dirty_state" ] || {
  printf '%s\n' "$dirty_state" >&2
  fail "仓库存在 tracked、staged 或 untracked 变更，拒绝更新"
}

git -C "$REPO_ROOT" pull --ff-only ||
  fail "git pull --ff-only 失败；仓库未安装"

[ -f "$REPO_ROOT/scripts/install.sh" ] ||
  fail "更新后的仓库缺少安装脚本：$REPO_ROOT/scripts/install.sh"

sh "$REPO_ROOT/scripts/install.sh" ||
  fail "仓库已快进更新，但安装失败"
