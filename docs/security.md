# Security Architecture

The orchestrator applies minimum privilege through configuration, agent documentation and executable hooks.

Information classification:

- `public`: safe to expose externally.
- `internal`: project context that should stay within the workspace.
- `restricted`: sensitive implementation, business or operational context.
- `secret`: credentials, tokens, certificates, private keys and private variables.

Secret handling rules:

- Secret files are denied by path before content is read.
- Generated artifacts are scanned for common secret patterns.
- Hooks fail closed on secret detection.
- Agents must never request, summarize, copy or transform secret material.

Restricted paths include `.env`, env variants, credential files, certificates, keys, token files and internal runtime control directories such as `.git`, `.agents` and `.codex`.

Exception: `.agents/skills` is allowed as the repository-local Codex skill discovery path. It must contain only skill folders or a symlink to `skills/`; other `.agents` paths remain restricted.
