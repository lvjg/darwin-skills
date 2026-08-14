#!/bin/sh

set -u
umask 077

PROGRAM=${0##*/}

say_error() {
  printf '%s\n' "$PROGRAM: $*" >&2
}

fail() {
  say_error "$*"
  exit 1
}

path_exists() {
  [ -e "$1" ] || [ -L "$1" ]
}

SCRIPT_DIR=$(CDPATH= cd "$(dirname "$0")" 2>/dev/null && pwd -P) ||
  fail "无法定位脚本目录"
REPO_ROOT=$(CDPATH= cd "$SCRIPT_DIR/.." 2>/dev/null && pwd -P) ||
  fail "无法定位仓库根目录"

CODEX_SOURCE=$REPO_ROOT/codex/AGENTS.md
SKILLS_SOURCE=$REPO_ROOT/skills
SKILL_NAMES='plan-to-delivery system-overview-design plan-review delivery-review code-cleanup'

for command_name in cmp cp dirname find mkdir mktemp mv pwd rm sort; do
  command -v "$command_name" >/dev/null 2>&1 ||
    fail "缺少必需命令：$command_name"
done

[ -f "$CODEX_SOURCE" ] && [ -r "$CODEX_SOURCE" ] ||
  fail "仓库源文件缺失或不可读：$CODEX_SOURCE"

for skill_name in $SKILL_NAMES; do
  skill_source=$SKILLS_SOURCE/$skill_name
  [ -d "$skill_source" ] && [ -r "$skill_source" ] ||
    fail "仓库 Skill 源目录缺失或不可读：$skill_source"

  for required_skill_file in SKILL.md agents/openai.yaml; do
    [ -f "$skill_source/$required_skill_file" ] &&
      [ -r "$skill_source/$required_skill_file" ] ||
      fail "仓库 Skill 必需源文件缺失或不可读：$skill_source/$required_skill_file"
  done

  if [ "$skill_name" = system-overview-design ]; then
    [ -f "$skill_source/references/overview-standard.md" ] &&
      [ -r "$skill_source/references/overview-standard.md" ] ||
      fail "仓库 Skill 必需源文件缺失或不可读：$skill_source/references/overview-standard.md"
  fi

  unsupported=$(find "$skill_source" ! -type d ! -type f -print 2>/dev/null) ||
    fail "无法检查仓库 Skill 源目录：$skill_source"
  [ -z "$unsupported" ] ||
    fail "仓库 Skill 源目录包含不支持的特殊文件：$skill_source"

  unreadable=$(find "$skill_source" -type f ! -exec test -r '{}' \; -print 2>/dev/null) ||
    fail "无法检查仓库 Skill 源文件：$skill_source"
  [ -z "$unreadable" ] ||
    fail "仓库 Skill 源目录包含不可读文件：$skill_source"
done

[ -n "${HOME:-}" ] || fail "HOME 未设置"
[ -d "$HOME" ] || fail "HOME 不是目录：$HOME"

CODEX_PARENT=$HOME/.codex
SKILLS_PARENT=$HOME/.agents/skills

mkdir -p "$CODEX_PARENT" || fail "无法创建目标父目录：$CODEX_PARENT"
mkdir -p "$SKILLS_PARENT" || fail "无法创建目标父目录：$SKILLS_PARENT"

for target_parent in "$CODEX_PARENT" "$SKILLS_PARENT"; do
  [ -d "$target_parent" ] || fail "目标父路径不是目录：$target_parent"
  [ -w "$target_parent" ] && [ -x "$target_parent" ] ||
    fail "目标父目录不可写：$target_parent"
done

CODEX_WORK=
SKILLS_WORK=
PRESERVE_CODEX_WORK=0
PRESERVE_SKILLS_WORK=0

cleanup() {
  cleanup_status=$?
  cleanup_failed=0
  trap - 0 HUP INT TERM

  if [ -n "$CODEX_WORK" ] && [ "$PRESERVE_CODEX_WORK" -eq 0 ]; then
    if ! rm -rf "$CODEX_WORK"; then
      say_error "无法清理临时目录：$CODEX_WORK"
      cleanup_failed=1
    fi
  fi

  if [ -n "$SKILLS_WORK" ] && [ "$PRESERVE_SKILLS_WORK" -eq 0 ]; then
    if ! rm -rf "$SKILLS_WORK"; then
      say_error "无法清理临时目录：$SKILLS_WORK"
      cleanup_failed=1
    fi
  fi

  if [ "$cleanup_status" -eq 0 ] && [ "$cleanup_failed" -ne 0 ]; then
    cleanup_status=1
  fi
  exit "$cleanup_status"
}

trap cleanup 0
trap 'exit 129' HUP
trap 'exit 130' INT
trap 'exit 143' TERM

CODEX_WORK=$(mktemp -d "$CODEX_PARENT/.skills-install.XXXXXX") ||
  fail "无法在目标父目录创建暂存目录：$CODEX_PARENT"
SKILLS_WORK=$(mktemp -d "$SKILLS_PARENT/.skills-install.XXXXXX") ||
  fail "无法在目标父目录创建暂存目录：$SKILLS_PARENT"

verify_tree() {
  verify_source=$1
  verify_stage=$2
  verify_prefix=$3
  verify_source_list=$verify_prefix.source-list
  verify_stage_list=$verify_prefix.stage-list

  (CDPATH= cd "$verify_source" && find . -print | LC_ALL=C sort) >"$verify_source_list" ||
    return 1
  (CDPATH= cd "$verify_stage" && find . -print | LC_ALL=C sort) >"$verify_stage_list" ||
    return 1
  cmp -s "$verify_source_list" "$verify_stage_list" || return 1

  while IFS= read -r verify_relative || [ -n "$verify_relative" ]; do
    [ "$verify_relative" = . ] && continue
    if [ -d "$verify_source/$verify_relative" ]; then
      [ -d "$verify_stage/$verify_relative" ] || return 1
    elif [ -f "$verify_source/$verify_relative" ]; then
      [ -f "$verify_stage/$verify_relative" ] || return 1
      cmp -s "$verify_source/$verify_relative" "$verify_stage/$verify_relative" ||
        return 1
    else
      return 1
    fi
  done <"$verify_source_list"
}

CODEX_STAGE=$CODEX_WORK/AGENTS.md.stage
CODEX_BACKUP=$CODEX_WORK/AGENTS.md.backup

cp "$CODEX_SOURCE" "$CODEX_STAGE" ||
  fail "暂存复制失败：$CODEX_SOURCE"
cmp -s "$CODEX_SOURCE" "$CODEX_STAGE" ||
  fail "暂存字节验证失败：$CODEX_SOURCE"

for skill_name in $SKILL_NAMES; do
  skill_source=$SKILLS_SOURCE/$skill_name
  skill_stage=$SKILLS_WORK/$skill_name.stage
  mkdir "$skill_stage" || fail "无法创建 Skill 暂存目录：$skill_stage"
  cp -R "$skill_source/." "$skill_stage/" ||
    fail "暂存复制失败：$skill_source"
  verify_tree "$skill_source" "$skill_stage" "$SKILLS_WORK/$skill_name" ||
    fail "暂存树验证失败：$skill_source"
done

mark_preserved_backup() {
  preserved_backup=$1
  case $preserved_backup in
    "$CODEX_WORK"/*) PRESERVE_CODEX_WORK=1 ;;
    "$SKILLS_WORK"/*) PRESERVE_SKILLS_WORK=1 ;;
  esac
}

replace_target() {
  target_label=$1
  target_stage=$2
  target_path=$3
  target_backup=$4
  target_had_old=0

  if path_exists "$target_path"; then
    target_had_old=1
    if ! mv "$target_path" "$target_backup"; then
      say_error "替换失败，无法备份目标：$target_path"
      return 1
    fi
  fi

  if mv "$target_stage" "$target_path"; then
    if [ "$target_had_old" -eq 1 ] && ! rm -rf "$target_backup"; then
      mark_preserved_backup "$target_backup"
      say_error "目标已安装，但旧备份清理失败：$target_path"
      say_error "保留的旧备份：$target_backup"
      return 1
    fi
    printf '%s\n' "已安装：$target_label -> $target_path"
    return 0
  fi

  say_error "替换失败：$target_path"
  if [ "$target_had_old" -eq 1 ]; then
    if mv "$target_backup" "$target_path"; then
      say_error "已恢复原目标：$target_path"
    else
      mark_preserved_backup "$target_backup"
      say_error "回滚失败：$target_path"
      say_error "可恢复备份已保留：$target_backup"
    fi
  fi
  return 1
}

replace_target "Codex AGENTS.md" "$CODEX_STAGE" "$CODEX_PARENT/AGENTS.md" "$CODEX_BACKUP" ||
  exit 1

for skill_name in $SKILL_NAMES; do
  replace_target \
    "Skill $skill_name" \
    "$SKILLS_WORK/$skill_name.stage" \
    "$SKILLS_PARENT/$skill_name" \
    "$SKILLS_WORK/$skill_name.backup" || exit 1
done

printf '%s\n' '安装完成：6 个目标均已更新。'
