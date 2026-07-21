#!/usr/bin/env bash
set -eu
ROOT_DIR=${ROOT_DIR:-$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)}
. "$ROOT_DIR/runtime/lib/security.sh"

usage() {
  printf 'usage: %s <feature-id> <task-id> <agent> <skill-path> <brief-path> [context-path...]\n' "$0" >&2
}

[ "$#" -ge 5 ] || { usage; exit 2; }
feature_id=$1
task_id=$2
agent=$3
skill_path=$4
brief_path=$5
shift 5

agent_path="agents/$agent.md"
for path in "$agent_path" "$skill_path" "$brief_path" "$@"; do
  validate_path_allowed "$path"
  [ -f "$path" ] || { printf 'prompt builder input not found: %s\n' "$path" >&2; exit 1; }
done

out_dir="runtime/prompts/$feature_id"
mkdir -p "$out_dir"
out="$out_dir/$task_id.prompt.md"

{
  printf '# Subagent Prompt\n\n'
  printf 'feature_id: %s\n' "$feature_id"
  printf 'task_id: %s\n' "$task_id"
  printf 'agent: %s\n\n' "$agent"
  printf '## Brief\n\n'
  sed -n '1,220p' "$brief_path"
  printf '\n\n## Prompt Base Del Agente\n\n'
  sed -n '1,260p' "$agent_path"
  printf '\n\n## Skill\n\n'
  sed -n '1,220p' "$skill_path"
  printf '\n\n## Contexto\n\n'
  if [ "$#" -eq 0 ]; then
    printf 'No additional context provided.\n'
  else
    for ctx in "$@"; do
      printf '\n### %s\n\n' "$ctx"
      sed -n '1,180p' "$ctx"
    done
  fi
  printf '\n\n## Restricciones\n\n'
  printf -- '- No leer ni exponer secretos.\n- No escribir fuera de rutas permitidas.\n- Validar salidas contra schemas.\n'
} > "$out"

scan_secrets "$out"
printf '%s\n' "$out"
