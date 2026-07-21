#!/usr/bin/env bash
set -eu

usage() {
  printf 'usage: %s <feature-id> <task-id> [--delete-branch]\n' "$0" >&2
}

if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
  usage
  exit 2
fi

feature_id=$1
task_id=$2
delete_branch=${3:-}
path="worktrees/$feature_id/$task_id"
branch="agent/$feature_id/$task_id"

if [ "$delete_branch" != "" ] && [ "$delete_branch" != "--delete-branch" ]; then
  usage
  exit 2
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  printf 'cannot clean worktree: this directory is not a valid Git worktree\n' >&2
  exit 1
fi

if [ ! -d "$path" ]; then
  printf 'cannot clean worktree: path does not exist: %s\n' "$path" >&2
  exit 1
fi

git worktree remove "$path"

if [ "$delete_branch" = "--delete-branch" ]; then
  git branch -d "$branch"
fi

printf 'removed worktree %s\n' "$path"
