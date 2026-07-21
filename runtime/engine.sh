#!/usr/bin/env bash
set -eu
ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
export ROOT_DIR
. "$ROOT_DIR/runtime/lib/common.sh"

usage() {
  cat <<'EOF'
usage:
  orchestrator
  orchestrator init-client
  orchestrator validate
EOF
}

ensure_runtime_dirs

cmd=${1:-init-client}
case "$cmd" in
  init-client)
    cat "$ROOT_DIR/docs/ai-client-orchestration.md"
    ;;
  validate)
    "$ROOT_DIR/scripts/validate-structure.sh"
    ;;
  *)
    usage
    exit 2
    ;;
esac
