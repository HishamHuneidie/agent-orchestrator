# Workflow Engine

Workflows are modeled as state machines.

Node states:

- `pending`
- `running`
- `waiting`
- `failed`
- `cancelled`
- `completed`

The workflow engine is a client-side contract executed by the AI Client after loading `./skills`. The shell CLI validates and prepares support artifacts, but it does not start workflow execution from an execution name.

Client responsibilities:

- Load configuration.
- Load or create workflow state.
- Resolve dependencies.
- Route eligible nodes to the proper agent contract.
- Enforce parallelism.
- Execute hooks.
- Retry recoverable failures.
- Persist history.
- Resume from state.

The v2 runtime validates package structure. Full workflow execution is intentionally kept inside the active AI client boundary.
