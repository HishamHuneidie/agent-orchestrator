#!/usr/bin/env bash
set -eu
ROOT_DIR=${ROOT_DIR:-$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)}
. "$ROOT_DIR/runtime/lib/common.sh"
. "$ROOT_DIR/runtime/lib/schema.sh"
. "$ROOT_DIR/runtime/lib/security.sh"

task_file=${1:-}
[ -f "$task_file" ] || fail "pre-agent-dispatch: task file not found" 2
validate_path_allowed "$task_file"
validate_contract "$task_file"
scan_secrets "$task_file"
feature_id=$(grep -E '^feature_id:' "$task_file" | head -1 | cut -d: -f2- | xargs || true)
task_id=$(grep -E '^task_id:' "$task_file" | head -1 | cut -d: -f2- | xargs || true)
log_event pre_agent_dispatch "${feature_id:-unknown}" "${task_id:-unknown}" completed "task validated"
