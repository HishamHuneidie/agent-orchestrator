#!/usr/bin/env bash
set -eu

require_yaml_key() {
  file=$1
  key=$2
  if ! grep -Eq "^${key}:" "$file"; then
    printf 'schema validation failed: %s missing key %s\n' "$file" "$key" >&2
    return 1
  fi
}

validate_contract() {
  file=$1
  case "$file" in
    *feature-request*.yaml)
      require_yaml_key "$file" feature_id
      require_yaml_key "$file" objective
      require_yaml_key "$file" acceptance_criteria
      ;;
    *execution-plan*.yaml)
      require_yaml_key "$file" feature_id
      require_yaml_key "$file" phases
      require_yaml_key "$file" tasks
      ;;
    *agent-task*.yaml|*/tasks/*.yaml)
      require_yaml_key "$file" task_id
      require_yaml_key "$file" assigned_agent
      require_yaml_key "$file" success_criteria
      ;;
    *brief*.yaml)
      require_yaml_key "$file" objective
      require_yaml_key "$file" scope
      require_yaml_key "$file" acceptance_criteria
      require_yaml_key "$file" definition_of_done
      ;;
    *)
      return 0
      ;;
  esac
}
