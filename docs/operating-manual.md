# Operating Manual

Start with `templates/feature-request.yaml`. Fill the objective, source docs, acceptance criteria, constraints and out-of-scope items. Then create an execution plan using `templates/execution-plan.yaml`.

Use `scripts/validate-structure.sh` before relying on the repository as an orchestrator package.

Use worktree scripts only in a valid Git repository. They are conservative and will fail before making changes if Git is unavailable.
