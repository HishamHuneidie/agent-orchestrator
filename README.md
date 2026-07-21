# Agent Orchestrator

Sistema portable de orquestacion de agentes para convertir documentacion de producto en features implementables, planes de ejecucion, tareas asignables, revisiones, pruebas y resumen de entrega.

La version actual conserva la filosofia Markdown/YAML/shell, pero mueve la orquestacion efectiva al cliente de IA activo: El CLI queda como utilidad de soporte para bootstrap y validacion.

## Flujo Principal

1. Escribir `$feat {feature_name}` en el cliente de IA para leer `docs/features/{feature_name}/`.
2. Extraer alcance, criterios de aceptacion, restricciones, riesgos y fuera de alcance.
3. Estimar complejidad, dependencias y tiempos.
4. Crear briefs, plan de ejecucion y contratos de tarea sin implementar codigo.
5. Escribir `$task {task_id}` para implementar una tarea planificada.
6. Revisar codigo, ejecutar pruebas unitarias, e2e y QA.
7. Cerrar con `templates/delivery-summary.md`.

## Uso Rapido

```sh
scripts/validate-structure.sh
scripts/orchestrate.sh templates/feature-request.yaml
```

Bootstrap para clientes IA:

```sh
./orchestrator validate
./orchestrator init-client
```

Despues de abrir el repositorio en el cliente de IA, cargar `AGENTS.md`, las skills de `./skills` y el workflow aplicable de `./workflows`. Una peticion como `implementa esta feature` debe activar `skills/application-feature-orchestration/SKILL.md` y `workflows/application-feature.md`.

Atajos principales dentro del cliente IA:

```text
$feat feature-login
$task backend-auth-endpoint
```

La ejecucion de workflows ocurre dentro del cliente IA.

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
