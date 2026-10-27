---
name: records
description: Shapes design documentation and maintains project journals, decision logs, and review logs. Use when writing or revising design documents, recording work in an enabled project log, recording or checking important decisions, or backfilling a decision log.
---

# Project Records

Apply the design-document guidance whenever writing or revising a design document. Create and maintain journals, decision logs and review logs only when the project enables them in `Project Specific Rules`. If the repository has a root `Extras/` folder, use `Extras/Journal/`, `Extras/Decisions/` and `Extras/Reviews/`; otherwise use its configured locations.

Each kind of record has one job:

- Design documents describe the current intended conceptual model, responsibilities and contracts.
- Implementation documents explain how the code fulfils the design and track implementation progress, gaps and delivery plans.
- Usage documentation, including README.md, explains how to use the system as it is now. Keep documentation current and avoid historical framing.
- Decisions record why an important choice was made and what it binds.
- The journal records work as it happened.
- Reviews record the assessment of changes against the project's standards, decisions, and other relevant criteria.

## Design Documents

### Confirming

- Before creating or changing a design document, prepare the proposed text or diff
  for review, then ask a separate question naming each document and summarising the
  changes, including any changes to meaning, scope or structure. Only a direct yes
  to that question confirms the edit. Prepare drafts in the conversation or a
  temporary working file; keep the canonical document unchanged until confirmed.
- Agreement with a design, approval to implement code, or a general instruction to
  keep documentation current is not confirmation to write or rewrite the design
  document. A question that bundles design agreement with permission to edit does
  not count.
- Confirmation covers only the proposed edits. Do not expand a focused update into
  a rewrite, compaction or reorganisation. Present further changes separately for
  confirmation; do not ask again for edits already confirmed in the current scope.
- Apply this gate to all edits, including wording, links and diagrams, and to
  renaming, moving or deleting design documents. Changes to a design diagram include
  its editable source and rendered image.

### Scope And Boundaries

Describe concepts, relationships, responsibilities, contracts and invariants.
Include ownership, failure behavior and algorithms where they define the design.

Do not describe implementation-specific types and functions, source file layouts,
framework wiring, or code walkthroughs. This prohibition also applies to appendices.
Put these details in a linked implementation document. Brief references to an API
or technology are allowed when they explain a conceptual contract or illustrate a
replaceable option; they must not become instructions for implementing it.

Keep user instructions in usage documentation and delivery history in the journal.
Include brief rationale where it helps explain the design. Decision records, when
enabled, hold the authoritative binding choices and fuller consideration of alternatives.

Check each section: could the implementation be replaced while this description
remains true? If it explains how particular code fulfils the design, move it into
implementation documentation. Preserve algorithms and other contracts that constrain
any conforming implementation.

### Naming And Location

Name design documents `<Subject> Design.md`, such as `Datastore Design.md`.
Name the corresponding implementation document `<Subject> Implementation.md`.
Place both under `Extras/Documentation/` by default, optionally grouped together in
a topic subfolder. An explicit project naming or location convention takes precedence;
otherwise use these defaults. Link the documents when both exist without duplicating
their detailed rules.

### Progressive Disclosure

Start with the conceptual overview and the most important information. Develop
each concept from its role and relationships to its contracts and specific detail.
Keep essential rules, including invariants, ownership, failure behavior and boundary
contracts, in the relevant concept section. Put optional supporting material in an
appendix and omit detail that adds no useful context.

### Currency

Describe the current intended design in the present tense. Mark proposals briefly
as proposed, and identify unresolved design questions explicitly. Keep implementation
progress, gaps and delivery sequencing in a linked implementation document or journal.

When revising a design, remove superseded descriptions and sentences that answer
questions only a reader of an earlier design would ask. Keep revision history in the
journal and link decision records where useful. Include an account of earlier revisions
in a design appendix only when requested.

For an explicit major redesign, isolate any necessary comparison with the previous
design in a labelled section or appendix. Keep the main design self-contained and
migration steps in implementation documentation. Incremental revisions do not need
this comparison.

### Shape

Read [assets/design-document-template.md](assets/design-document-template.md) when
creating or restructuring a design document. It illustrates a broad structure;
adapt the headings and omit sections that have no useful content. Small designs
can combine the overview and detail without adopting the whole template.

1. **Conceptual overview.** Open with a short account of the purpose, scope and
   central model. This can be unheaded introductory prose. Develop the broad model
   in several short concept sections when useful, with diagrams and a compact set
   of governing principles. Readers should understand the whole before its details.
