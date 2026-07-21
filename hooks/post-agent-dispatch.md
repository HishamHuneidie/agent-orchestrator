# post-agent-dispatch

## Momento de ejecución

Despues de que un agente termine o falle.

## Objetivo

Capturar resultado, archivos, blockers, errores, metricas y handoff.

## Entradas

feature_id, task_id, estado final, artefactos.

## Salidas

Evento persistido e historial actualizado.

## Posibles errores

missing_result, invalid_artifact, metric_write_failed

## Componente ejecutable

`runtime/hooks/post-agent-dispatch.sh`

## Reglas

- Fallar cerrado ante secretos o permisos invalidos.
- Registrar evento de observabilidad.
- No modificar artefactos de negocio salvo estado y logs autorizados.
- Devolver codigo distinto de cero si el quality gate no se cumple.
