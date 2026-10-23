# Review: Design Document Shape

Date: 2026-10-23

## Summary

Diff review of the proposed guidance in the untracked root `DESIGN.md`, on
`feature/tweaks`. The aim is consistent, readable design documents with progressive
disclosure and no accumulated revision history. Ready after the clarifications below;
the proposed owner is `baseline:records` in the baseline plugin. This repository has
no decision log.

## Findings

1. **Should fix — distinguish design from implementation status.** `DESIGN.md:19`
   says “current design” without defining whether that means intended design or
   implemented behavior. The standards skill's `references/implementation.md:96-100`
   describes current behavior while allowing planning documents. Say that a design
   describes the current intended design in the present tense, with a brief proposal
   status when needed. Keep implementation progress, gaps and delivery sequencing in
   a linked implementation document or journal. Mark unresolved design questions
   explicitly so they cannot be mistaken for agreed rules.
2. **Should fix — keep essential constraints in the main text.** `DESIGN.md:13-15`
   groups “highly specific” detail with non-essential material. Precision can be
   essential: invariants, ownership, failure behavior and boundary contracts may
   determine whether a design works. Reserve appendices for optional supporting
   detail; retain required rules in the relevant concept section. Omit material
   that adds no useful context.
3. **Suggestion — make the document outline explicit.** `DESIGN.md:29-35` nests
   Terminology under Overview and describes the detailed design inside Overview.
   Show sibling sections: Overview, Terminology when needed, concept sections,
   Open Questions when needed, and optional Appendices. The overview should state
   purpose, scope and the central model. Each concept should begin with its role
   and relationships, then develop its contracts and detail. Scale the outline to
   the document; avoid mandatory empty sections.
4. **Suggestion — make terminology guidance practical.** `DESIGN.md:39-45` uses
   a physical single-line rule, an uncertain ten-item cap and an assumed
   `GLOSSARY.md`. Require one concise definition per entry; aim for roughly ten
   terms and split the document or link definitions if substantially more are
   needed. Reuse and link the project glossary when one exists. Include only local
   or ambiguous terms, without duplicating design rules or redefining shared terms.
5. **Suggestion — bound the redesign exception.** `DESIGN.md:23-25` allows old
   designs back into a major redesign without defining their place. Keep the main
   design self-contained. For an explicit redesign, isolate the necessary comparison
   in a labelled section or appendix and link the rationale in decision records.
   Keep migration steps and implementation history in their own documents. Also fix
   “detail that provided” at line 15 to “detail provided”.

## Codebase Effect

### Made Obsolete

After integration, remove root `DESIGN.md` as a second source of the same guidance.
It remains unchanged during this review.

Checked: `rg -n 'DESIGN\.md|GLOSSARY\.md|Progressive disclosure|## Design Documents|## Documentation' --glob '*.md' --glob '!skills/**' .`
found no callers of root `DESIGN.md`; its terminology and progressive-disclosure
text are unique. Existing documentation headings occur in standards and Swift guidance.

### Simplification Now Possible

Use one owner for document shape, currency and the boundary with project records.
No new plugin or standalone skill is needed for this proposal.

Checked: read `COMMON.md`, `plugins/baseline/README.md`, and the records skill in full.
The existing records introduction already separates core documentation, decisions,
journals and reviews. `COMMON.md` delegates detailed guidance to skills.

### Duplication

Currency guidance overlaps the records introduction and standards documentation
rules. Define the design-document-specific rule once in records; keep standards'
general code-documentation guidance and link to records for design-document shape.

Checked: searched `design document|implementation document|design.*present|documentation|decision`
in the baseline standards references, records skill and root README. Read all four
required standards references in full. General current-behavior rules are in
`references/implementation.md`; record boundaries are in the records introduction.

### Design Clarity

Recommended source: `plugins/baseline/skills/records/SKILL.md`, with a compact
`Design Documents` section before Journal. The proposal is short enough to live
inline; a separate required reference is only useful if it grows substantially.

Expand the records skill's description and opening scope so writing or revising
design documentation selects it even when a project has no journal or decision-log
opt-in. Keep those opt-ins specific to journals, decisions and reviews. Update the
baseline README's ownership row, add a pointer from standards' Documentation
section, and clarify the records introduction's treatment of intended design.
When implementing, bump both baseline plugin manifests as required by the root
README and refresh installed copies through the existing workflow.

Checked: read root `README.md`, `.gitmodules`, `AGENTS.md`, the baseline README,
the records skill and the refresh skill's global/local/checklist references.
Baseline skills are maintained directly under `plugins/baseline/`; installed Codex
copies are cached. Read the journal entries for decision-record shape and
documentation-only validation. File inventories and decision-path searches found
no project decision log.

## Follow-ups

Integrate the revised guidance after Sam chooses the final wording. This review
does not move or revise the proposal, alter shared skills, bump versions, publish
changes, or refresh installed plugins.

## Not Checked

No code, executable behavior or plugin metadata changed, so builds, tests and
plugin packaging checks were not run. No runtime refresh, repository update,
public-skill synchronization, or external research was needed for this scoped
document review. Agent adherence to the proposed wording has not been exercised.
The journal and index were manually checked against the applicable records,
review and standards guidance; `git diff --check` checks tracked changes.
