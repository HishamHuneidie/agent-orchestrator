# task-delivery

## Tipo

Stateful workflow definition for Codex or ClaudeCode when the user writes `$task {task_id}`. This workflow implements, reviews, validates and delivers one existing task.

## Estados de nodo

- `pending`
- `running`
- `waiting`
- `failed`
- `cancelled`
- `completed`

## Nodos

- `resolve_task`
- `load_brief`
- `pre_dispatch`
- `implementation`
- `review`
- `fix_or_approve`
- `test`
- `qa_verification`
- `delivery_summary`

## Reglas de ejecución

- `resolve_task` must select exactly one `tasks/**/{task_id}.yaml`.
- `load_brief` must load the brief referenced by the task before implementation starts.
- `pre_dispatch` must enforce security policy, permissions and worktree policy.
- `implementation` must stay within the selected task scope.
- `review` and `test` must run after implementation and before delivery.
- `fix_or_approve` may return to `implementation` only for findings inside the selected task scope.
- `delivery_summary` records changed files, validation evidence, risks and handoff status.
- Todo cambio de estado debe persistirse en `runtime/state/<feature-id>.yaml` cuando el cliente use estado persistente.

## Paralelismo

Only validation activities that do not mutate the same files may run in parallel. Implementation of a single task is sequential unless the task contract explicitly requires parallel worktrees.

## Recuperación y reanudación

The client may resume an incomplete task from its task contract, reports and runtime state. Completed tasks are not repeated unless the user explicitly asks for rework.

## Historial

Each node records selected artifacts, files changed, validation commands, results, retries, blockers and delivery decision.
