#!/usr/bin/env bash
set -eu
ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
export ROOT_DIR
. "$ROOT_DIR/runtime/lib/common.sh"
. "$ROOT_DIR/runtime/lib/observability.sh"

usage() {
  cat <<'EOF'
usage:
  orchestrator run <feature-id>
  orchestrator task <feature-id> [task-id]
  orchestrator build-prompt <feature-id> <task-id> <agent> <skill-path> <brief-path>
  orchestrator validate
EOF
}

ensure_runtime_dirs

cmd=${1:-}
case "$cmd" in
  run)
    feature_id=${2:-}
    [ -n "$feature_id" ] || { usage; exit 2; }
    start=$(date +%s)
    "$ROOT_DIR/runtime/hooks/pre-orchestration.sh" "$feature_id"
    mkdir -p "$ROOT_DIR/tasks/$feature_id" "$ROOT_DIR/briefs/$feature_id" "$ROOT_DIR/reports/$feature_id"
    state="$ROOT_DIR/runtime/state/$feature_id.yaml"
    if [ ! -f "$state" ]; then
      sed "s/{{feature_id}}/$feature_id/g; s/{{created_at}}/$(date -u +"%Y-%m-%dT%H:%M:%SZ")/g" "$ROOT_DIR/templates/workflow-state.yaml" > "$state"
    fi
    log_event workflow_run "$feature_id" "" completed "runtime initialized; automatic agent API execution is intentionally deferred"
    duration=$(( ($(date +%s) - start) * 1000 ))
    record_metric "$feature_id" "" orchestrator gpt-5 "$duration" completed 0 0
    printf 'orchestrator run initialized feature %s\nstate: %s\n' "$feature_id" "$state"
    ;;
  task)
    feature_id=${2:-}
    task_id=${3:-default-task}
    [ -n "$feature_id" ] || { usage; exit 2; }
    mkdir -p "$ROOT_DIR/tasks/$feature_id"
    task_file="$ROOT_DIR/tasks/$feature_id/$task_id.yaml"
    if [ ! -f "$task_file" ]; then
      sed "s/{{feature_id}}/$feature_id/g; s/{{task_id}}/$task_id/g; s/{{created_at}}/$(date -u +"%Y-%m-%dT%H:%M:%SZ")/g" "$ROOT_DIR/templates/task.yaml" > "$task_file"
    fi
    "$ROOT_DIR/runtime/hooks/pre-agent-dispatch.sh" "$task_file"
    log_event task_invoked "$feature_id" "$task_id" waiting "task entity prepared; engine invocation complete"
    printf 'task prepared: %s\n' "$task_file"
    ;;
  build-prompt)
    shift
    "$ROOT_DIR/scripts/build-prompt.sh" "$@"
    ;;
  validate)
    "$ROOT_DIR/scripts/validate-structure.sh"
    ;;
  *)
    usage
    exit 2
    ;;
esac
