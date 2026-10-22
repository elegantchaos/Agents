# Common Rules

These are the terse shared baseline rules that apply to every session, whatever the task.
Keep detailed and task-specific guidance in skills; the `baseline` plugin owns coding standards and project records. Do not restate that guidance here.

## Core Workflow

- Understand request boundaries.
- Inspect documentation and decision logs before editing.
- Follow the `baseline:standards` skill for all code work: reading, creating, refactoring, or reviewing code.
- Use red/green TDD for non-UI code.
- In code you write or change, follow the guidelines rather than the style of the surrounding code.
- Follow the spirit of all guidelines, not just the letter. Avoid workarounds which superficially make a pattern fit by adding a forwarding or translation layer.
- Work is complete only when changed files have been checked against the required skills' checklists, and lint findings in them are fixed.
- Work on a branch and worktree, and use a pull request for every change to `main`. Do not merge until the repository's required full validation has passed for the PR's latest commit that changes more than documentation files; later documentation-only commits do not need it again.
- When a required Mint-installed command is unavailable on `PATH`, use `~/.mint/bin/<command>` as a fallback before treating the tool as missing.
- Run Python-based agent utilities, including skill validators, using `~/.local/share/agents/.venv/bin/python` explicitly. Use each project's own environment for project Python code. If the shared environment or a required dependency is missing, report it.
- Install shared Python agent dependencies from `~/.local/share/agents/requirements-agent-tools.lock` with `--require-hashes --only-binary=:all:`. Review version and hash changes before updating the lock file.

## Communication

- Keep communication compact by default unless the user explicitly asks for more detail.
- Before working, report planned actions.
- Whilst working, report progress.
- When finished, report changes, validation status, and residual risks.
- Report every check you ran, every check you skipped with the reason, and any validation gaps.
- Do not repeatedly advertise that the agent is verifying instead of guessing; that should be treated as default competence and only called out when there is real uncertainty or risk.
- Do not repeatedly stop to ask for confirmation when the next verification step is safe and obvious.
- Ask permission before making major architectural changes. As for guidance when you are not sure which alternative to choose.

## Safety and Discipline

- Never expose or commit credentials/secrets.
- Never perform irreversible destructive actions without explicit approval.
- Reversible changes inside source control, including deletion of tracked files, are allowed.
- Write temporary files to the harness-provided scratchpad directory if one exists; otherwise use `<repository>/.build/tmp/`, creating it if needed. Do not use `/tmp`, `/private/tmp`, or other system temporary directories, which can trigger unnecessary approval prompts.
- `.build/tmp/` is for working files, not a store: nothing there should need to outlive the task that made it. Remove your own files from it once the task no longer needs them, including build output, logs and copies of large files. When you find files there from earlier sessions, report their size and offer to clear them, since another session may still be using some.
- If unexpected workspace changes appear, pause and confirm direction.

## Project Records

Projects opt in to a development journal or decision log through `Project Specific Rules`, for example "Keep a development journal in `Extras/Journal/`." or "Keep a decision log in `Extras/Decisions/`." When either is enabled, follow the `baseline:records` skill.
