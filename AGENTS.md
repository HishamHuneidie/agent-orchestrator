# AGENTS.md

Guia para agentes que trabajen en este repositorio.

## Contexto del proyecto

Este repositorio contiene un sistema portable de orquestacion de agentes para desarrollo de aplicaciones. El control plane esta basado en Markdown, YAML y shell:

- `orchestrator.yaml` define runtime, fases, permisos, modelos, worktrees, seguridad y quality gates.
- `agents/` contiene contratos de comportamiento para perfiles de agente.
- `skills/` contiene procedimientos reutilizables con formato `SKILL.md`.
- `workflows/` describe secuencias completas de trabajo.
- `schemas/` define contratos YAML versionados.
- `templates/` contiene artefactos rellenables.
- `runtime/` contiene el CLI, hooks ejecutables, librerias y estado.
- `scripts/` contiene validadores y utilidades operativas.
- `briefs/`, `tasks/`, `reports/` y `observability/` son artefactos de ejecucion.

El proyecto no ejecuta agentes automaticamente desde un comando con nombre de ejecucion. La orquestacion efectiva ocurre dentro del cliente IA activo, como Codex o ClaudeCode, despues de cargar `AGENTS.md`, las skills de `./skills` y los workflows de `./workflows`. La CLI valida estructura e imprime bootstrap de cliente.

## Principios de trabajo

- Mantener el enfoque Markdown/YAML/shell salvo que haya una razon clara para introducir otra tecnologia.
- Preferir cambios pequenos, auditables y alineados con los contratos existentes.
- No convertir documentos operativos en prosa vaga: cada agente, skill, workflow, hook o template debe seguir siendo accionable.
- No romper compatibilidad con los contratos v1/v2 indicados en `orchestrator.yaml`.
- Usar nombres y rutas existentes antes de crear nuevas categorias.
- Si se cambia una fase, permiso, contrato o artefacto, revisar tambien `orchestrator.yaml`, `scripts/validate-structure.sh`, los schemas y los templates relacionados.

## Comandos utiles

Validar la estructura completa del paquete:

```sh
./orchestrator validate
```

Equivalente directo:

```sh
scripts/validate-structure.sh
```

Validar un contrato concreto:

```sh
scripts/validate-contract.sh <archivo>
```

Imprimir instrucciones de bootstrap para AI Agent:

```sh
./orchestrator init-client
```

Orquestacion manual de soporte:

```sh
scripts/orchestrate.sh templates/feature-request.yaml
```

## Validacion antes de entregar cambios

Como minimo, ejecutar:

```sh
./orchestrator validate
```

Ejecutar tambien `scripts/validate-contract.sh` sobre cualquier contrato YAML nuevo o modificado cuando aplique. Si se modifican reglas de seguridad, hooks o artefactos generados, ejecutar:

```sh
scripts/security-scan.sh
```

Si algun comando no se puede ejecutar, dejar anotado el motivo y el riesgo residual.

## Contratos de estructura

`scripts/validate-structure.sh` es la fuente practica para la forma esperada del repo. Respeta especialmente estas reglas:

- Cada archivo en `agents/*.md` debe mantener las secciones obligatorias, incluyendo proposito, responsabilidades, permisos de archivos, herramientas, flujo interno, checklists, criterios de exito/fallo, recuperacion y handoff.
- Cada `skills/*/SKILL.md` debe mantener `## Trigger`, `## Parameters`, `## Inputs`, `## Procedure`, `## Expected Result` y `## Quality Gates`.
- Cada `hooks/*.md` debe mantener `## Momento de ejecución`, `## Objetivo`, `## Entradas`, `## Salidas`, `## Posibles errores` y `## Componente ejecutable`.
- Si agregas una nueva pieza estructural que debe ser obligatoria, actualiza `scripts/validate-structure.sh`.

## Seguridad y permisos

Seguir la politica de minimo privilegio definida en `orchestrator.yaml` y `docs/security.md`.

