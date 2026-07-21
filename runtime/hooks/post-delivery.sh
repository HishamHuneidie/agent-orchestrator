#!/usr/bin/env bash
set -eu
ROOT_DIR=${ROOT_DIR:-$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)}
. "$ROOT_DIR/runtime/lib/common.sh"
. "$ROOT_DIR/runtime/lib/security.sh"

feature_id=${1:-}
[ -n "$feature_id" ] || fail "post-delivery: missing feature id" 2
scan_secrets "$ROOT_DIR/reports/$feature_id" || fail "post-delivery: secret detected in delivery artifacts" 1
log_event post_delivery "$feature_id" "" completed "delivery gate passed"
