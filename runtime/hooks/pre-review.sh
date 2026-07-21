#!/usr/bin/env bash
set -eu
ROOT_DIR=${ROOT_DIR:-$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)}
. "$ROOT_DIR/runtime/lib/common.sh"
. "$ROOT_DIR/runtime/lib/security.sh"

feature_id=${1:-}
[ -n "$feature_id" ] || fail "pre-review: missing feature id" 2
scan_secrets "$ROOT_DIR/reports" || fail "pre-review: secret detected in reports" 1
log_event pre_review "$feature_id" "" completed "review inputs accepted"
