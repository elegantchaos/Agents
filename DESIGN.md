(TODO: move this into an appropriate skill)

This describes the structure that all our design documents should follow.

# Principles

## Progressive disclosure

Start with the broad-brush overview, and the most important information.

Follow on with more detailed sections where appropriate.

Reserve very specific detail for later within a section.

Non-essential or highly specific detail that provided for interest only should live in an appendix.

## Currency

The design document should describe the current design.

As the document is revised, we should avoid previous designs leaking in to the document. We should avoid sentences that answer a question that only someone who knew the history would ask, or refer to previous designs.

Historical references should be reserved for an appendix if requested, or omitted altogether.

An exception to this rule may be made when a document is an explicit redesign and needs to refer to the previous design. This should only apply for major explicit redesigns, and not for the small incremental revisions that occur frequently during development.

# Structure

## Overview

A design document should start with a short conceptual overview, then a detailed design with one section per concept.

### Terminology

A terminology section should summarize critical terminology used within the document.

Although it is tempting to put this first, before the overview, that should not be done. It is ok for the overview to use terms which are then defined in this section.

Entries should be a single line per term, and not be abused as a place to put actual design.

Not every term should be recorded here, only the most fundamental ones, and only if there is room for ambiguity.

Probably no more than 10 items here?

This complements the project-wide GLOSSARY.md, and doesn't replace it. Terms that warrant inclusion in this section may be out of scope for the main glossary.
