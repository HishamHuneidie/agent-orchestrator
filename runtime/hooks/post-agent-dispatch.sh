#!/usr/bin/env bash
set -eu
ROOT_DIR=${ROOT_DIR:-$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)}
. "$ROOT_DIR/runtime/lib/common.sh"

feature_id=${1:-unknown}
task_id=${2:-unknown}
status=${3:-completed}
log_event post_agent_dispatch "$feature_id" "$task_id" "$status" "agent dispatch captured"
