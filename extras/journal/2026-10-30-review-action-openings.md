# 2026-10-30 Review Sections Lead With Actions

Sam's feedback on Bookish PR #119's review was that codebase-effect sections mixed recommendations with descriptions of current behaviour. Each section now starts with its recommended actions, distinguishing immediate fixes from later opportunities, before giving the supporting assessment and evidence.

When nothing needs doing, the opening is a brief sentence specific to the concern: for example, "No action needed", "No simplifications recommended", "No duplication found" or "No design changes recommended". The same structure applies to the corresponding whole-codebase sections. The report templates and checklist reflect it; recommendations are not manufactured to fill sections.

Added to existing Agents PR #40 as a separate commit at Sam's request. Both baseline manifests advance to 0.8.23. The calendar guidance's AgentTools release prerequisite remains unchanged. Return point: review and merge #40 after that prerequisite is met, then refresh the baseline plugin; installed copies are unchanged by this source update.

Validation: review skill metadata validator, matching manifest versions, whitespace checks and manual comparison with the revised Bookish report. No executable changes, new behavioral agent evaluation or installed-plugin refresh.

## Follow-up: Bold No-Action Openings

Sam requested bold no-action sentences so they stand out alongside the recommended-action labels. The skill now requires the whole opening sentence to be bold, and the Bookish review demonstrates it. Both baseline manifests advance to 0.8.24; the merge and refresh return point is unchanged. Skill metadata, manifest consistency and whitespace checks passed.
