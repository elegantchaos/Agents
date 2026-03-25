# Scripts

Reusable scripts are organized by project type and technology.

Inclusion rule:

- only include script templates whose script names appear in multiple local repos

## Layout

- validation is handled via the `validation-flow` skill (`rt validate`)
- `skills-public/`: audit, extract, and refresh helpers for the repo-per-skill publication workflow
- `xcode-app/release/`: release/submission scripts (including ReleaseTools workflows)
- `xcode-app/build-phases/`: scripts intended for Xcode build phases

## Validation Flow

- Standard post-change validation should use the `validation-flow` skill.

## Conventions

- Strongly prefer writing repository-maintained scripts in Swift.
- Use single-file Swift scripts for small utilities.
- Use Swift command-line apps when the workflow has multiple commands, shared logic, or enough complexity that a single script becomes hard to maintain.
- Keep scripts idempotent where practical.
- Prefer explicit arguments/environment variables over hard-coded project names.
- Add header comments with purpose and usage.
- Keep templates in this repo; copy and specialize in individual projects.
