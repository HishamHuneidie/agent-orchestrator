---
name: application-feature-orchestration
description: Orchestrate an application feature end to end from request intake through planning, implementation, review, validation and delivery.
---

# application-feature-orchestration

## Trigger

Use when the user asks the active AI client to implement a feature, for example: `implementa esta feature`, `implement this feature`, `build this feature` or equivalent wording.

## Parameters

- `feature_id`: stable identifier derived from the request or existing artifact.
- `client`: AI Agent.
- `classification`: public, internal, restricted or secret.
- `risk_level`: low, medium or high.
- `parallelism`: sequential or parallel.

## Inputs

- User request in the active AI client.
- Repository instructions from `AGENTS.md`.
- Runtime policy from `orchestrator.yaml`.
- All skills available under `./skills`.
- Workflow definition from `workflows/application-feature.md`.
- Existing briefs, tasks, reports or runtime state when present.

## Procedure

1. Confirm that orchestration is running inside the AI Client.
2. Load applicable skills from `./skills` and select the minimal set needed for the request.
3. Resolve or create `feature_id` and initialize state from `templates/workflow-state.yaml` when no state exists.
4. Execute the workflow nodes from `workflows/application-feature.md`: intake, feature analysis, estimation, planning, routing, implementation, review, test and delivery.
5. For each node, apply the matching agent contract from `agents/` and skill contract from `skills/`.
6. Persist task, brief, report, prompt and observability artifacts in the configured directories.
7. Run hooks and validation commands required by the selected node.
8. Stop and report when human input, missing environment, denied permissions or unrecoverable validation failures block progress.

## Expected Result

The active AI client has orchestrated the feature workflow end to end using repository-local skills and workflow contracts, with traceable artifacts and validation evidence.

## Quality Gates

- Shell CLI subcommands are not used to start execution.
- Every selected skill remains contract-compatible and action-oriented.
- State changes are persisted when workflow state is used.
- Agent routing follows `orchestrator.yaml` and `skills/agent-routing/SKILL.md`.
- Validation commands are executed or explicitly documented as omitted with reason and risk.
- No secret material is read, copied, summarized or transformed.