2. **Terminology**, when needed. Place it after the conceptual overview, including
   any overview concept sections, and before detailed design. Give fundamental or
   ambiguous terms one concise definition each, keeping detailed rules elsewhere.
   Aim for roughly ten entries; if substantially more are needed, consider splitting
   the document or linking definitions. Link the project glossary when one exists.
   Consistent local recaps of shared terms are useful; avoid competing definitions.
3. **Detailed design.** Give each concept its own section, with subsections for its
   contracts and rules. A separate Detailed Design heading may group these after
   the conceptual overview. Choose heading levels that make those reading levels
   clear; they need not all be siblings. Brief recaps between overview, terminology
   and detail are allowed. Keep each detailed contract authoritative in one place.
4. **Open Questions**, when needed. State what remains unresolved without presenting
   it as an agreed rule.
5. **Related Documents**, when useful. Link implementation documentation, related
   designs and project records with a brief explanation of what each owns.
6. **Appendices**, when needed. Keep supporting material outside the main reading
   path: background, prior art, references and clearly deferred future possibilities.
   Distinguish future possibilities from current commitments, and avoid speculative
   implementation mechanics. Relevant prior art is distinct from revision history;
   the Currency rules govern accounts of previous versions of this design.

### Diagrams

Use diagrams where they clarify relationships, boundaries, flows or interactions
more effectively than prose alone. Place a broad conceptual diagram near the
overview and more detailed diagrams beside the concepts they explain, when useful.
Do not add diagrams that merely decorate the document or repeat an already clear list.

Draw diagrams with Excalidraw. Keep an editable `.excalidraw` source and a rendered
image in the project's documentation tree, following its asset conventions. Embed
the image and link the editable source beside it; include an online editing link
when one is available. Check the rendered diagram visually for readable labels,
clear flow and agreement with the text, and update both source and image together.

### Compliance Checklist

Before reporting a design-document task complete, check each document against this
list. Report any exceptions or unchecked items and their reasons.

- The proposed text or diff was presented and a separate confirmation obtained for
  the named documents before editing them. The final diff stays within that scope,
  including any diagram, naming or location changes; no unreviewed rewrite or cleanup
  was added.
- The filename is `<Subject> Design.md` under `Extras/Documentation/`, optionally
  in a topic subfolder, or an explicit project convention accounts for the difference.
  A corresponding implementation document uses `<Subject> Implementation.md` in
  the same home.
- The document describes the current intended design in the present tense;
  proposal status and unresolved questions are explicit.
- Concepts, responsibilities and contracts are distinct from implementation
  details, usage instructions, progress, delivery plans and historical records.
  No descriptions of implementation-specific types, functions, source file layouts,
  framework wiring or code walkthroughs remain in the main text or appendices.
  Any API or technology references explain the conceptual contract or an option,
  without prescribing implementation mechanics.
- Essential contracts, invariants, ownership, failure behavior and design-defining
  algorithms remain in their concept sections.
- A short opening states purpose, scope and the central model. Any overview concept
  sections and principles develop the broad model before terminology and detailed
  design. The hierarchy supports these reading levels without forcing flat headings.
- Terminology contains concise definitions of fundamental or ambiguous terms,
  links any project glossary and keeps detailed rules in the concept sections.
  Recaps agree with their authoritative definitions and contracts.
- Superseded descriptions and revision-history framing have been removed.
  Any appendix about earlier revisions was requested; any previous-design comparison
  is necessary to an explicit major redesign and isolated from the main design.
  Background, prior art and brief rationale are relevant, and deferred possibilities
  are clearly distinguished from current commitments.
- Optional sections earn their place. Appendices contain supporting material,
  and the main design is self-contained.
- Links to implementation documentation, glossaries and enabled project records
  resolve and point to the appropriate source without duplicating its detailed rules.
- Diagrams are used where they improve understanding. Each is drawn with Excalidraw,
  has a linked editable source and embedded rendered image, has been visually checked,
  and agrees with the text. Source and image are current together.

## Journal

- Add a dated Markdown entry when a session produces context worth preserving: implementation work, research, experiments, approaches tried, findings, open questions, and ideas still to try.
- Keep `index.md` updated as the guide to the journal, because filenames only give rough chronology.
- Treat entries as history. Do not rewrite past entries to match later changes; record the change in a new entry or a clearly separated follow-up section.
- Link entries to the decisions they establish or apply.
- When the repository has a current research summary or implementation plan, keep it aligned with the code and journal rather than simply listing journal entries.

## Decisions

### What to record

