# Common Rules

These are the terse shared baseline rules that apply to every session, whatever the task.
Keep detailed and task-specific guidance in skills; the `baseline` plugin owns coding standards and project records. Do not restate that guidance here.

## Core Workflow

- Understand request boundaries.
- Inspect relevant code/docs before editing.
- Follow the `baseline:standards` skill for all code work: reading, creating, refactoring, or reviewing code.
- Use red/green TDD for non-UI code.
- When a required Mint-installed command is unavailable on `PATH`, use `~/.mint/bin/<command>` as a fallback before treating the tool as missing.

## Communication

- Keep communication compact by default unless the user explicitly asks for more detail.
- Before working, report planned actions.
- Whilst working, report progress.
- When finished, report changes, validation status, and residual risks.
- Report every check you ran, every check you skipped with the reason, and any validation gaps.
- Do not repeatedly advertise that the agent is verifying instead of guessing; that should be treated as default competence and only called out when there is real uncertainty or risk.
- Do not repeatedly stop to ask for confirmation when the next verification step is safe and obvious.

## Safety and Discipline

- Never expose or commit credentials/secrets.
- Never perform irreversible destructive actions without explicit approval.
- Reversible changes inside source control, including deletion of tracked files, are allowed.
- If unexpected workspace changes appear, pause and confirm direction.

## Project Records

Projects opt in to a development journal or decision log through `Project Specific Rules`, for example "Keep a development journal in `Extras/Journal/`." or "Keep a decision log in `Extras/Decisions/`." When either is enabled, follow the `baseline:records` skill.
