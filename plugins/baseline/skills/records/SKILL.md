---
name: records
description: Keeps a project's development journal, decision log, and review log. Use in projects whose AGENTS.md enables a journal or decision log, when a session produces context worth preserving, before recording or checking an important decision, when backfilling a decision log, or when recording a code review.
---

# Project Records

Apply only the records the project enables in `Project Specific Rules`. If the repository has a root `Extras/` folder, use `Extras/Journal/`, `Extras/Decisions/` and `Extras/Reviews/`; otherwise use its configured locations.

Each kind of record has one job:

- Core documentation (including README.md) describes the system as it is now. Keep it current. Avoid historical framing.
- Decisions record why an important choice was made and what it binds.
- The journal records work as it happened.
- Reviews record the assessment of changes against the project's standards, decisions, and other relevant criteria.

## Journal

- Add a dated Markdown entry when a session produces context worth preserving: implementation work, research, experiments, approaches tried, findings, open questions, and ideas still to try.
- Keep `index.md` updated as the guide to the journal, because filenames only give rough chronology.
- Treat entries as history. Do not rewrite past entries to match later changes; record the change in a new entry or a clearly separated follow-up section.
- Link entries to the decisions they establish or apply.
- When the repository has a current research summary or implementation plan, keep it aligned with the code and journal rather than simply listing journal entries.

## Decisions

- Record one Markdown file per important decision: a choice that later work must follow, such as an architectural boundary, technology baseline, or cross-cutting policy.
- Decisions should be compact, focused, and self-contained, capturing only the essential rationale and consequences; keep design and implementation detail in documentation; keep naming and emergent or unconfirmed directions in the journal.
- Before writing or changing any decision record, ask a separate question that names the record (its new number and title, or the existing decision being amended) and summarises what it will say. Only a direct yes to that question confirms it.
- Agreement with a design or policy choice is not confirmation to record it, and a question that bundles the two does not count. Changes to existing decisions, including added cross-reference or "Refined by" lines, need the same confirmation.
- Check decisions before implementing new code. If the work would conflict with a decision, raise it with the user instead of diverging.
- Give each decision a status, date, context, the decision itself, alternatives considered (distinguishing rejected options from ones retained for later), and consequences. Follow the repository's existing naming scheme; default to `NNNN-short-title.md`.
- Do not rewrite a decision's rationale, scope, or consequences, unless explicitly instructed to do so. Record a new decision that supersedes it. Terminology updates that leave the meaning unchanged are allowed.
- Keep a clear link between decisions and the journal entries or documentation that provide context and evidence for them.
- Keep decision records concise and focused, avoiding unnecessary detail that belongs in the journal or other documentation.
- Keep documentation of alternative options and rejected choices compact, but with enough context to avoid accidental reversal or misunderstanding.

## Backfilling a Decision Log

- Offer to backfill the decision log by identifying and recording important decisions that have already been made in the project.
- Gather candidate decisions already established in the project, from design documents, the journal, `README*`, and the code's structure and dependencies.
- Present them as a short list, each with a one-line summary and its evidence.
- Record only the candidates the user confirms.
- List unconfirmed or still-emerging candidates as deferred in a journal entry when the project keeps a journal; otherwise report them.
