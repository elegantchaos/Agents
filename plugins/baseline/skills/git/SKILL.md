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

## Worktree Setup

Reuse a suitable existing checkout or worktree when one is already available. To create a new worktree, run `agt worktree create <name>` from a checkout of the repository. AgentTools owns the naming, branch and location rules, initialises submodules, and prepares dependencies. Use `--base <revision>` when the task specifies a starting revision; otherwise the invoking checkout's HEAD is used. Uncommitted changes and ignored machine-local configuration are not copied.

Obtain `agt` with `../refresh/scripts/ensure-agt.sh`. This workflow requires a release that includes `agt worktree create` and `agt prepare`; check their help before use. If the installed release lacks them, report the version gap rather than reconstructing setup with ad hoc commands. During development of these commands, an explicitly supplied source build can be used.

The command remains inside the caller's sandbox. Where Git metadata protection blocks setup, request approval for the single `agt worktree create <name>` invocation outside the sandbox, or ask the user to run it. Explain that it creates the worktree and branch, initialises submodules and resolves dependencies, including evaluating package manifests, but does not build targets or run tests. An existing approval applies only within its stated scope; do not infer a general sandbox exception. Do not weaken sandbox settings, relocate protected metadata or repeat denied writes to evade the protection.

Use the absolute path reported by the command for subsequent work. A setup failure can leave a valid worktree: follow its reported resume operation there instead of creating another one. Use `agt prepare` in that checkout after dependency changes or cleaning. Preparation is not validation; Swift test runs, including red/green steps, still use `agt validate --target <target>` through `swift:validation`.

Runtime integration remains the agent's responsibility. When Codex supports attaching the resulting existing worktree, attach it and use the returned workspace path. If it cannot attach an externally created checkout, keep using the printed absolute path explicitly and report the integration limit. Do not create a second worktree merely to obtain an attachment. Other runtimes should switch their working context to the reported path using their supported mechanism.

## Commit Identity

Commits carry the user's identity as both author and committer. Never commit as the
agent, and never add co-author, "generated with" or other agent attribution lines to
commit messages, PRs or release notes. A rebase, amend or cherry-pick records the
configured committer on every commit it rewrites, so an environment configured with the
agent's identity, as cloud sessions can be, puts the agent in history without any
attribution being added.

- Before committing, rebasing, amending or cherry-picking, check `git var GIT_AUTHOR_IDENT`
  and `git var GIT_COMMITTER_IDENT`. If either names the agent, take the user's name and
  email from the base branch's existing commits and set `user.name` and `user.email` for
  the repository. Environment variables such as `GIT_COMMITTER_NAME` override that
  configuration; when they are set, pass the user's identity with each command instead.
- Before pushing, list `git log --format='%h %an <%ae> | %cn <%ce>' <base>..HEAD`. If any
  commit names the agent as author or committer, rewrite those commits with the user's
  identity before pushing, and report the rewrite.

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
