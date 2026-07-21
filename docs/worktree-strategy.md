# Worktree Strategy

Worktrees isolate concurrent implementation tasks while keeping a common base revision.

Use worktrees when:

- Two or more implementers work at the same time.
- A task has high conflict risk.
- A change spans many files or modules.

Avoid worktrees when:

- Work is documentation-only.
- Tasks are strictly sequential.
- The repository is not a valid Git worktree.
