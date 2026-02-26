# Scripts

Reusable scripts are organized by project type and technology.

Inclusion rule:

- only include script templates whose script names appear in multiple local repos

## Layout

- validation is handled via `codex/skills/validation-flow/` (`rt validate`)
- `xcode-app/release/`: release/submission scripts (including ReleaseTools workflows)
- `xcode-app/build-phases/`: scripts intended for Xcode build phases
- `xcode-app/diagnostics/`: local troubleshooting scripts

## Validation Flow

- Standard post-change validation should use the `validation-flow` skill at `codex/skills/validation-flow/`.

## First-Pass Sources

Categorization and inclusion are based on:

- `Stack/Extras/Scripts`
- `ActionStatus/Extras/Scripts`

See `catalog.md` for mapping notes and recommended placement.

## Conventions

- Prefer writing Swift CLI scripts where practical.
- Keep scripts idempotent where practical.
- Prefer explicit arguments/environment variables over hard-coded project names.
- Add header comments with purpose and usage.
- Keep templates in this repo; copy and specialize in individual projects.
