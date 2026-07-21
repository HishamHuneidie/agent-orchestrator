---
name: feature-planning-shortcut
description: Use when the user sends $feat {feature_name} to plan a feature from docs without implementing it.
---

# feature-planning-shortcut

## Trigger

Use when the active AI client receives `$feat {feature_name}`.

## Parameters

- `feature_name`: directory name under `docs/features/`.
- `feature_id`: stable identifier, defaulting to `feature_name`.
- `source_dir`: `docs/features/{feature_name}`.
- `source_readme`: `docs/features/{feature_name}/README.md`.
- `classification`: public, internal, restricted or secret.
- `risk_level`: low, medium or high.

## Inputs

- User shortcut command `$feat {feature_name}`.
- Feature documentation in `docs/features/{feature_name}/README.md`.
- Additional non-secret documentation under `docs/features/{feature_name}/`.
- Repository instructions from `AGENTS.md`.
- Runtime policy from `orchestrator.yaml`.
- Planning workflow from `workflows/feature-planning.md`.
- Skills: `feature-from-docs`, `estimation` and `agent-routing`.
- Templates: `feature-request.yaml`, `brief.yaml`, `execution-plan.yaml` and `task.yaml`.

## Procedure

1. Parse `feature_name` from the shortcut and resolve `docs/features/{feature_name}/README.md`.
2. Fail with a clear message if the README is missing, ambiguous or denied by security policy.
3. Read only non-secret files needed from `docs/features/{feature_name}/`.
4. Extract objective, scope, acceptance criteria, constraints, risks, dependencies and out-of-scope items.
5. Create or update the feature request artifact for `feature_id`.
6. Create or update `briefs/{feature_id}/brief.yaml` with implementation-ready context.
7. Estimate tasks, effort, risk, dependencies and worktree strategy.
8. Create or update `tasks/{feature_id}/execution-plan.yaml`.
9. Create or update one `tasks/{feature_id}/{task_id}.yaml` file per planned implementation task.
10. Stop before implementation and report the created artifacts, estimates and next `$task {task_id}` commands.

## Expected Result

The feature has been analyzed, planned and estimated from `docs/features/{feature_name}/`, with briefs and task contracts ready for later implementation.

## Quality Gates

- No implementation changes are made.
- The feature source path is `docs/features/{feature_name}/`.
- Every generated task references `feature_id` and a stable `task_id`.
- The brief is sufficient for an implementation agent to work without rereading unrelated docs.
- Estimates include effort, risk and dependencies.
- Validation commands are explicit or gaps are documented.
- No secret material is read, copied, summarized or transformed.
