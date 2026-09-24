# Claude Integration Plan

Plan for making this repository work equally well with Codex and Claude Code.
Work through the stages in order; each stage is independently useful.
Tick items off as they land, and record decisions inline.

## Current State

- Codex reads `AGENTS.md`. Claude Code v2.1.277+ reads a project's `AGENTS.md` when no project `CLAUDE.md`, `.claude/CLAUDE.md`, or `CLAUDE.local.md` exists in the working directory or above it. `~/.claude/CLAUDE.md` does not block this and loads alongside.
- Claude Code has no global `AGENTS.md`; global instructions must come from `~/.claude/CLAUDE.md`.
- `~/.claude` has no `settings.json`.
- `SKILL.md` frontmatter (`name`, `description`) is already compatible with Claude Code.
- `agents/openai.yaml` files are Codex-only UI metadata; Claude ignores them, so they can stay.
- Codex-specific pieces: `runtimes/codex/rules/*.rules`, `runtimes/codex/config.toml.template`, `runtimes/codex/mcp.toml`, `plugins/swift/.codex-plugin/`, the `codex-git` skill, and parts of the `refresh` skill.

## Decisions

- `COMMON.md` is opt-in per project, never loaded globally. Each project's `AGENTS.md` references it explicitly.
- The voice is a personal preference, so it lives in the user-global files only, never in `COMMON.md` or project files.

## Stage 1: Instruction Loading

Goal: both runtimes load the chosen voice globally and each project's `AGENTS.md`.

- [x] Rename voice files to space-free names so they can be imported.
- [x] Remove the voice section from `COMMON.md`.
- [x] Create `~/.claude/CLAUDE.md` containing `@~/.local/share/agents/voices/voice-3.md`.
- [x] Replace the inline voice copy in `~/.codex/AGENTS.md` with a symlink to `voices/voice-3.md`.
- [x] Confirm Codex follows the `~/.codex/AGENTS.md` symlink.
- [ ] Document the global voice setup (both runtimes) in `README.md` First Use, since it lives outside the repository.
- [x] Update `plugins/baseline/skills/refresh/references/local-mode.md` so a local refresh never creates a project `CLAUDE.md`, and warns when one (or `CLAUDE.local.md`) exists, since it stops Claude Code reading `AGENTS.md` by default.

Project `CLAUDE.md` files that import `AGENTS.md` are not needed: Claude Code reads `AGENTS.md` natively. Fall back to a `CLAUDE.md` containing `@AGENTS.md` only for sessions where native support is unavailable (third-party providers such as Bedrock, or telemetry disabled).

Verify: start a Claude Code session in this repo, confirm the `AGENTS.md loaded` notice, and run `/memory` to confirm the voice file is loaded.

## Stage 2: Single-Source Baseline

Goal: stop restating `COMMON.md` inside every project `AGENTS.md`.

Generated `AGENTS.md` files both say "read `COMMON.md` first" and restate it under `Standard Rules`. That violates DRY, and the restated copy drifts from the source.

Replace the restated `Standard Rules` with one import line, written without backticks so Claude Code expands it:

```markdown
Read and follow @~/.local/share/agents/COMMON.md before starting work.
```

Claude Code expands the `@` import at launch (after a one-time approval per project, because the path is outside the project). Codex has no import syntax and reads it as an instruction to open the file, which matches today's behaviour.

- [x] Update the refresh skill's output contract: project `AGENTS.md` keeps `Project Specific Rules`, the `COMMON.md` import line, `Skills`, and explicit overrides only.
- [x] Rewrite the `Baseline Verification` section of `local-mode.md` to check the import line is present instead of checking per-project restatement.
- [x] Refresh this repository's own `AGENTS.md` under the new contract.
- [ ] Refresh other projects' `AGENTS.md` files as they are next worked on.
- [x] Slim `COMMON.md` to always-on rules (about 280 words, roughly 380 tokens); coding standards and project records move to the `baseline` plugin. TDD stays always-on.

Verify: in a fresh session of each runtime, the baseline rules appear exactly once; in Claude Code, `/memory` lists `COMMON.md` as imported.

## Stage 3: Skill Linking

Goal: shared skills are discoverable by both runtimes.

Claude Code does not read `~/.agents/skills`, so `~/.agents` is retired. `agt skills link` links each skill into `~/.codex/skills` and `~/.claude/skills` (honouring `CODEX_HOME` and `CLAUDE_CONFIG_DIR`), and refuses to replace anything that is not a symlink.

- [x] Extend `agt skills link` and `agt skills status` to handle both runtime directories.
- [x] Update `~/.agents/skills` references in `README.md`, `runtimes/codex/README.md`, and the refresh skill.
- [x] Release `agt` 2.0.1 and run `agt skills link`.
- [x] Confirm Codex still loads user skills from `~/.codex/skills` (verified, although its current docs only list `~/.agents/skills`).
- [x] Remove the stray `~/.codex/skills/validation-flow` link and the third-party `find-skills` skill.
- [x] Confirm nested submodule skills (`swift-concurrency-pro`, `swift-testing-pro`, `swiftdata-pro`) resolve correctly in Claude Code.

Verify: skills appear in each runtime's skill list and trigger from their descriptions.

## Stage 4: Runtime-Neutral Skills

Goal: skill names and content do not assume Codex.

