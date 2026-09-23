# Common Rules

These are the terse shared baseline rules that belong in `Standard Rules`.
Keep detailed cross-language, language-specific, and shared-baseline-maintenance guidance in dedicated skills or focused reference modules rather than expanding this file into a second source of truth.

## Methodology

Always write good, modern, idiomatic code.
Prefer fixing root causes over layered workarounds.
Keep interfaces explicit and intentionally small.
Avoid hidden coupling and surprising side effects.
Write documentation to reflect the current state.

## Design Principles

Always apply `Don't Repeat Yourself (DRY)`, and `Single Source Of Truth`.

Additional principles to use where relevant:

- KISS (Keep It Simple)
- YAGNI (Build What Is Needed)
- Make Illegal States Unrepresentable
- Dependency Injection
- Composition Over Inheritance
- Command-Query Separation
- Law of Demeter
- Structured Concurrency
- Design by Contract
- Idempotency

## Core Workflow

- Understand request boundaries.
- Inspect relevant code/docs before editing.
- Match change scope to the request: keep focused fixes small and coherent; use codebase-wide cleanup when the task is cleanup, review, modernisation, or consistency work.
- Add/update tests for behavior changes.
- Run the relevant validation checks.

## Communication

- Keep communication compact by default unless the user explicitly asks for more detail.
- Before working, report planned actions.
- Whilst working, report progress.
- When finished, report changes, validation status, and residual risks.
- Do not repeatedly advertise that the agent is verifying instead of guessing; that should be treated as default competence and only called out when there is real uncertainty or risk.
- Do not repeatedly stop to ask for confirmation when the next verification step is safe and obvious.

## Testing & Validation

Use red/green TDD for non-UI code.
Create UI previews if the tooling supports it (eg SwiftUI #Preview).
Use the project's canonical validation command to run the narrowest validation that proves the change first, then broaden to relevant project checks.
Report skipped validation with the reason.
Report validation gaps and residual risk.

## Portability

- Use portable path references in docs and guidance.
- Prefer repository-relative paths for files in the current repository and `~/...` home-relative paths for shared resources outside it.
- Avoid machine-specific absolute paths.
- When a required Mint-installed command is unavailable on `PATH`, use `~/.mint/bin/<command>` as a fallback before treating the tool as missing.

## Safety and Discipline

- Never expose or commit credentials/secrets.
- Never perform irreversible destructive actions without explicit approval.
- Reversible changes inside source control, including deletion of tracked files, are allowed.
- Avoid unrelated refactors during focused tasks, but suggest them as a follow-up if they are needed.
- If unexpected workspace changes appear, pause and confirm direction.

## Research

Prefer trusted primary sources for technical decisions, especially official platform, language, package, API, and dependency documentation.

## Project Records

Projects opt in to these records through `Project Specific Rules`, for example "Keep a development journal in `Extras/Journal/`." or "Keep a decision log in `Extras/Decisions/`." Apply only the records a project enables. If the repository has a root `Extras/` folder, use `Extras/Journal/` and `Extras/Decisions/`; otherwise use its configured locations.

Each kind of record has one job:

- Core documentation describes the system as it is now. Keep it current.
- Decisions record why an important choice was made and what it binds.
- The journal records work as it happened.

### Journal

- Add a dated Markdown entry when a session produces context worth preserving: implementation work, research, experiments, approaches tried, findings, open questions, and ideas still to try.
- Keep `index.md` updated as the guide to the journal, because filenames only give rough chronology.
- Treat entries as history. Do not rewrite past entries to match later changes; record the change in a new entry or a clearly separated follow-up section.
- Link entries to the decisions they establish or apply.
- When the repository has a current research summary or implementation plan, keep it aligned with the code and journal rather than simply listing journal entries.

### Decisions

- Record one Markdown file per important decision: a choice that later work must follow, such as an architectural boundary, technology baseline, or cross-cutting policy. Keep implementation detail, naming, and emergent or unconfirmed directions in the journal.
- Ask for explicit user confirmation before recording a decision.
- Check relevant decisions before implementing new code. If the work would conflict with a decision, raise it with the user instead of diverging.
- Give each decision a status, date, context, the decision itself, alternatives considered (distinguishing rejected options from ones retained for later), and consequences. Follow the repository's existing naming scheme.
- Do not rewrite a decision's rationale, scope, or consequences. Record a new decision that supersedes it. Terminology updates that leave the meaning unchanged are allowed.
