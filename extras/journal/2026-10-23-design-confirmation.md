# Design Documentation Confirmation

Date: 2026-10-23

Sam reported that Datastore Design had drifted through repeated rewrites that had
not been properly reviewed, and requested a confirmation rule similar to the one
for decision records.

The records skill now requires proposed text or a diff, followed by a separate
confirmation question naming the documents and summarising the edits. Canonical
documents remain unchanged while drafts are reviewed. Design agreement, code
implementation approval and general documentation-maintenance instructions do not
authorize a design-document rewrite. Confirmed scope cannot grow into an unreviewed
rewrite, compaction or reorganisation; already confirmed edits need no repeat approval.

The gate covers wording, links, diagrams and their sources, renames, moves and
deletions. The design compliance checklist verifies confirmation and the final
diff's scope. Standards' documentation guidance and the design template point to
the gate. No project design documents were changed.

Both baseline manifests advance to 0.8.16. Validation: skill frontmatter validation,
matching parsed JSON manifests, local Markdown links and whitespace, and manual
review against the applicable records, standards and skill-creator checklists.
No executable behavior changed, so builds and tests were not run. Installed copies
were not refreshed; agent adherence has not been tested.
