# post-delivery

## Momento de ejecución

Al cerrar la entrega.

## Objetivo

Verificar reportes, escanear secretos, validar decision final y registrar metricas.

## Entradas

feature_id, review report, test report, delivery summary.

## Salidas

Entrega aceptada, con riesgos o bloqueada.

## Posibles errores

missing_report, secret_detected, invalid_final_decision

## Componente ejecutable

`runtime/hooks/post-delivery.sh`

## Reglas

- Fallar cerrado ante secretos o permisos invalidos.
- Registrar evento de observabilidad.
- No modificar artefactos de negocio salvo estado y logs autorizados.
- Devolver codigo distinto de cero si el quality gate no se cumple.
