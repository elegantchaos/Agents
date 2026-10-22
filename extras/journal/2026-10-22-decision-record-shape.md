# Decision Record Shape

Date: 2026-10-22

Working on Bookish's decision log, Sam set out how decision records should be shaped, and
asked for the records skill to carry it so new decisions conform.

The records skill's Decisions section now has four parts:

- **What to record:** a decision guides where future code goes or how it must behave. A
  design change that follows from existing decisions belongs in documentation and the
  journal.
- **Confirming:** the existing separate-question rule, unchanged.
- **Shape:** title and status lines, then Decision first with no added summary, then a
  Context of one to three sentences only when the decision needs placing in the project,
  then Details for secondary rules, then compact Alternatives and Consequences. Revision
  lines give dates only. Consequences hold only obligations and non-obvious effects, with no
  migration or reset notes. The reason is that decision records are read in full into agent
  context.
- **Changing decisions:** the rewrite and supersession rule, plus reducing a folded decision
  to a pointer, and moving useful detail into documentation when compacting.

The two overlapping "keep decisions concise" bullets are merged into the Shape guidance.
Both baseline manifests advance to 0.8.9 under the README's guidance-versioning rule; the
refresh session's 0.8.8 bump had not been committed.

Validation: manual review of the changed skill. `agt skills audit` covers only public skill
submodules, so no automated check applies. The new plugin version has not been installed.
