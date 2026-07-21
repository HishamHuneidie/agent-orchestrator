# AI Client Orchestration

This repository is orchestrated from the active AI client, not by passing an execution name to the shell CLI.

## Client Bootstrap

When opening the repository in Codex or ClaudeCode:

1. Load the repository instructions from `AGENTS.md`.
2. Load every `SKILL.md` under `./skills`.
3. Load the workflow relevant to the user request from `./workflows`.
4. Use `orchestrator.yaml` only as policy and routing configuration.
5. Create or update artifacts in `briefs/`, `tasks/`, `runtime/state/`, `reports/` and `observability/` as the workflow requires.

## Natural Language Triggers

- `$feat {feature_name}`: analyze `docs/features/{feature_name}/`, estimate work, plan tasks and create implementation briefs. This does not implement code.
- `$task {task_id}`: find the matching task contract, implement it, review it, validate it and deliver it.
- `implementa esta feature`: run `skills/application-feature-orchestration/SKILL.md` with `workflows/application-feature.md`.
- Requests for review: run `skills/code-review/SKILL.md` with `workflows/review-and-test.md`.
- Requests for validation or QA: run `skills/test-validation/SKILL.md` with `workflows/review-and-test.md`.
- Requests for delivery closure: run `skills/delivery-summary/SKILL.md` with `workflows/delivery-summary.md`.

## CLI Role

The `orchestrator` command is a support utility:

- `orchestrator init-client`: print these bootstrap instructions.
- `orchestrator validate`: validate package structure.

Workflow execution must happen inside Codex or ClaudeCode using the loaded skills and workflow contracts.
