#!/usr/bin/env bash
set -eu

ROOT_DIR=${ROOT_DIR:-$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)}
OBS_DIR="$ROOT_DIR/observability"
STATE_DIR="$ROOT_DIR/runtime/state"

now_utc() {
  date -u +"%Y-%m-%dT%H:%M:%SZ"
}

ensure_runtime_dirs() {
  mkdir -p "$OBS_DIR" "$STATE_DIR" "$ROOT_DIR/runtime/prompts" "$ROOT_DIR/reports" "$ROOT_DIR/tasks" "$ROOT_DIR/briefs"
}

json_escape() {
  printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'
}

log_event() {
  ensure_runtime_dirs
  event=$1
  feature_id=${2:-unknown}
  task_id=${3:-}
  status=${4:-info}
  message=${5:-}
  printf '{"ts":"%s","event":"%s","feature_id":"%s","task_id":"%s","status":"%s","message":"%s"}\n' \
    "$(now_utc)" "$(json_escape "$event")" "$(json_escape "$feature_id")" "$(json_escape "$task_id")" "$(json_escape "$status")" "$(json_escape "$message")" >> "$OBS_DIR/executions.jsonl"
}

log_error() {
  ensure_runtime_dirs
  feature_id=${1:-unknown}
  task_id=${2:-}
  code=${3:-error}
  message=${4:-}
  printf '{"ts":"%s","feature_id":"%s","task_id":"%s","code":"%s","message":"%s"}\n' \
    "$(now_utc)" "$(json_escape "$feature_id")" "$(json_escape "$task_id")" "$(json_escape "$code")" "$(json_escape "$message")" >> "$OBS_DIR/errors.jsonl"
}

fail() {
  printf '%s\n' "$1" >&2
  exit "${2:-1}"
}
