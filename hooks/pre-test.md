# pre-test

## Momento de ejecución

Antes de ejecutar pruebas unitarias, e2e o QA.

## Objetivo

Validar entorno, comandos, cobertura esperada y estructura.

## Entradas

feature_id, execution plan, comandos de validacion.

## Salidas

Permiso para testing y evento de observabilidad.

## Posibles errores

missing_command, invalid_environment, dependency_not_ready

## Componente ejecutable

`runtime/hooks/pre-test.sh`

## Reglas

- Fallar cerrado ante secretos o permisos invalidos.
- Registrar evento de observabilidad.
- No modificar artefactos de negocio salvo estado y logs autorizados.
- Devolver codigo distinto de cero si el quality gate no se cumple.
