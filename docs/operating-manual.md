# Operating Manual

Start inside the AI Client. Load `AGENTS.md`, every `SKILL.md` under `./skills`, and the relevant workflow under `./workflows`.

For planning a feature, prefer `$feat {feature_name}`. This uses `skills/feature-planning-shortcut/SKILL.md` with `workflows/feature-planning.md`, reads `docs/features/{feature_name}/README.md`, estimates work and creates briefs plus task contracts without implementing code.

For implementing a planned task, prefer `$task {task_id}`. This uses `skills/task-delivery-shortcut/SKILL.md` with `workflows/task-delivery.md`, finds `tasks/**/{task_id}.yaml`, loads its brief, implements, reviews, validates and delivers the task.

For a full feature implementation request such as `implementa esta feature`, use `skills/application-feature-orchestration/SKILL.md` with `workflows/application-feature.md`. Start with `templates/feature-request.yaml` when the request is not already structured. Fill the objective, source docs, acceptance criteria, constraints and out-of-scope items. Then create an execution plan using `templates/execution-plan.yaml`.

Use `scripts/validate-structure.sh` before relying on the repository as an orchestrator package.

Use worktree scripts only in a valid Git repository. They are conservative and will fail before making changes if Git is unavailable.

The active AI client owns workflow execution; the shell CLI is only for bootstrap and validation.
