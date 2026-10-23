# Review: Design Guidance Against Datastore Design

Date: 2026-10-23

## Summary

Document review comparing the updated records skill with Bookish's
`Extras/Documentation/Datastore/Datastore Design.md`. Sam is broadly happy with
the document's shape and requested places where the guidance would produce
something different. The guidance needs refinement before it is a reliable check
for this example; the document's broad structure should be preserved. This is a
review of documentation rules, not an architectural or implementation correctness
review of the datastore.

## Findings

1. **Should fix guidance — permit a conceptual overview with several sections,
   followed by detailed design.** Records skill lines 71-87 require sibling sections
   and place Terminology before concept sections; its checklist requires a short
   overview before concept sections. Datastore Design lines 3-76 provide an opening
   summary, diagram, conceptual Mutations, Mutation Store, Record Store, Reading And
   Observing, Principles, and Terminology, then a separate Detailed Design at line
   78. Literal enforcement could flatten that structure, shorten the conceptual
   introduction and move Terminology before its explanatory sections. Explicitly
   permit this progressive-disclosure structure, including its heading hierarchy
   and a Related Documents section (lines 376-381).
2. **Should fix guidance — allow purposeful repetition between levels.** The
   concept-section instruction says not to repeat definitions or rules. Datastore
   Design explains mutations at lines 15-25 and again in detail at lines 207-257;
   it describes store responsibilities in the introduction and restates them briefly
   in the ten-entry terminology list (lines 67-76). This is useful orientation.
   Prohibit redundant competing specifications, while allowing concise summaries
   and definitions that make each level intelligible. The document's record,
   mutation and record-store definitions also overlap the project glossary; allow
   consistent local recaps and link the shared definitions. Adding a glossary link
   would be a small document improvement; it currently has none.
3. **Should fix guidance — distinguish references to concrete APIs from descriptions
   of their implementation.** The blanket concrete-type ban would remove the
   Foundation `Predicate` and `SortDescriptor` comparison at line 305. It explains
   the query model's intended capabilities and explicitly permits an equivalent
   API. Permit short illustrative API or technology references without allowing
   implementation wiring or code walkthroughs. CloudKit at line 31 is similarly a
   transport example. Field names (`id`, `created`, `modified`) and the causal and
   conflict algorithms are design contracts and should remain.
4. **Suggestion for guidance — say under the documentation directory, including
   topic subfolders.** The document and its corresponding implementation document
   are in `Extras/Documentation/Datastore/`, not directly in `Extras/Documentation/`.
   Bookish's README explicitly indexes them there and Project Layout lines 182-189
   designate the documentation tree, so the project-convention exception already
   covers this arrangement. Clarify the default to avoid unnecessary flattening in
   other projects. Both filenames already meet the naming rule.
5. **Should fix guidance — separate prior art and deferred options from revision
   history.** Appendix A (lines 385-407) holds future features, while Appendix B
   (lines 409-431) holds CRDT background and prior art. The restriction on historical
   appendices could remove the older ElegantChaos Datastore comparison at line
   423 despite its value as a design reference. Explicitly allow relevant background,
   prior art and clearly deferred possibilities. Keep the restriction on accounts
   of previous revisions. Brief rationale at the point of use, such as the sync
   motivation at line 21 and field-key constraint at line 120, should also remain;
   decision records hold the authoritative binding choice and fuller alternatives.
6. **Suggestion for document — isolate actual implementation-option detail.**
   The schema paragraph's table/file-location examples (line 226) are optional
   implementation mechanisms. The Further Transports paragraph (line 403) sketches
   per-mutation files, sharding, segments, Git operations and Dropbox polling. Strict
   enforcement moves these mechanisms to implementation documentation, leaving the
   design-level schema-version ownership contract and possible transports in place.
   The rule should distinguish these tentative mechanism sketches from the useful
   conceptual future-feature sections around them. This does not require changing
   the appendix structure.

## Codebase Effect

### Made Obsolete

No changes made to the document or skills. No wholesale section removal is warranted.

Checked: read all 431 lines of Datastore Design and inspected all three embedded
diagrams. Searches for `Extras/Documentation|Design\.md|implementation detail|design document`
in shared baseline guidance located the applicable records rules and standards pointer.

### Simplification Now Possible

A general rule permitting conceptual overview followed by detailed design explains
the document without a project-specific exception for its heading structure.

Checked: compared the records skill's Scope, Naming, Currency, Shape and Compliance
Checklist with every section of Datastore Design. The diagram and algorithms remain
conceptual, without concrete implementation walkthroughs.

### Duplication

Brief repetition between overview, terminology and details aids navigation. Avoid
making readers follow links for every familiar term; require consistent definitions
and one authoritative detailed contract.

Checked: read Bookish's glossary in full and compared record, mutation, record store,
projection, link and conflict terminology with the design. Local terminology has ten
entries, each a concise definition; no incompatible definition was identified in this
shape comparison.

### Design Clarity

The existing separation from Datastore Implementation is useful and should remain.
The naming convention already fits. The location needs a wording clarification in
shared guidance, not a document move.

Checked: read Bookish `AGENTS.md` and README, Project Layout's Extras directory
convention, and Datastore Implementation's opening and detailed status/planning
sections. Enumerated and read all 47 decision records in full, including the draft
and folded records, for context. No decision changes are proposed. A local link
check resolved all 26 local file/anchor references from Datastore Design.

## Follow-ups

Refine the shared rules and checklist around the differences above if approved.
Optionally link the glossary and move the small mechanism sketches into implementation
documentation. Sam requested a comparison, so neither document nor skill was edited.

## Not Checked

No code, builds, tests, runtime behavior, external reference content, live Excalidraw
scenes, or architectural implementation conformance were checked: this review assesses
the guidance's effect on document content and structure. Linked documents other than
the glossary and the implementation/status sections needed for this comparison were
not reviewed in full. No claims about the datastore's implementation correctness or
complete architectural compliance are made. The journal and index were manually
checked against the applicable guidance; local links and whitespace were checked.
