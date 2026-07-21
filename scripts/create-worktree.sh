#!/usr/bin/env bash
set -eu

usage() {
  printf 'usage: %s <feature-id> <task-id> [base-ref]\n' "$0" >&2
}

if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
  usage
  exit 2
fi

feature_id=$1
task_id=$2
base_ref=${3:-HEAD}
path="worktrees/$feature_id/$task_id"
branch="agent/$feature_id/$task_id"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  printf 'cannot create worktree: this directory is not a valid Git worktree\n' >&2
  exit 1
fi

if [ -e "$path" ]; then
  printf 'cannot create worktree: path already exists: %s\n' "$path" >&2
  exit 1
fi

if git show-ref --verify --quiet "refs/heads/$branch"; then
  printf 'cannot create worktree: branch already exists: %s\n' "$branch" >&2
  exit 1
fi

mkdir -p "worktrees/$feature_id"
git worktree add -b "$branch" "$path" "$base_ref"
printf 'created worktree %s on branch %s\n' "$path" "$branch"
