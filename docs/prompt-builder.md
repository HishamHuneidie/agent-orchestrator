# Prompt Builder Architecture

The Prompt Builder assembles subagent prompts without mixing responsibilities.

Inputs:

- Brief: structured task intent and acceptance data.
- Prompt: base agent instructions from `agents/<agent>.md`.
- Skill: reusable procedure from `skills/<skill>/SKILL.md`.
- Context: selected documents and files.
- Restrictions: security, cost, token and workflow limits.
- Permissions: readable and writable paths.

Output:

- Rendered prompt under `runtime/prompts/<feature-id>/<task-id>.prompt.md`.

The Feature Analyst fills brief content only. It must not alter brief structure.
