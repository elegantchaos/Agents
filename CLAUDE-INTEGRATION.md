# Claude Integration Plan

Plan for making this repository work equally well with Codex and Claude Code.
Work through the stages in order; each stage is independently useful.
Tick items off as they land, and record decisions inline.

## Current State

- Codex reads `AGENTS.md`; Claude Code reads `CLAUDE.md` and ignores `AGENTS.md` unless imported.
- `~/.claude` has no `CLAUDE.md`, `settings.json`, or `skills/`, so Claude Code sees none of the shared baseline.
- `SKILL.md` frontmatter (`name`, `description`) is already compatible with Claude Code.
- `agents/openai.yaml` files are Codex-only UI metadata; Claude ignores them, so they can stay.
- Codex-specific pieces: `runtimes/codex/rules/*.rules`, `runtimes/codex/config.toml.template`, `runtimes/codex/mcp.toml`, `plugins/swift/.codex-plugin/`, the `codex-git` skill, and parts of the `refresh` skill.

## Stage 1: Instruction Loading

Goal: Claude Code loads the shared baseline globally and each project's `AGENTS.md`.

- [ ] Create `~/.claude/CLAUDE.md` containing `@~/.local/share/agents/COMMON.md`.
- [x] Rename voice files to space-free names (for example `voices/voice-2.md`) so they can be imported, and update the reference in `COMMON.md`.
- [ ] Make one voice file the single source; replace the inline voice copy in `~/.codex/AGENTS.md` with the chosen file's content (or a link to it, see Stage 2).
- [ ] Add a root `CLAUDE.md` to this repository containing `@AGENTS.md`.
- [ ] Update `skills/refresh-skill/references/local-mode.md` so a local refresh creates a one-line `CLAUDE.md` containing `@AGENTS.md` when missing, and never adds other content to it.

Verify: start a Claude Code session in this repo and run `/memory` to confirm `COMMON.md`, the voice file, and `AGENTS.md` are loaded.

## Stage 2: Single-Source Baseline

Goal: stop restating `COMMON.md` inside every project `AGENTS.md`.

Generated `AGENTS.md` files both say "read `COMMON.md` first" and restate it under `Standard Rules`. That violates DRY and, once Stage 1 lands, loads the baseline twice in Claude Code.

- [ ] Decide: load `COMMON.md` globally in both runtimes and drop restated baseline from project files? *(decision needed)*
- [ ] Codex: make `~/.codex/AGENTS.md` a symlink to `COMMON.md` (or have `agt` generate it), and confirm Codex follows the symlink.
- [ ] Claude: already covered by the Stage 1 global import.
- [ ] Update the refresh skill's output contract: project `AGENTS.md` keeps `Project Specific Rules`, `Skills`, and explicit overrides only.
- [ ] Rewrite the `Baseline Verification` section of `local-mode.md` to check the global baseline instead of per-project restatement.
- [ ] Refresh this repository's own `AGENTS.md` under the new contract.

Verify: in a fresh session of each runtime, the baseline rules appear exactly once.

## Stage 3: Skill Linking

Goal: shared skills are discoverable from `~/.claude/skills`.

- [ ] Decide between a symlink `~/.claude/skills -> ~/.agents/skills` (simplest) and extending `agt skills link` to write to multiple targets (cleaner, handles machines where `~/.claude/skills` already has content). *(decision needed)*
- [ ] Implement the chosen option and update `README.md` First Use.
- [ ] Confirm nested submodule skills (`swift-concurrency-pro`, `swift-testing-pro`, `swiftdata-pro`) resolve correctly.

Verify: skills appear in Claude Code's skill list and trigger from their descriptions.

## Stage 4: Runtime-Neutral Skills

Goal: skill names and content do not assume Codex.

- [ ] Rename `codex-git` to a neutral name (for example `git-workflow`); update the submodule, runtime links, and every `AGENTS.md` that references it.
- [ ] Rewrite its "Sandboxing and Escalation" section as conditional guidance ("if your environment sandboxes `.git/` writes…") with short per-runtime notes.
- [ ] Generalise `skills/refresh-skill/references/global-mode.md`: replace `<codex-home>`-only assumptions with per-runtime locations.
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

- [ ] Check the current Claude Code plugin and marketplace manifest schema against the official docs before writing files.
- [ ] Add `plugins/swift/.claude-plugin/plugin.json` alongside `.codex-plugin/plugin.json`.
- [ ] Add a repo-root `.claude-plugin/marketplace.json` listing `plugins/swift`, so it installs via `/plugin marketplace add ~/.local/share/agents`.
- [ ] Note in `plugins/swift/README.md` that Claude namespaces plugin skills (`swift:swiftui`), which sidesteps the collision with the standalone `swiftui` skill.
- [ ] Keep plugin versions in sync between the two manifests (or generate one from the other).

## Stage 8: Layout and Docs

Goal: repository structure and docs treat both runtimes as peers.

- [x] Move `codex/` to `runtimes/codex/` and update every path reference; `agt` updated to match (AgentTools `feature/runtimes-layout`).
- [ ] Add `runtimes/claude/` when the first Claude template or note lands.
- [ ] Update `README.md` First Use and Shared Rules for both runtimes.
- [ ] Update the `refresh` skill so its global pass maintains both runtimes.
- [ ] Remove this plan, or reduce it to a short "Runtime Support" section in `README.md`, once all stages are complete.

## Deferred

Claude-only features are out of scope until a concrete need appears:

- hooks (for example enforcing validation before stop)
- subagent definitions
- output styles
