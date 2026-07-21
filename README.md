# Agent Orchestrator

Sistema portable de orquestacion de agentes para convertir documentacion de producto en features implementables, planes de ejecucion, tareas asignables, revisiones, pruebas y resumen de entrega.

La version actual conserva la filosofia Markdown/YAML/shell, pero agrega runtime CLI, hooks ejecutables, seguridad, observabilidad, schemas versionados, Task como entidad principal, briefs estandarizados y Prompt Builder.

## Flujo Principal

1. Leer documentacion fuente y completar `templates/feature-request.yaml`.
2. Extraer features, criterios de aceptacion, restricciones y fuera de alcance.
3. Estimar complejidad, riesgo, dependencias y tamano.
4. Crear `templates/execution-plan.yaml` para fases, tareas, agentes y validaciones.
5. Seleccionar agentes desde `agents/` usando `skills/agent-routing/SKILL.md`.
6. Decidir uso de worktrees segun riesgo y paralelismo.
7. Ejecutar implementacion con contratos de tarea.
8. Revisar codigo, ejecutar pruebas unitarias, e2e y QA.
9. Cerrar con `templates/delivery-summary.md`.

## Uso Rapido

```sh
scripts/validate-structure.sh
scripts/orchestrate.sh templates/feature-request.yaml
```

Runtime v2:

```sh
./orchestrator validate
./orchestrator run FEATURE_ID
./orchestrator task FEATURE_ID TASK_ID
```

Prompt Builder:

```sh
./orchestrator build-prompt FEATURE_ID TASK_ID fullstack-engineer skills/implementation-execution/SKILL.md templates/brief.yaml docs/architecture.md
```

Para una tarea paralela con worktree:

```sh
scripts/create-worktree.sh feature-login backend-api
```

La limpieza de worktrees es explicita:

```sh
scripts/cleanup-worktree.sh feature-login backend-api
```

## Politica de Worktrees

- No usar worktree para documentacion, estimacion o tareas secuenciales pequenas.
- Usar worktree obligatorio para implementadores en paralelo.
- Usar worktree recomendado para cambios grandes, migraciones, refactors o alto riesgo de conflicto.
- Fallar con mensaje claro cuando Git no este inicializado correctamente.

## Estructura

- `orchestrator.yaml`: configuracion central.
- `agents/`: perfiles de agentes.
- `skills/`: procedimientos reutilizables.
- `hooks/`: puntos de control del proceso.
- `workflows/`: secuencias completas.
- `schemas/`: contratos YAML.
- `templates/`: archivos rellenables para operacion manual.
- `scripts/`: validacion y utilidades de worktree.
- `runtime/`: motor CLI, hooks ejecutables, librerias, prompts y estado.
- `observability/`: eventos, metricas y errores en JSONL.
- `briefs/`, `tasks/`, `reports/`: artefactos principales de ejecucion.

## Arquitectura Profesional

El informe completo esta en `docs/architecture-refactor-report.md`.
