# Architecture Refactor Report

## 1. Mejoras Propuestas

La arquitectura evoluciona de una coleccion documental a un framework de orquestacion por capas. Se conserva la filosofia Markdown/YAML, pero se agregan runtime, seguridad, estado, observabilidad, prompt builder, contracts versionados y hooks ejecutables.

Mejoras principales:

- Separar configuracion, contratos, prompts, estado, tareas, observabilidad y ejecucion.
- Tratar `Task` como entidad principal con estado, historial, dependencias, responsable, metricas, artefactos, reintentos y logs.
- Centralizar politicas en `orchestrator.yaml`.
- Convertir hooks en ejecutables con validacion de estructura, permisos, secretos, schemas, calidad y metricas.
- Introducir briefs estandarizados y variantes especializadas.
- Agregar prompt builder para ensamblar brief, prompt base, skill, contexto, permisos y restricciones.
- Agregar observabilidad con logs JSONL para ejecuciones, errores y metricas.
- Mantener compatibilidad con scripts y templates v1.

## 2. Nueva Arquitectura Recomendada

Capas:

- Control plane: `orchestrator.yaml`, workflows, agents y skills.
- Runtime: `orchestrator`, `runtime/engine.sh`, hooks ejecutables y librerias.
- Contracts: schemas versionados y templates inteligentes.
- Security: clasificacion, permisos, rutas denegadas y detector de secretos.
- Prompting: prompt builder y prompts renderizados por task.
- State: workflow state y task state.
- Observability: eventos, errores y metricas agregables.
- Reports: review, test, QA y delivery.

## 3. Nueva Estructura De Carpetas

```text
.
├── orchestrator
├── orchestrator.yaml
├── agents/
├── briefs/
├── contracts/
├── docs/
│   ├── diagrams/
│   └── architecture-refactor-report.md
├── hooks/
├── observability/
│   ├── executions.jsonl
│   ├── metrics.jsonl
│   └── errors.jsonl
├── reports/
├── runtime/
│   ├── engine.sh
│   ├── hooks/
│   ├── lib/
│   ├── prompts/
│   └── state/
├── schemas/
├── scripts/
├── skills/
├── tasks/
├── templates/
└── workflows/
```

## 4. Nuevos Componentes Añadidos

- `orchestrator`: CLI principal.
- `runtime/engine.sh`: motor de ejecucion terminal.
- `runtime/lib/security.sh`: permisos, rutas prohibidas y secretos.
- `runtime/lib/schema.sh`: validacion conservadora de contratos.
- `runtime/lib/observability.sh`: metricas.
- `runtime/hooks/*.sh`: hooks ejecutables.
- `scripts/build-prompt.sh`: Prompt Builder.
- `scripts/security-scan.sh`: escaneo manual de secretos.
- `scripts/validate-contract.sh`: validacion manual de contratos.
- `schemas/brief.schema.yaml`, `prompt.schema.yaml`, `workflow-state.schema.yaml`, `observability-event.schema.yaml`.
- `templates/brief.yaml` y variantes backend/frontend/QA/review.
- `templates/task.yaml`, `workflow-state.yaml`, `prompt.md`.

## 5. Componentes Modificados

- `agents/*.md`: ahora comparten una estructura documental estricta y definen modelos, permisos, flujos y metricas.
- `orchestrator.yaml`: pasa a ser fuente unica de configuracion v2.
- `schemas/*.schema.yaml`: contratos versionados y ampliados.
- `templates/*.yaml`: plantillas dinamicas con variables.
- `scripts/validate-structure.sh`: debe validar estructura v1 y v2.
- `workflows/*.md`: evolucionan a workflows con estados.
- `hooks/*.md`: documentan hooks ejecutables.

## 6. Componentes A Eliminar

No se elimina nada en esta migracion. Los artefactos v1 siguen aportando compatibilidad y onboarding. A futuro se podrian deprecar wrappers manuales cuando el runtime soporte ejecucion real de API de agentes.

## 7. Flujo De Ejecucion

Ver `docs/diagrams/execution-flow.md`.

## 8. Interaccion Entre Agentes

Ver `docs/diagrams/agent-interactions.md`.

## 9. Construccion De Prompts

Ver `docs/diagrams/prompt-builder.md`.

## 10. Plan De Migracion

1. Mantener v1 operativa y agregar `version: 2` a configuracion y schemas.
2. Normalizar agentes con la estructura documental comun.
3. Introducir `Task` como entidad principal sin retirar `agent-task.yaml`.
4. Agregar briefs estandarizados y adaptar Feature Analyst para rellenar contenido sin cambiar formato.
5. Agregar hooks ejecutables en paralelo a hooks Markdown.
6. Activar validacion de estructura, permisos y secretos en hooks.
7. Agregar prompt builder y generar prompts renderizados por task.
8. Introducir runtime CLI con `orchestrator run` y `orchestrator task`.
9. Registrar observabilidad en JSONL.
10. Convertir workflows a maquinas de estado reanudables.
11. Agregar integracion real con proveedores de modelos detras del runtime.
12. Deprecar gradualmente scripts manuales solo cuando existan alternativas runtime equivalentes.

## Decisiones Arquitectonicas

- Shell y YAML se mantienen para portabilidad.
- El runtime es terminal-first, preparado para ser consumido por una futura UI.
- Los hooks ejecutables fallan cerrado ante secretos o permisos.
- La validacion de schema es conservadora en v2 para evitar dependencias externas; puede sustituirse por JSON Schema/YAML parser en una fase posterior.
- Observabilidad usa JSONL para ingestion simple por herramientas externas.
