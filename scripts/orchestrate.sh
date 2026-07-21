#!/usr/bin/env bash
set -eu

request=${1:-templates/feature-request.yaml}

if [ ! -f "$request" ]; then
  printf 'feature request not found: %s\n' "$request" >&2
  printf 'start from templates/feature-request.yaml\n' >&2
  exit 1
fi

scripts/validate-structure.sh

cat <<EOF
manual orchestration v1

input:
  feature_request: $request

flow:
  1. hooks/pre-orchestration.md
  2. skills/feature-from-docs/SKILL.md
  3. skills/estimation/SKILL.md
  4. templates/execution-plan.yaml
  5. skills/agent-routing/SKILL.md
  6. hooks/pre-agent-dispatch.md
  7. skills/implementation-execution/SKILL.md
  8. workflows/review-and-test.md
  9. templates/delivery-summary.md

note: v1 prints and validates the expected flow; it does not invoke agents automatically.
EOF
