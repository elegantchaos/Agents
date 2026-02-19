# Scripts

Reusable scripts are organized by project type and technology.

## Layout

- `xcode-app/validation/`: validation scripts for Xcode application repos
- `xcode-app/release/`: release/submission scripts (including ReleaseTools workflows)
- `xcode-app/build-phases/`: scripts intended for Xcode build phases
- `xcode-app/diagnostics/`: local troubleshooting scripts
- `swift-cli/validation/`: scripts for Swift command-line/package repos

## First-Pass Sources

Initial categorization is based on:

- `Stack/Extras/Scripts`
- `ActionStatus/Extras/Scripts`

See `catalog.md` for mapping notes and recommended placement.

## Conventions

- Keep scripts idempotent where practical.
- Prefer explicit arguments/environment variables over hard-coded project names.
- Add header comments with purpose and usage.
- Keep templates in this repo; copy and specialize in individual projects.
