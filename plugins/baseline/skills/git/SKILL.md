---
name: git
description: Use when working with Git or GitHub, including local repository operations, pull requests, draft releases, review feedback, and GitHub Actions CI triage.
---

# Git and GitHub

Use this skill for local Git work across agent environments. The GitHub workflows
apply when the repository is hosted on GitHub or the task targets GitHub. Prefer
a suitable connector for structured repository, issue, and PR data; use local
Git and `gh` for operations it does not cover, including Actions logs.

## Git Commands and Permissions

- Prefer SSH remotes (`git@` or `ssh://`). Do not rewrite existing remotes automatically.
- Prefer the tool's working-directory parameter and plain `git <subcommand>` so
  command-prefix rules match predictably. Use `git -C` when the interface needs
  it; it does not bypass filesystem restrictions.
- Follow the current session's sandbox and approval policy. A command allow rule
  does not grant filesystem access. Under Codex's default workspace-write policy,
  `.git` and resolved worktree Git directories are protected; other permission
  profiles may differ. When the active policy protects Git metadata, use its
  supported approval path for commands that write there. Do not change sandbox
  configuration as part of ordinary Git work.
- Diagnose lock errors from the actual message: permission-denied or
  operation-not-permitted failures differ from a lock that already exists.
  Do not delete locks or repeat failing writes as a substitute for diagnosis.
- Run Git mutations serially when they share repository metadata, including
  linked worktrees. Read-only inspection normally needs no escalation.
- This guidance grants no extra permission to unrelated commands.

## GitHub Workflows

Read only the references relevant to the task:

- For repository, PR, or issue orientation, read [references/github-triage.md](references/github-triage.md).
- For PR creation, editing, or merging, read [references/pull-requests.md](references/pull-requests.md).
- For draft releases, read [references/draft-releases.md](references/draft-releases.md).
- For unresolved review feedback, read [references/review-comments.md](references/review-comments.md).
- For failing GitHub Actions checks, read [references/github-actions-ci.md](references/github-actions-ci.md).

Keep PRs and release notes factual and scoped to the actual diff. Run `actionlint`
when changing GitHub Actions workflows if it is installed; otherwise report that
it was unavailable without installing it solely for validation.