- [ ] Rename `codex-git` to a neutral name (for example `git-workflow`); update the submodule, runtime links, and every `AGENTS.md` that references it.
- [ ] Rewrite its "Sandboxing and Escalation" section as conditional guidance ("if your environment sandboxes `.git/` writes…") with short per-runtime notes.
- [ ] Generalise `plugins/baseline/skills/refresh/references/global-mode.md`: replace `<codex-home>`-only assumptions with per-runtime locations.
- [ ] Update the refresh skill's `default_prompt` wording so it does not rely on Codex's `$refresh` syntax alone (Claude invokes skills as `/refresh`).
- [ ] Sweep remaining skills for Codex-only terminology.

## Stage 5: Command Permissions

Goal: one source of truth for pre-approved commands, generated into both runtimes.

Deferred: Claude auto-approval is being trialled and may make curated Claude allow rules unnecessary. Revisit after the trial; a small shared deny list may be the only part worth generating for Claude.

Codex `prefix_rule(pattern=["git", "add"], decision="allow")` maps to Claude Code `permissions.allow: ["Bash(git add:*)"]` in `~/.claude/settings.json`.

- [ ] Decide the source format: keep `runtimes/codex/rules/*.rules` and translate, or move to a neutral list (command prefix plus decision) and generate both. *(decision needed)*
- [ ] Extend `agt rules sync` to generate the Claude `permissions` block.
- [ ] Merge into `~/.claude/settings.json` rather than overwriting it; the file also holds unrelated settings.
- [ ] Extend `agt rules status` to report drift in Claude settings, including locally added entries worth promoting.
- [ ] Add a sanitised Claude settings template alongside the Codex config template.

Verify: an allowed command such as `git status` runs without a prompt in Claude Code; a non-listed command still prompts.

## Stage 6: MCP Servers

Goal: one MCP server list usable by both runtimes.

- [ ] Decide whether to generate both configs from one list or keep a matched pair of reference files. *(decision needed)*
- [ ] Add the Claude equivalent of `runtimes/codex/mcp.toml`: user-scope servers via `claude mcp add --scope user`, or a project `.mcp.json` where appropriate.
- [ ] Keep secrets as placeholders (for example the Excalidraw token) and machine-local paths (for example `cupertino`) out of shared files.

## Stage 7: Swift Plugin Packaging

Goal: `plugins/swift` installs in both runtimes from the same `skills/` directory.

- [x] Check the current Claude Code plugin and marketplace manifest schema against the official docs before writing files.
- [x] Add `plugins/swift/.claude-plugin/plugin.json` alongside `.codex-plugin/plugin.json`.
- [x] Add repo-root marketplaces: `.claude-plugin/marketplace.json` (Claude Code) and `.agents/plugins/marketplace.json` (Codex).
- [x] Seed the plugin with direct copies of all six Swift skills (`swift:language`, `swift:swiftui`, `swift:concurrency`, `swift:testing`, `swift:swiftdata`, `swift:validation`); retire their standalone submodules; add LICENSE and NOTICE.md.
- [x] Install in both runtimes; both name the skills `swift:<skill>`.
- [ ] Confirm the plugin skills appear in a fresh Claude Code desktop session.
- [ ] Archive the six former Swift skill repositories on GitHub with a pointer to the plugin (deferred).
- [ ] Keep plugin versions in sync between the two manifests (or generate one from the other).

## Stage 7b: Baseline Plugin

Goal: our cross-language skills ship as a plugin, and `COMMON.md` holds only always-on rules.

- [x] Create `plugins/baseline` with `baseline:standards` (from `coding-standards-skill`), `baseline:records` (new, from `COMMON.md`), and `baseline:refresh` (moved from `skills/refresh-skill`, with `scripts/ensure-agt.sh`).
- [x] Move procedural guidance out of `COMMON.md` after checking each rule is covered by the owning skill.
- [x] Retire the `coding-standards-skill` submodule and update references.
- [x] Remove the obsolete `skills/refresh-skill` repo-local path from `agt`.
- [x] Retire the `install-mint` and `install-release-tools` skills: both plugins carry `scripts/ensure-agt.sh`, which installs Mint (via Homebrew) and AgentTools, and `--update` installs the latest release.
- [x] Move `validate` from `rt` into `agt` (AgentTools), then switch `swift:validation` to `agt` via its `ensure-agt.sh`.
- [x] Let both runtimes' sandboxes write the caches Swift validation needs: `scripts/configure-sandboxes`, run by `scripts/refresh`, merges this machine's SwiftPM cache and clang module cache paths into `~/.claude/settings.json` and `~/.codex/config.toml`.

## Stage 8: Layout and Docs

Goal: repository structure and docs treat both runtimes as peers.

- [x] Move `codex/` to `runtimes/codex/` and update every path reference; requires `agt` 2.0.0 or later.
- [ ] Add `runtimes/claude/` when the first Claude template or note lands.
- [ ] Update `README.md` First Use and Shared Rules for both runtimes.
- [ ] Update the `refresh` skill so its global pass maintains both runtimes.
- [ ] Remove this plan, or reduce it to a short "Runtime Support" section in `README.md`, once all stages are complete.

## Deferred

Claude-only features are out of scope until a concrete need appears:

- hooks (for example enforcing validation before stop)
- subagent definitions
- output styles

OpenCode is not in use. If it returns: it already reads skills from `~/.claude/skills` and project `AGENTS.md` files; symlink `~/.config/opencode/AGENTS.md` to the chosen voice file, because OpenCode does not expand the `@` import in `~/.claude/CLAUDE.md`.
