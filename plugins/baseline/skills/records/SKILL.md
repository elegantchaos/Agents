---
name: records
description: Keeps a project's development journal and decision log. Use in projects whose AGENTS.md enables a journal or decision log, when a session produces context worth preserving, before recording or checking an important decision, or when backfilling a decision log.
---

# Project Records

Apply only the records the project enables in `Project Specific Rules`. If the repository has a root `Extras/` folder, use `Extras/Journal/` and `Extras/Decisions/`; otherwise use its configured locations.

Each kind of record has one job:

- Core documentation describes the system as it is now. Keep it current.
- Decisions record why an important choice was made and what it binds.
- The journal records work as it happened.

## Journal

- Add a dated Markdown entry when a session produces context worth preserving: implementation work, research, experiments, approaches tried, findings, open questions, and ideas still to try.
- Keep `index.md` updated as the guide to the journal, because filenames only give rough chronology.
- Treat entries as history. Do not rewrite past entries to match later changes; record the change in a new entry or a clearly separated follow-up section.
- Link entries to the decisions they establish or apply.
- When the repository has a current research summary or implementation plan, keep it aligned with the code and journal rather than simply listing journal entries.

## Decisions

- Record one Markdown file per important decision: a choice that later work must follow, such as an architectural boundary, technology baseline, or cross-cutting policy. Keep implementation detail, naming, and emergent or unconfirmed directions in the journal.
- Ask for explicit user confirmation before recording a decision.
- Check relevant decisions before implementing new code. If the work would conflict with a decision, raise it with the user instead of diverging.
- Give each decision a status, date, context, the decision itself, alternatives considered (distinguishing rejected options from ones retained for later), and consequences. Follow the repository's existing naming scheme; default to `NNNN-short-title.md`.
- Do not rewrite a decision's rationale, scope, or consequences. Record a new decision that supersedes it. Terminology updates that leave the meaning unchanged are allowed.

## Backfilling a Decision Log

- Gather candidate decisions already established in the project, from design documents, the journal, `README*`, and the code's structure and dependencies.
- Present them as a short list, each with a one-line summary and its evidence.
- Record only the candidates the user confirms.
- List unconfirmed or still-emerging candidates as deferred in a journal entry when the project keeps a journal; otherwise report them.
