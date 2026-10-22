# Explicit Data Preservation Requirements

Date: 2026-10-22

Sam clarified that the compatibility guidance deliberately prevents unsolicited preservation work for disposable data, including unreleased and internal software. Release status alone does not establish a preservation requirement. Finding 2 of the [standards review](2026-10-22-standards-review.md) is withdrawn as a general defect; the original recommendation would encourage unnecessary work.

Applied the approved replacement to the implementation reference: data preservation is required only when project documentation explicitly requires avoiding data loss, preferably in the project-specific section of AGENTS.md. Otherwise, existing data is assumed resettable, and agents must not add migrations, schema-version handling, or preservation layers merely to retain it. Required preservation work stays scoped to the documented requirement. Included an example project rule; it is not a preservation requirement for this repository.

This is design guidance about preservation support, not authorization to execute a destructive reset. The shared rule requiring explicit approval for irreversible destructive actions still applies.

The change joins the pending baseline 0.8.3 adapter-guidance update. No decision record or project-specific preservation rule was added.

Validation: standards skill quick_validate passed using the shared Python environment. Content checks confirmed all three approved clauses and the example occur once; both plugin manifests parse and retain pending version 0.8.3; journal links resolve; `git diff --check` passed. Manual checklist review covered the changed implementation reference, journal entry, and index for approved scope, factual wording, historical accuracy, and consistency with governing instructions. Runtime tests were skipped because no executable behavior changed. No plugin installation or cache refresh was performed; agent behavior remains untested.
