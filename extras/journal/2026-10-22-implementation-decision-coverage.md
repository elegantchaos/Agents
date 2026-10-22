# Decision Coverage Before Design And Implementation

Date: 2026-10-22

Applied the approved wording for finding 3 of the [standards review](2026-10-22-standards-review.md). The implementation reference now requires complete decision reading before design or code changes when a project maintains a decision log, with applicability determined after reading. Records already read in the conversation are reused unless changed; additional references are read only when needed to understand constraints.

Accepted decisions govern the work; draft and superseded records provide context. Status ambiguity and conflicts are raised before affected work proceeds. Existing patterns and passing tests cannot authorize exceptions. Unread records and unchecked constraints must be reported, and prevent claims of decision compliance. Proposed decision changes remain owned by baseline:records.

Added the corresponding conditional completion checklist item. No decision log, additional reading report, or decision record is required or created by this guidance. Both baseline plugin manifests advance to 0.8.4 under the root README's versioning rule.

Validation: standards skill quick_validate passed using the shared Python environment. Structural checks confirmed five decision rules and one checklist item were added with surrounding guidance unchanged. Both manifests parse and declare baseline 0.8.4; journal links and the records skill resolve; `git diff --check` passed. Manual checklist review covered all changed files for approved scope, conditional applicability, reuse of existing context, consistent packaging, and factual records. This repository has no configured decision log. Runtime tests were skipped because no executable behavior changed. No plugin installation or cache refresh was performed; agent behavior remains untested.
