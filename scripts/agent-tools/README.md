# agent-tools

A SwiftPM command-line tool for maintaining the shared agents repository.

## Usage

Run from the repository root (`~/.local/share/agents`):

```bash
swift run --package-path scripts/agent-tools agent-tools <command>
```

Or, if installed on `$PATH`:

```bash
agent-tools <command>
```

## Commands

### `skills sync [--all | <skill>...]`

Initialize or update public skill submodules to recorded revisions.

```bash
swift run --package-path scripts/agent-tools agent-tools skills sync --all
```

### `skills link`

Link discovered skills into `~/.agents/skills`.

```bash
swift run --package-path scripts/agent-tools agent-tools skills link
```

### `skills status`

Report submodule status and runtime skill symlink health.

```bash
swift run --package-path scripts/agent-tools agent-tools skills status
```

### `skills audit [--all | <skill>...]`

Audit one or more skills for publication blockers.

```bash
swift run --package-path scripts/agent-tools agent-tools skills audit --all
```

## Skill Discovery

Skills are discovered from two sources:

- **Submodules** — registered `skills/*` paths in `.gitmodules`.
- **Repo-local** — a fixed allowlist of paths tightly coupled to this repository (e.g. `skills/refresh-skill`).

Each source is scanned for a `SKILL.md` containing a `name:` front-matter field, which becomes the runtime link name under `~/.agents/skills/`.

## Environment Variables

| Variable            | Description                                                                     |
| ------------------- | ------------------------------------------------------------------------------- |
| `AGENTS_REPO_ROOT`  | Override repository root detection. Set to the absolute path of the repository. |
| `AGENTS_SKILLS_DIR` | Override the runtime skills directory. Defaults to `~/.agents/skills`.          |

## Repository Root Detection

When `AGENTS_REPO_ROOT` is not set the tool walks up from the current directory looking for a directory that contains all of:

- `skills/`
- `codex/`
- `Package.swift` or `scripts/agent-tools/Package.swift`

## Source Layout

```
Sources/AgentTools/
  AgentToolsCommand.swift      — top-level @main entry point
  SkillsCommand.swift          — `skills` subcommand group
  SkillsAuditCommand.swift     — `skills audit` subcommand
  SkillsLinkCommand.swift      — `skills link` subcommand
  SkillsStatusCommand.swift    — `skills status` subcommand
  SkillsSyncCommand.swift      — `skills sync` subcommand
  SkillsPublicTool.swift       — discovery, syncing, linking, status, and audit logic
  RepoRootLocator.swift        — repository root resolution
  SkillSelection.swift         — selection mode type
  DiscoveredSkill.swift        — model for a discovered skill
  LinkTarget.swift             — model for a runtime symlink target
  CommandResult.swift          — subprocess result capture
  ToolError.swift              — user-facing error type
Tests/AgentToolsTests/
  RepoRootLocatorTests.swift   — unit tests for root detection
```
