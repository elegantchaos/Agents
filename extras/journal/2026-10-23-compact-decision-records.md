# Compact Decision Records

Date: 2026-10-23

Sam asked to refine decision-record guidance because all records are intended to be
read in full into each session. Size, repetition and unnecessary bureaucracy consume
context without improving the decisions' usefulness.

The records skill now asks authors to identify a distinct binding choice before
proposing a record. Models, algorithms, component explanations and implementation
plans belong in the corresponding documentation unless they establish such a choice.

Decision records retain the scope, binding rules and context needed to follow them.
Greater detail is linked from design and implementation documents. Sections are
conditional, metadata must earn its place, and repeated summaries, invented alternatives
and obvious consequences are excluded. Context is compact without a rigid sentence
limit that would remove essential constraints.

A decision-record compliance checklist covers record suitability, self-contained
constraints, compactness, linked detail, substantive alternatives and consequences,
and the existing confirmation and supersession rules. Those authorization rules
are unchanged. No project decision records were created or amended.

Both baseline manifests advance to 0.8.15. Validation: skill frontmatter validation,
matching parsed JSON manifests, local Markdown links and whitespace, and manual
review against the records, standards and skill-creator guidance. No executable
behavior changed, so builds and tests were not run. Installed plugins were not
refreshed; behavioral adherence remains untested.
