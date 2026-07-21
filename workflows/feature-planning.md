# feature-planning

## Tipo

Stateful workflow definition for Codex or ClaudeCode when the user writes `$feat {feature_name}`. This workflow prepares a feature for implementation but does not implement it.

## Estados de nodo

- `pending`
- `running`
- `waiting`
- `failed`
- `cancelled`
- `completed`

## Nodos

- `resolve_feature_docs`
- `feature_analysis`
- `brief_creation`
- `estimation`
- `planning`
- `routing`
- `task_contracts`
- `planning_summary`

## Reglas de ejecución

- `resolve_feature_docs` must resolve `docs/features/{feature_name}/README.md`.
- `feature_analysis` reads only relevant non-secret files under the feature documentation directory.
- `brief_creation` writes the implementation brief before task contracts are finalized.
- `estimation` must record effort, risk and dependencies for each task.
- `planning` and `routing` must assign agents and validation commands without implementing code.
- `task_contracts` writes one task contract per implementation task.
- `planning_summary` reports generated artifacts and suggested `$task {task_id}` commands.
- Todo cambio de estado debe persistirse en `runtime/state/<feature-id>.yaml` cuando el cliente use estado persistente.

## Paralelismo

Planning is sequential by default. The workflow may propose parallel implementation tasks, but it must not start them.

## Recuperación y reanudación

The client may resume from existing artifacts if they match the active `feature_id`. Incomplete or stale artifacts must be reported before overwriting them.

## Historial

Each node records input docs, generated artifacts, assumptions, estimation evidence and blockers.
