#!/usr/bin/env bash
set -eu
ROOT_DIR=${ROOT_DIR:-$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)}
. "$ROOT_DIR/runtime/lib/common.sh"
. "$ROOT_DIR/runtime/lib/security.sh"

feature_id=${1:-}
[ -n "$feature_id" ] || fail "pre-orchestration: missing feature id" 2
scripts/validate-structure.sh >/dev/null
scan_secrets "$ROOT_DIR"
log_event pre_orchestration "$feature_id" "" completed "structure and secret scan passed"
