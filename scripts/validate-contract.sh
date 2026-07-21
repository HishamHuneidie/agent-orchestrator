#!/usr/bin/env bash
set -eu
ROOT_DIR=${ROOT_DIR:-$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)}
. "$ROOT_DIR/runtime/lib/schema.sh"

[ "$#" -eq 1 ] || { printf 'usage: %s <contract-file>\n' "$0" >&2; exit 2; }
validate_contract "$1"
printf 'contract validation passed: %s\n' "$1"
