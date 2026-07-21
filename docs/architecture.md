# Architecture

The orchestrator is a file-based control plane. Markdown files describe agent behavior and workflows; YAML files define machine-readable contracts; shell scripts provide minimal validation and worktree helpers.

No runtime agent scheduler is included in v1. A human or CLI-driven orchestrator reads `orchestrator.yaml`, fills templates and dispatches work using the agent and skill instructions.

Core artifacts:

- Feature request: describes intent and acceptance.
- Execution plan: describes phases, tasks, agents and validation.
- Agent task: describes one assignable unit of work.
- Review report: records implementation findings.
- Test report: records validation evidence.
- Delivery summary: records final decision.
