# review-and-test

## Tipo

Stateful workflow definition for the orchestrator runtime.

## Estados de nodo

- `pending`
- `running`
- `waiting`
- `failed`
- `cancelled`
- `completed`

## Nodos

- `pre_review`
- `code_review`
- `fix_or_approve`
- `pre_test`
- `unit_test`
- `e2e_test`
- `qa_verification`
- `test_report`

## Reglas de ejecución

- Un nodo solo puede pasar a `running` si todas sus dependencias estan `completed`.
- Un nodo puede pasar a `waiting` cuando falta input humano, entorno o dependencia externa.
- Un nodo puede pasar a `failed` cuando falla un hook, schema, permiso, secreto o validacion.
- Un nodo puede reintentarse solo si `retry_policy` lo permite.
- Un nodo pasa a `cancelled` cuando se agotan reintentos o el orquestador cancela la feature.
- Todo cambio de estado debe persistirse en `runtime/state/<feature-id>.yaml`.

## Paralelismo

El runtime puede ejecutar nodos independientes en paralelo hasta los limites de `orchestrator.yaml`. Las tareas de implementacion paralela requieren worktree.

## Recuperación y reanudación

El motor debe reanudar desde el ultimo estado persistido. Los nodos `completed` no se repiten salvo invalidacion explicita. Los nodos `failed` pueden reintentarse si la causa es recuperable.

## Historial

Cada nodo mantiene eventos de inicio, fin, error, retry, bloqueo, artefactos producidos y metricas.
