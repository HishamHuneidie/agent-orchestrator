---
name: agent-routing
description: Select the right repository agent profile and handoff path for planned feature or task work.
---

# agent-routing

## Trigger

Use when the orchestrator needs to: Asignar agentes, herramientas, orden, paralelismo y permisos efectivos.

## Parameters

- `language`: implementation language when relevant.
- `framework`: application or test framework.
- `database`: database engine.
- `orm`: persistence abstraction.
- `architecture`: architectural style or module boundaries.
- `test_style`: unit, integration, e2e, contract or manual QA.
- `risk_level`: low, medium or high.
- `classification`: public, internal, restricted or secret.

## Inputs

- Standard brief.
- Task entity.
- Effective permissions.
- Relevant context selected by the orchestrator.
- Runtime policies from `orchestrator.yaml`.

## Procedure

1. Validate inputs and classification.
2. Resolve parameters without duplicating the skill for a specific stack.
3. Apply the role-specific procedure to the assigned scope.
4. Produce a schema-compatible artifact.
5. Record assumptions, gaps and validation evidence.
6. Return handoff data for the next node.

## Expected Result

A reusable, parameterized output that can be validated automatically and reused across projects.

## Quality Gates

- No secret material is read or emitted.
- Output references the active `feature_id` and `task_id` when available.
- Scope remains aligned with the brief.
- Validation commands are explicit or gaps are documented.
