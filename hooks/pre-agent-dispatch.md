# pre-agent-dispatch

## Momento de ejecución

Antes de entregar una Task a un agente.

## Objetivo

Validar task, schema, permisos, secretos, dependencias y worktree requerido.

## Entradas

task file, permisos efectivos, brief, execution plan.

## Salidas

Task aprobada para dispatch o error bloqueante.

## Posibles errores

missing_task, invalid_schema, secret_detected, denied_path, dependency_not_ready

## Componente ejecutable

`runtime/hooks/pre-agent-dispatch.sh`

## Reglas

- Fallar cerrado ante secretos o permisos invalidos.
- Registrar evento de observabilidad.
- No modificar artefactos de negocio salvo estado y logs autorizados.
- Devolver codigo distinto de cero si el quality gate no se cumple.
