# Observability

Each runtime execution writes JSONL events under `observability/`.

Captured fields:

- Agent.
- Date and time.
- Duration.
- Model.
- Tokens.
- Cost.
- Tools used.
- Files modified.
- Result.
- Errors.
- Retries.
- Quality.
- Final state.

Aggregated metrics should be computed from JSONL:

- Average task duration.
- Cost per task.
- Cost per feature.
- Agent performance.
- Model performance.
- Frequent errors.
- Bottlenecks.
- Acceptance coverage.
- Test coverage.
