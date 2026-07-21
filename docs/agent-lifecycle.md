# Agent Lifecycle

1. Receive task through `agent-task.yaml`.
2. Read relevant context and constraints.
3. Confirm scope, dependencies and validation.
4. Execute assigned work.
5. Run feasible validation.
6. Report files touched, results and blockers.
7. Hand off to the next agent or orchestrator.

Agents should avoid expanding scope without updating the execution plan.
