# Common Rules

These are the terse shared baseline rules that belong in `Standard Rules`.
Keep detailed cross-language, language-specific, and shared-baseline-maintenance guidance in dedicated skills or focused reference modules rather than expanding this file into a second source of truth.

## Methodology & Principles

Always write good code.

Apply these core principles when writing code:

### Required

- DRY (Avoid Duplication Thoughtfully)
- Single Source Of Truth

### Preferred

- KISS (Keep It Simple)
- YAGNI (Build What Is Needed)
- Make Illegal States Unrepresentable
- Dependency Injection
- Composition Over Inheritance
- Command-Query Separation
- Law of Demeter
- Structured Concurrency
- Design by Contract
- Idempotency

## Core Workflow Expectations

1. Understand request boundaries.
2. Inspect relevant code/docs before editing.
3. Apply the smallest coherent change set.
4. Add/update tests for behavior changes.
5. Run relevant validation checks.
6. Report changes, validation status, and residual risks.

## Testing

Use red/green TDD for non-UI code.
Create previews for SwiftUI code.
Follow the validation workflow and report gaps.

## Research and Source Quality

- Use trusted primary sources for technical decisions.

## Portability

- Use portable path references in docs and guidance. Prefer repository-relative paths for files in the current repository and `~/...` home-relative paths for shared resources outside it. Avoid machine-specific absolute paths.

## Safety and Discipline

- Never expose or commit credentials/secrets.
- Do not perform irreversible destructive actions without explicit approval.
- Reversible changes inside source control, including deletion of tracked files, do not require special approval beyond the user’s request.
- Avoid unrelated refactors during focused tasks.
- If unexpected workspace changes appear, pause and confirm direction.

## Xcode MCP

For Xcode projects, if the Xcode MCP is configured, prefer its tools over generic alternatives:

    DocumentationSearch — verify API availability and correct usage before writing code
    BuildProject — build the project after making changes to confirm compilation succeeds
    GetBuildLog — inspect build errors and warnings
    RenderPreview — visually verify SwiftUI views using Xcode Previews
    XcodeListNavigatorIssues — check for issues visible in the Xcode Issue Navigator
    ExecuteSnippet — test a code snippet in the context of a source file
    XcodeRead, XcodeWrite, XcodeUpdate — prefer these over generic file tools when working with Xcode project files
