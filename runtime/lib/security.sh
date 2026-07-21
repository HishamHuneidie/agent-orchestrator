#!/usr/bin/env bash
set -eu

is_denied_path() {
  path=$1
  case "$path" in
    .env|*.env|*/.env|*/.env.*|*secret*|*token*|*credential*|*.pem|*.key|*.p12|*.crt|*id_rsa*|*id_ed25519*|.git/*|.agents/*|.codex/*)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

validate_path_allowed() {
  path=$1
  if is_denied_path "$path"; then
    printf 'security violation: denied path: %s\n' "$path" >&2
    return 1
  fi
}

scan_secrets() {
  target=${1:-.}
  if [ ! -e "$target" ]; then
    return 0
  fi
  if is_denied_path "$target"; then
    printf 'secret scan blocked denied path: %s\n' "$target" >&2
    return 1
  fi
  if command -v rg >/dev/null 2>&1; then
    if rg -n --hidden --glob '!.git/**' --glob '!.agents/**' --glob '!.codex/**' --glob '!orchestrator.yaml' --glob '!**/.env*' --glob '!**/*.key' --glob '!**/*.pem' \
      'AKIA[0-9A-Z]{16}|-----BEGIN (RSA |OPENSSH |EC |DSA )?PRIVATE KEY-----|(?i)(api[_-]?key|secret|token|password)\s*[:=]\s*['\''"]?[A-Za-z0-9_./+=-]{12,}' "$target" >/tmp/orchestrator-secret-scan.txt 2>/dev/null; then
      cat /tmp/orchestrator-secret-scan.txt >&2
      printf 'secret scan failed\n' >&2
      return 1
    fi
  fi
  return 0
}
