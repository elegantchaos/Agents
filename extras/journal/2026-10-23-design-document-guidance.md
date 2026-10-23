# Design Document Guidance

Date: 2026-10-23

Sam approved the changes suggested in the [design-document review](2026-10-23-design-document-review.md)
and asked to move the root notes into the skill.

`baseline:records` now owns design-document shape: overview first, optional concise
terminology, one section per concept, explicit open questions and optional appendices.
It distinguishes current intended design from implementation status, keeps essential
constraints in the main text, and bounds the historical context allowed for explicit
major redesigns. The root `DESIGN.md` is removed.

The skill description and scope now select design-writing work independently of
project-log opt-ins. Journals, decisions and reviews still require project opt-in.
The baseline README describes the expanded ownership. Standards' documentation
guidance links to records and distinguishes current behavior from intended design.
Both baseline plugin manifests advance to 0.8.12.

Validation: manual review against the records, standards and skill-creator guidance;
skill frontmatter validation, JSON parsing and matching manifest versions, local
Markdown link checks, and Git whitespace checks. No code or executable behavior
changed, so builds and tests were not run. Installed plugin copies have not been
refreshed; agent adherence to the guidance has not been exercised.

## Follow-up: Explicit Boundaries And Compliance

Sam requested explicit distinctions between design, implementation and usage
documentation; exclusion of implementation details from design; standard names
and a standard home; and a compliance checklist.

The records skill now excludes concrete code types and functions, source file
layouts, framework wiring and code walkthroughs from designs, including appendices.
Contracts, invariants, ownership, failure behavior and design-defining algorithms
remain in design documentation. Implementation documents hold code-specific detail.

The default names are `<Subject> Design.md` and `<Subject> Implementation.md` in
`Extras/Documentation/`, with explicit project conventions taking precedence.
The new design-document checklist covers boundaries, naming, location, currency,
structure, terminology, essential contracts, appendices and working links. Agents
must report exceptions and unchecked items. Both manifests advance to 0.8.13.

Validation: skill frontmatter validation, matching parsed JSON manifests, local
Markdown links and whitespace checks, and manual comparison of the rules with the
checklist. Builds and tests do not apply to this guidance change. Installed copies
remain unchanged, and behavioral adherence has not been tested.

## Follow-up: General Structure And Excalidraw Diagrams

Sam asked to expand the rules around the broad shape of Datastore Design without
carrying over subject-specific details, optionally providing a blank template, and
to require Excalidraw for diagrams that add value.

The skill now permits a multi-section conceptual overview, principles and terminology
before a separately grouped detailed design. It allows consistent brief recaps,
related-document sections, topic subfolders, relevant background and prior art, and
clearly deferred possibilities. Brief API references may explain a conceptual
contract without becoming implementation instructions. Revision history and
implementation mechanics retain their separate homes.

The new `assets/design-document-template.md` demonstrates the reading levels with
generic headings and authoring comments. It contains no datastore content and is
linked from the skill for creation or restructuring. Smaller documents can combine
levels and omit optional sections.

Diagrams are required where they improve understanding of relationships, boundaries,
flows or interactions. They are drawn with Excalidraw, with an embedded rendered
image, linked editable source, and visual checks for clarity and agreement with the
text. The compliance checklist covers the expanded rules and diagram requirements.
Both baseline manifests advance to 0.8.14.

Validation: skill frontmatter validation, parsed and matching manifests, local
Markdown link and whitespace checks, and manual review of the skill, template and
checklist against the approved general structure. No builds or tests were needed;
no diagrams were created because this task changes guidance. Plugin installation
and behavioral adherence remain untested; installed copies were not refreshed.
