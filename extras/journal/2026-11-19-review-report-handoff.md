# Review Report Handoff

Sam asked for a standard handoff between agents. The [review skill](../../plugins/baseline/skills/review/SKILL.md) now requires a Markdown report in the project's reviews directory, defaulting to `Extras/Reviews/`. The reviewer records the reviewed revision and commits and pushes the report to the reviewed branch. For a PR, that means its head branch. Branches that require changes through a PR get a report-only PR targeting the reviewed branch.

The [records skill](../../plugins/baseline/skills/records/SKILL.md) delegates report placement and publication to the review skill so the handoff also applies in projects without an explicit review-log opt-in. Baseline plugin 0.8.37.
