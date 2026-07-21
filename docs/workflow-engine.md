# Workflow Engine

Workflows are modeled as state machines.

Node states:

- `pending`
- `running`
- `waiting`
- `failed`
- `cancelled`
- `completed`

Engine responsibilities:

- Load configuration.
- Load or create workflow state.
- Resolve dependencies.
- Dispatch eligible nodes.
- Enforce parallelism.
- Execute hooks.
- Retry recoverable failures.
- Persist history.
- Resume from state.

The v2 runtime initializes and validates these states. Full provider-backed subagent execution is intentionally left behind the engine boundary.
