# Reviews Assess Design Consequences

Bookish PR #115's review reported search commands prominently in its codebase-effect sections. Although implementation contracts were read and compared, the report did not adequately substantiate its broader structural conclusions. Sam asked for reviews to identify obsolete concepts, types and designs, structural simplifications and duplicated responsibilities, including machinery that remains referenced.

Replaced the baseline review skill's codebase-effect instructions with concept, responsibility, invariant and ownership analysis. Searches locate evidence and check completeness; the assessment traces implementation across affected boundaries and explains what could disappear, who would take over its responsibility and why retained distinctions still matter. The special-case guidance retains the instruction to question restrictions of a general mechanism that force separate representations. Dead-reference checks remain useful supporting checks.

Reports now present structural conclusions, implementation evidence and coverage limits. Detailed search and file inventories remain in working notes unless needed to reproduce a finding. The general evidence rule, diff/package template, entire-codebase template, cross-reference and checklist agree. Reviews remain proportional to scope and need not invent refactoring findings. Both baseline plugin manifests advance to 0.8.20.

Sam approved the proposed skill edits and requested a commit and PR. No project design or decision record changes are included. The skill-creator metadata validator passed; both plugin manifests parse as JSON and declare baseline 0.8.20; diff whitespace checks passed. Manual review checked the instructions, both report templates, cross-reference and checklist for consistency. No executable code changed. Runtime plugin installation was left for the normal refresh after merge. Real-review behaviour remains to be evaluated on subsequent work; static checks cannot establish that reviews improve.

## Follow-Up: PRs Start Ready For Review

Sam clarified that PRs are normally opened at the point review begins. The Git skill now defaults to ready for review, reserving drafts for explicitly early, incomplete PRs or a user's draft request. The creation step and read-back check follow that rule. The same baseline 0.8.20 update includes this change, and PR #37 is marked ready for review. The Git skill metadata validator and diff whitespace checks passed; no runtime installation was performed.

## Follow-Up: Review Existing Validation Evidence

Sam asked to avoid routine validation reruns during review. The review skill now inspects existing evidence for the reviewed revision, reporting its scope, result and gaps. A targeted run needs a specific concern or missing, stale or inconclusive evidence; full application validation remains the merge workflow's gate. Reporting and the checklist distinguish previous validation inspected from checks run during review. The skill metadata validator and diff whitespace checks passed; no executable code changed or runtime installation was performed.
