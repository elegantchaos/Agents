# Adapter Guidance

Date: 2026-10-22

Applied Sam's approved wording for finding 1 of the [standards review](2026-10-22-standards-review.md). The compatibility rule prohibits layers that preserve superseded APIs or behavior unless compatibility support is explicitly requested. The interface rules allow wrappers and adapters with a concrete, explained responsibility, such as external contract translation, isolation, or resource lifetime management, and prohibit forwarding or translation layers added merely to make a design appear compliant.

The change is limited to that finding. Both baseline plugin manifests advance to 0.8.3 under the root README's guidance-versioning rule. The original review remains a historical record.

Validation: standards skill quick_validate passed using the shared Python environment. An exact-content check confirmed implementation.md contains only the approved replacements relative to HEAD. Both manifests parse and declare baseline 0.8.3; journal links resolve; `git diff --check` passed. Manual checklist review covered all changed files for scope, clear factual wording, consistent packaging, and accurate records. Runtime tests were skipped because no executable behavior changed. Plugin installation and runtime cache refresh were not performed; agent behavior remains untested.
