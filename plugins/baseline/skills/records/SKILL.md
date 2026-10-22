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

### What to record

- Record one Markdown file per important decision: a choice that later work must follow, such as an architectural boundary, technology baseline, or cross-cutting policy. A record should guide where future code goes or how it must behave.
- A design change is not a decision. When a choice follows from existing decisions, or only describes how something is built, record it in documentation and the journal instead. Keep naming and emergent or unconfirmed directions in the journal.
- Check decisions before implementing new code. If the work would conflict with a decision, raise it with the user instead of diverging.

### Confirming

- Before writing or changing any decision record, ask a separate question that names the record (its new number and title, or the existing decision being amended) and summarises what it will say. Only a direct yes to that question confirms it.
- Agreement with a design or policy choice is not confirmation to record it, and a question that bundles the two does not count. Changes to existing decisions, including added cross-reference or "Refined by" lines, need the same confirmation.

### Shape

Decision records are read in full into agent context, so every line must earn its place. Follow the repository's existing naming scheme; default to `NNNN-short-title.md`. Use this order:

1. **Title and status lines.** Status, date, and relationship lines such as Refines, Refined by, Applies, Related and Supersedes, each linking the other decision. A revision line gives its date only; Git records what changed.
2. **`## Decision`.** The decision itself, first, so the opening lines say what was decided. Do not add a separate summary above it. Keep it to the main rules, in a few paragraphs.
3. **`## Context`**, only when the decision needs placing in the project. One to three sentences on how it fits into the overall project. No history of what the code or project used to do, no argument against alternatives, and no repeat of the status lines.
4. **`## Details`**, only when the decision has more than a few paragraphs of rules. Move the secondary rules here, after the context, instead of restating them.
5. **`## Alternatives considered`.** Compact, but with enough reason to prevent accidental reversal. Distinguish rejected options from ones retained for later.
6. **`## Consequences`.** Only obligations and effects a reader would not infer from the decision. Do not restate the decision or its alternatives, and do not record migration, reset or transition notes; those belong in the journal or implementation documentation.

Write in the present tense, as current fact and intent. Keep design and implementation detail in documentation, linking to it with a trailing pointer where a reader needs it.

### Changing decisions

- Do not rewrite a decision's rationale, scope, or consequences, unless explicitly instructed to do so. Record a new decision that supersedes it. Terminology updates that leave the meaning unchanged are allowed.
- When a decision is folded into another, reduce it to its title, status lines and a pointer to the decision that now holds it.
- When compacting a decision, move anything still useful into the appropriate documentation rather than discarding it.
- Keep a clear link between decisions and the journal entries or documentation that provide context and evidence for them.

## Backfilling a Decision Log

- Offer to backfill the decision log by identifying and recording important decisions that have already been made in the project.
- Gather candidate decisions already established in the project, from design documents, the journal, `README*`, and the code's structure and dependencies.
- Present them as a short list, each with a one-line summary and its evidence.
- Record only the candidates the user confirms.
- List unconfirmed or still-emerging candidates as deferred in a journal entry when the project keeps a journal; otherwise report them.
