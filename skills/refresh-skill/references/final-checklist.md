# Final Response Checklist

Always include:

## Global Pass

- shared agents repository update result
- public skill sync/link/status result
- skills audited, if audit was run
- runtime skill links changed or retired
- rules moved from `default.rules` into shared files
- rules removed from `default.rules` as redundant
- rules removed from `default.rules` as one-off or machine-specific
- sort and de-dup verification result
- symlink verification result
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
- confirmation that no `Standard Rules` bullet depends on the current wording of an in-scope skill
- a baseline verification matrix with clause, status (`kept`, `rewritten-equivalent`, or `omitted-intentional`), and location in `AGENTS.md`
- any intentionally omitted baseline clauses with rationale
