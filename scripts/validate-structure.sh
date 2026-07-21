#!/usr/bin/env bash
set -u

missing=0

require_file() {
  if [ ! -f "$1" ]; then
    printf 'missing file: %s\n' "$1" >&2
    missing=1
  fi
}

require_dir() {
  if [ ! -d "$1" ]; then
    printf 'missing directory: %s\n' "$1" >&2
    missing=1
  fi
}

for dir in agents briefs contracts docs docs/diagrams hooks observability reports runtime runtime/hooks runtime/lib runtime/prompts runtime/state schemas scripts skills tasks templates workflows; do
  require_dir "$dir"
done

require_file README.md
require_file orchestrator.yaml
require_file orchestrator
require_file tree.example

for file in \
  agents/backend-engineer.md \
  agents/code-reviewer.md \
  agents/delivery-summarizer.md \
  agents/e2e-test-engineer.md \
  agents/estimator.md \
  agents/feature-analyst.md \
  agents/frontend-engineer.md \
  agents/fullstack-engineer.md \
  agents/implementation-planner.md \
  agents/orchestrator.md \
  agents/qa-verifier.md \
  agents/unit-test-engineer.md \
  docs/agent-lifecycle.md \
  docs/architecture.md \
  docs/architecture-refactor-report.md \
  docs/diagrams/agent-interactions.md \
  docs/diagrams/execution-flow.md \
  docs/diagrams/prompt-builder.md \
  docs/observability.md \
  docs/operating-manual.md \
  docs/prompt-builder.md \
  docs/security.md \
  docs/workflow-engine.md \
  docs/worktree-strategy.md \
  hooks/post-agent-dispatch.md \
  hooks/post-delivery.md \
  hooks/pre-agent-dispatch.md \
  hooks/pre-orchestration.md \
  hooks/pre-review.md \
  hooks/pre-test.md \
  schemas/agent-task.schema.yaml \
  schemas/brief.schema.yaml \
  schemas/delivery-summary.schema.yaml \
  schemas/execution-plan.schema.yaml \
  schemas/feature-request.schema.yaml \
  schemas/observability-event.schema.yaml \
  schemas/prompt.schema.yaml \
  schemas/review-report.schema.yaml \
  schemas/test-report.schema.yaml \
  schemas/workflow-state.schema.yaml \
  runtime/engine.sh \
  runtime/hooks/post-agent-dispatch.sh \
  runtime/hooks/post-delivery.sh \
  runtime/hooks/pre-agent-dispatch.sh \
  runtime/hooks/pre-orchestration.sh \
  runtime/hooks/pre-review.sh \
  runtime/hooks/pre-test.sh \
  runtime/lib/common.sh \
  runtime/lib/observability.sh \
  runtime/lib/schema.sh \
  runtime/lib/security.sh \
  scripts/build-prompt.sh \
  scripts/cleanup-worktree.sh \
  scripts/create-worktree.sh \
  scripts/orchestrate.sh \
  scripts/security-scan.sh \
  scripts/validate-contract.sh \
  scripts/validate-structure.sh \
  skills/agent-routing/SKILL.md \
  skills/code-review/SKILL.md \
  skills/delivery-summary/SKILL.md \
  skills/estimation/SKILL.md \
  skills/feature-from-docs/SKILL.md \
  skills/implementation-execution/SKILL.md \
  skills/parallel-worktrees/SKILL.md \
  skills/test-validation/SKILL.md \
  templates/agent-task.yaml \
  templates/backend-brief.yaml \
  templates/brief.yaml \
  templates/delivery-summary.md \
  templates/execution-plan.yaml \
  templates/feature-request.yaml \
  templates/frontend-brief.yaml \
  templates/prompt.md \
  templates/qa-brief.yaml \
  templates/review-brief.yaml \
  templates/review-report.md \
  templates/task.yaml \
  templates/test-report.md \
  templates/workflow-state.yaml \
  workflows/application-feature.md \
  workflows/delivery-summary.md \
  workflows/parallel-implementation.md \
  workflows/review-and-test.md; do
  require_file "$file"
done

for file in agents/*.md; do
  for section in \
    "## Propósito" \
    "## Responsabilidades" \
    "## No responsabilidades" \
    "## Capacidades" \
    "## Limitaciones" \
    "## Inputs obligatorios" \
    "## Inputs opcionales" \
    "## Outputs" \
    "## Dependencias" \
    "## Herramientas permitidas" \
    "## Herramientas prohibidas" \
    "## Archivos que puede leer" \
    "## Archivos que puede modificar" \
    "## Archivos restringidos" \
    "## Archivos completamente prohibidos" \
    "## Modelo de IA" \
    "## Flujo interno de ejecución" \
    "## Checklist de ejecución" \
    "## Checklist de calidad" \
    "## Criterios de éxito" \
    "## Criterios de fallo" \
    "## Casos límite" \
    "## Estrategia de recuperación ante errores" \
    "## Estrategia de handoff" \
    "## Métricas esperadas"; do
    if ! grep -Fq "$section" "$file"; then
      printf 'agent contract missing section: %s in %s\n' "$section" "$file" >&2
      missing=1
    fi
  done
done

for file in skills/*/SKILL.md; do
  for section in "## Trigger" "## Parameters" "## Inputs" "## Procedure" "## Expected Result" "## Quality Gates"; do
    if ! grep -Fq "$section" "$file"; then
      printf 'skill contract missing section: %s in %s\n' "$section" "$file" >&2
      missing=1
    fi
  done
done

for file in hooks/*.md; do
  for section in "## Momento de ejecución" "## Objetivo" "## Entradas" "## Salidas" "## Posibles errores" "## Componente ejecutable"; do
    if ! grep -Fq "$section" "$file"; then
      printf 'hook contract missing section: %s in %s\n' "$section" "$file" >&2
      missing=1
    fi
  done
done

if [ "$missing" -ne 0 ]; then
  printf 'structure validation failed\n' >&2
  exit 1
fi

printf 'structure validation passed\n'
