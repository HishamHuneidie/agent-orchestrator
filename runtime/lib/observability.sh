#!/usr/bin/env bash
set -eu

record_metric() {
  mkdir -p "$ROOT_DIR/observability"
  feature_id=${1:-unknown}
  task_id=${2:-}
  agent=${3:-unknown}
  model=${4:-unknown}
  duration_ms=${5:-0}
  result=${6:-unknown}
  tokens=${7:-0}
  cost=${8:-0}
  printf '{"ts":"%s","feature_id":"%s","task_id":"%s","agent":"%s","model":"%s","duration_ms":%s,"result":"%s","tokens":%s,"cost":%s}\n' \
    "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" "$feature_id" "$task_id" "$agent" "$model" "$duration_ms" "$result" "$tokens" "$cost" >> "$ROOT_DIR/observability/metrics.jsonl"
}
