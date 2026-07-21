# Architecture

The orchestrator is a file-based control plane. Markdown files describe agent behavior and workflows; YAML files define machine-readable contracts; shell scripts provide minimal validation and worktree helpers.

No shell runtime agent scheduler is included. AI Agents reads `orchestrator.yaml`, loads `./skills`, fills templates and dispatches work using the agent and workflow instructions.

Core artifacts:

- Feature request: describes intent and acceptance.
- Execution plan: describes phases, tasks, agents and validation.
- Agent task: describes one assignable unit of work.
- Review report: records implementation findings.
- Test report: records validation evidence.
- Delivery summary: records final decision.