- Record one Markdown file per important decision: a choice that later work must follow, such as an architectural boundary, technology baseline, or cross-cutting policy. A record should guide where future code goes or how it must behave.
- Before proposing a record, identify the binding choice and what future work it constrains. A document that mainly explains a model, algorithm, component interaction or implementation belongs in design or implementation documentation. A design change alone does not justify a decision record; record a distinct binding choice only when there is one. Choices that follow from existing decisions need no separate record. Keep naming and emergent or unconfirmed directions in the journal.
- Check decisions before implementing new code. If the work would conflict with a decision, raise it with the user instead of diverging.

### Confirming

- Before writing or changing any decision record, ask a separate question that names the record (its new number and title, or the existing decision being amended) and summarises what it will say. Only a direct yes to that question confirms it.
- Agreement with a design or policy choice is not confirmation to record it, and a question that bundles the two does not count. Changes to existing decisions, including added cross-reference or "Refined by" lines, need the same confirmation.

### Shape

All decision records are intended to be read in full into a session. Their combined
size matters: keep each compact and free of unnecessary bureaucracy and repetition.
Do not fill out sections merely to satisfy a template, invent alternatives or
consequences, or restate the same rule as a summary, detail and consequence.

Do not include details that will go out of date or are likely to change; for example,
planned implementation work or temporary technical decisions.

Follow the repository's existing naming scheme; default to `NNNN-short-title.md`.
Use the following order, omitting optional sections that add nothing:

1. **Title, status and date.** Add relationship lines such as Refines or Supersedes
   only when they clarify a real dependency or replacement, linking the other record.
   Omit administrative metadata and change logs. A revision line gives its date only;
   Git records what changed.
2. **`## Decision`.** Lead with the binding choice, its scope and the rules later work
   must follow, in a few concise paragraphs or bullets. Do not add a separate summary.
3. **`## Context`**, when needed. Give enough project context, constraints and rationale
   to understand and apply the decision correctly. Usually a few sentences suffice;
   retain essential context even when it needs more space. Avoid project history,
   repeated metadata and explanations already clear from the decision.
4. **`## Details`**, only for essential secondary rules that would obscure the main
   choice. Move them here without repeating them; explanatory design detail belongs
   in a linked document.
5. **`## Alternatives considered`**, only when actual alternatives and the reasons for
   choosing between them help prevent accidental reversal. Keep it brief and distinguish
   rejected options from those retained for later.
6. **`## Consequences`**, only for non-obvious obligations or effects. Omit consequences
   already implied by the rules, repeated rationale, and migration or transition notes.

Write in the present tense, as current fact and intent. Keep the binding rules and
context needed to follow them in the record itself. Link directly to design documents
for fuller models, mechanisms and examples; do not reproduce those documents or turn
the decision into a design specification. Do not link to implementation plans, delivery
order or implementation status.

### Changing decisions

- Do not rewrite a decision's rationale, scope, or consequences, unless explicitly instructed to do so. Record a new decision that supersedes it. Terminology updates that leave the meaning unchanged are allowed.
- When a decision is folded into another, reduce it to its title, status lines and a pointer to the decision that now holds it.
- When compacting a decision, move anything still useful into the appropriate documentation rather than discarding it.
- Keep a clear link between decisions and the journal entries or documentation that provide context and evidence for them.

### Compliance Checklist

Before reporting a decision-record task complete, check each record and report any
exceptions or unchecked items:

- It states a distinct binding choice that guides later work; it is not a design
  document, implementation plan or a restatement of an existing decision.
- The record contains enough scope, rules and context to apply it correctly without
  reconstructing essential constraints from linked documents.
- Every section and metadata line adds useful information. Empty template sections,
  administrative ceremony, repeated summaries, rules, rationale and obvious
  consequences have been removed.
- Greater design detail lives in linked design documents. Nothing links to an
  implementation plan, delivery order or implementation status, or states details likely
  to go out of date. Links resolve, and removing detail has not removed binding
  constraints or useful evidence.
- Alternatives and consequences are included only where they add real information;
  deferred possibilities are distinct from accepted rules.
- The required confirmation was obtained for creating or amending the record, and
  changes preserve the existing decision's meaning or follow the supersession rules.

## Backfilling a Decision Log

- Offer to backfill the decision log by identifying and recording important decisions that have already been made in the project.
- Gather candidate decisions already established in the project, from design documents, the journal, `README*`, and the code's structure and dependencies.
- Present them as a short list, each with a one-line summary and its evidence.
- Record only the candidates the user confirms.
- List unconfirmed or still-emerging candidates as deferred in a journal entry when the project keeps a journal; otherwise report them.
