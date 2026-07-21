# task-delivery-shortcut

## Trigger

Use when the active AI client receives `$task {task_id}`.

## Parameters

- `task_id`: task identifier to execute.
- `feature_id`: feature identifier resolved from the matching task file.
- `task_file`: `tasks/{feature_id}/{task_id}.yaml`.
- `brief_file`: brief referenced by the task, usually `briefs/{feature_id}/brief.yaml`.
- `classification`: public, internal, restricted or secret.
- `risk_level`: low, medium or high.

## Inputs

- User shortcut command `$task {task_id}`.
- Matching task contract under `tasks/**/{task_id}.yaml`.
- Brief referenced by the task contract.
- Execution plan for the feature when present.
- Repository instructions from `AGENTS.md`.
- Runtime policy from `orchestrator.yaml`.
- Workflows: `workflows/task-delivery.md`, `workflows/review-and-test.md` and `workflows/delivery-summary.md`.
- Skills: `implementation-execution`, `code-review`, `test-validation` and `delivery-summary`.

## Procedure

1. Parse `task_id` from the shortcut.
2. Search `tasks/**/{task_id}.yaml`.
3. If no task matches, report that `$feat {feature_name}` must run first or ask for the correct task id.
4. If multiple tasks match, stop and ask the user to choose the intended `feature_id`.
5. Load the task contract, its referenced brief and the feature execution plan when available.
6. Run pre-dispatch checks and choose the assigned implementation agent from the task or routing policy.
7. Implement only the scope described by the task and brief.
8. Run review, tests and QA according to task risk and validation commands.
9. Fix issues found during review or validation when they are inside task scope.
10. Produce or update reports for review, validation and delivery.
11. Report changed files, validation evidence, residual risks and handoff status.

## Expected Result

The selected task has been implemented, reviewed, validated and delivered with traceable artifacts.

## Quality Gates

- Exactly one task contract is selected before implementation starts.
- The task brief exists and is read before changes are made.
- Scope remains limited to the selected `task_id`.
- Review and validation run or are documented as omitted with reason and risk.
- Delivery summary references the active `feature_id` and `task_id`.
- No secret material is read, copied, summarized or transformed.
