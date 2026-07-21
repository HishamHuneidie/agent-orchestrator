# pre-orchestration

## Momento de ejecución

Antes de iniciar `orchestrator run`.

## Objetivo

Validar objetivo, estructura, secretos, configuracion y contexto minimo.

## Entradas

feature_id, orchestrator.yaml, estructura del repo.

## Salidas

Evento de observabilidad y permiso para continuar.

## Posibles errores

missing_feature_id, invalid_structure, secret_detected, permission_denied

## Componente ejecutable

`runtime/hooks/pre-orchestration.sh`

## Reglas

- Fallar cerrado ante secretos o permisos invalidos.
- Registrar evento de observabilidad.
- No modificar artefactos de negocio salvo estado y logs autorizados.
- Devolver codigo distinto de cero si el quality gate no se cumple.
