# pre-review

## Momento de ejecución

Antes de iniciar revision de codigo.

## Objetivo

Confirmar que implementacion, diffs, acceptance criteria y evidencias basicas estan listos.

## Entradas

feature_id, execution plan, artefactos de implementacion.

## Salidas

Permiso para review o bloqueo con causa.

## Posibles errores

missing_diff, incomplete_task, secret_detected

## Componente ejecutable

`runtime/hooks/pre-review.sh`

## Reglas

- Fallar cerrado ante secretos o permisos invalidos.
- Registrar evento de observabilidad.
- No modificar artefactos de negocio salvo estado y logs autorizados.
- Devolver codigo distinto de cero si el quality gate no se cumple.
