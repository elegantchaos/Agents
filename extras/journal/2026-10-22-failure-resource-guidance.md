# Failure Handling And Resource Ownership

Date: 2026-10-22

Applied the approved section for finding 6 of the [standards review](2026-10-22-standards-review.md), after Interfaces And Dependencies in the implementation reference. The six rules cover explicit failure and cancellation outcomes, partial completion, actionable error propagation without secrets, resource ownership and cleanup, cancellation and work lifetimes, bounded safe retries, and contract-driven transactions or recovery.

Retries and recovery machinery require a concrete need; the section does not introduce a default requirement for compatibility or data preservation. Both baseline plugin manifests advance to 0.8.6 under the root README's guidance-versioning rule.

Validation: manual checklist review checked the six rules against the approved wording, their placement, consistency with existing principles and data-preservation defaults, journal accuracy, and matching manifest versions. Final diff and whitespace checks passed. No behavioral tests were needed or run for this documentation edit. No plugin installation or cache refresh was performed; agent behavior remains untested.