No leer, copiar, resumir ni transformar material secreto. Rutas denegadas incluyen `.env`, variantes de env, archivos con `secret`, `token` o `credential`, certificados, claves privadas, `.git/`, `.agents/` y `.codex/`.

Excepcion: `.agents/skills` esta permitido como ruta local de descubrimiento de skills de Codex. Debe contener solo carpetas de skills o un enlace simbolico a `skills/`; el resto de `.agents/` sigue denegado.

No escribir fuera de las raices permitidas por el proyecto sin una razon explicita. Las raices normales de trabajo son:

- `agents/`
- `.agents/skills`
- `briefs/`
- `contracts/`
- `docs/`
- `hooks/`
- `observability/`
- `reports/`
- `runtime/`
- `schemas/`
- `scripts/`
- `skills/`
- `tasks/`
- `templates/`
- `workflows/`

Los hooks deben fallar cerrado ante violaciones de seguridad o secretos detectados.

## Worktrees

Usar `scripts/create-worktree.sh <feature-id> <task-id>` solo cuando el cambio lo justifique:

- implementadores trabajando en paralelo;
- alto riesgo de conflicto;
- cambio grande o transversal;
- impacto de tests desconocido.

Evitar worktrees para documentacion, planificacion, revision aislada o tareas pequenas secuenciales. La limpieza debe ser explicita con:

```sh
scripts/cleanup-worktree.sh <feature-id> <task-id>
```

## Flujo operativo esperado

El flujo principal es:

1. Ante `$feat {feature_name}`, activar `skills/feature-planning-shortcut/SKILL.md`.
2. Leer `docs/features/{feature_name}/README.md` y documentacion relacionada no secreta.
3. Analizar documentacion con `skills/feature-from-docs/SKILL.md`.
4. Estimar con `skills/estimation/SKILL.md`.
5. Crear brief, `templates/execution-plan.yaml` y contratos de task sin implementar.
6. Enrutar agentes con `skills/agent-routing/SKILL.md`.
7. Ante `$task {task_id}`, activar `skills/task-delivery-shortcut/SKILL.md`.
8. Buscar el contrato de task correspondiente y leer su brief.
9. Ejecutar implementacion con `skills/implementation-execution/SKILL.md`.
10. Revisar con `skills/code-review/SKILL.md`.
11. Validar con `skills/test-validation/SKILL.md`.
12. Cerrar con `skills/delivery-summary/SKILL.md` y `templates/delivery-summary.md`.

Mantener la trazabilidad entre feature, tareas, reportes y eventos de observabilidad.

## Criterios para modificar archivos

- Cambios en agentes: conservar el contrato completo de secciones y ajustar permisos, inputs, outputs y handoff si cambia el rol.
- Cambios en skills: documentar trigger, parametros, procedimiento y quality gates de forma verificable.
- Cambios en templates o schemas: mantener correspondencia entre ambos y validar contratos.
- Cambios en runtime o scripts: conservar portabilidad POSIX/Bash sencilla y mensajes de error claros.
- Cambios en hooks: actualizar tanto la version documental en `hooks/` como la version ejecutable en `runtime/hooks/` cuando aplique.
- Cambios en observabilidad: respetar JSONL y los destinos definidos en `orchestrator.yaml`.

## Estilo

- Usar ASCII por defecto en archivos nuevos, salvo cuando el archivo ya use espanol con acentos o secciones existentes lo requieran.
- Mantener documentos concisos, estructurados y directamente ejecutables por humanos o agentes.
- Evitar dependencias externas innecesarias.
- Preferir `rg` para busquedas.
- No hacer refactors no solicitados.
- No revertir cambios ajenos en el worktree.

## Entrega

Antes de cerrar una tarea, indicar:

- archivos modificados;
- comandos de validacion ejecutados;
- cualquier validacion omitida y por que;
- riesgos o trabajo pendiente si existen.
