#!/usr/bin/env bash
set -eu
ROOT_DIR=${ROOT_DIR:-$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)}
. "$ROOT_DIR/runtime/lib/common.sh"

feature_id=${1:-}
[ -n "$feature_id" ] || fail "pre-test: missing feature id" 2
scripts/validate-structure.sh >/dev/null
log_event pre_test "$feature_id" "" completed "test preconditions accepted"
