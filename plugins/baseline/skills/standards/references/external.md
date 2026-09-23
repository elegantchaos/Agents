# Trusted External Sources for Technical Decisions

Use this file whenever technical decisions depend on uncertain facts, API behavior, tooling semantics, policy requirements, or external references.

This file defines cross-language source-selection policy.
Ecosystem-specific source lists belong in language or framework skills.

## Source Selection Rules

- Prefer official vendor documentation, language specifications, standards, RFCs, and primary proposals.
- Prefer first-party repositories and official package documentation for dependencies and tools.
- Prefer project-local documentation and checked-in dependency docs before broad web search when they are relevant and current.
- Treat blogs, forum posts, AI-generated summaries, and community tutorials as secondary context.
- When sources conflict, defer to official or primary references and note the conflict.

## Source Categories

### Language and runtime behavior

- language specifications
- official language books or documentation
- primary language-evolution proposals
- compiler or runtime documentation

### Frameworks, libraries, and tools

- official vendor documentation
- first-party repositories
- package-manager pages maintained by the publisher
- official release notes and migration guides

### Policies, standards, and protocols

- official policy documents
- formal specifications
- standards bodies and RFCs

### Project-local evidence

- repository-managed documentation
- checked-in dependency READMEs and package docs
- toolchain configuration, manifests, and lockfiles already present in the repository

## MCP-Indexed Sources

Prefer indexed primary docs via MCP tools before broad web search when the host provides them.

## Secondary Sources

Secondary sources are useful for orientation and cross-checking, but they are not final authority for API contracts, language semantics, or policy requirements.

## Trusted Authors

- Martin Fowler
- Kent Beck
- Hunt & Thomas (Pragmatic Programmer)
