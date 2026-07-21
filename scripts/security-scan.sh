#!/usr/bin/env bash
set -eu
ROOT_DIR=${ROOT_DIR:-$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)}
. "$ROOT_DIR/runtime/lib/security.sh"

target=${1:-.}
scan_secrets "$target"
printf 'security scan passed: %s\n' "$target"
