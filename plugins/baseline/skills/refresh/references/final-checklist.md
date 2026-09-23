# Final Response Checklist

Include the sections for phases that were run.

## Global Pass

- shared agents repository update result
- public skill sync/link/status result
- shared plugin install or refresh result for each runtime, including any runtime skipped because its CLI was not on `PATH`
- skills audited, if audit was run
- runtime skill links changed or retired
- rules moved from `default.rules` into shared files
- rules removed from `default.rules` as redundant
- rules removed from `default.rules` as one-off or machine-specific
- sort and de-dup verification result
- runtime rule copy and generated-header verification result
- runtime rule drift or runtime-only files found before synchronization
- any ambiguous rules that need user confirmation
- any suggested new shared rule files
- any risky broad approvals that deserve review
- any suggested or implemented improvements to workflows, scripts, skills, references, or principles
- the basis for those suggestions when they come from recent usage, repeated friction, source research, or newer platform guidance

## Research Phase

- research questions investigated
- sources used
- additions, revisions, or leave-as-is decisions
- research intentionally skipped and why

## Local Project Pass

- files changed
- modules included and excluded
- evidence used for stack detection
- skills referenced from the `Skills` section
- any shared guidance files explicitly referenced from the `Skills` section
- unresolved local-vs-shared guidance conflicts
- any intentional repository overrides to referenced skills or shared guides
- confirmation that `Standard Rules` is exactly the `COMMON.md` import line
- restated baseline rules removed, and any restated rules moved to `Project Specific Rules` as genuine repository policy
- any `CLAUDE.md`, `.claude/CLAUDE.md`, or `CLAUDE.local.md` found, and what the user decided
- decision log offer: not applicable, declined, or accepted, with the decisions recorded and candidates deferred
