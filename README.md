# Agents Repository

This repository is the shared home for agent resources used across Elegant Chaos projects.

GitHub: [github.com/elegantchaos/Agents](https://github.com/elegantchaos/Agents)

It provides:

- shared baseline guidance in `~/.local/share/agents/COMMON.md`
- shared Codex rule files under `~/.local/share/agents/runtimes/codex/rules/`
- shared skills under `~/.local/share/agents/skills/`, maintained with the standalone `agt` command
- plugins under `plugins/`, maintained directly in this repository and installable in Claude Code and Codex: the [baseline plugin](plugins/baseline/README.md) (coding standards, project records, refresh) and the [Swift plugin](plugins/swift/README.md)

## First Use

Clone this repository to:

- `~/.local/share/agents`

`agt`, from [AgentTools](https://github.com/elegantchaos/AgentTools), manages shared resources. With [Homebrew](https://brew.sh) installed, install it, or update it to the latest release, with the `baseline` plugin's helper, which installs Mint first if it is missing and prints the path to `agt` (usually `~/.mint/bin/agt`):

```bash
~/.local/share/agents/plugins/baseline/skills/refresh/scripts/ensure-agt.sh --update
```

The commands below assume `agt` is on your `PATH`. If `ensure-agt.sh` printed `~/.mint/bin/agt`, add `~/.mint/bin` to your `PATH` first.

Then, from the repository root, run `agt refresh`. It syncs and links the shared skills, lets both runtimes' sandboxes write the caches that Swift validation needs (`agt sandbox configure`, which merges this machine's paths into `~/.claude/settings.json` and `~/.codex/config.toml`), and installs the shared plugins in Claude Code and Codex (skipping a runtime that is not installed):

```bash
agt refresh
```

Then synchronize the shared Codex rules:

```bash
agt rules sync
```

After that, use the `baseline:refresh` skill for routine maintenance.

## Shared Python Utilities

Both agents run Python-based agent utilities with `~/.local/share/agents/.venv/bin/python`. Project Python code uses its project's environment. The shared interpreter version is pinned in `.tool-versions`; [requirements-agent-tools.lock](requirements-agent-tools.lock) pins pip and PyYAML with SHA-256 hashes of published wheels. The venv and build scratch directory are ignored by Git.

Install the pinned Python with asdf from the repository root. Skipping Homebrew and MacPorts discovery lets python-build build its pinned OpenSSL instead of linking to those package managers' TLS libraries. Homebrew's `xz` supplies LZMA support through explicit compiler flags; install it with `brew install xz` if absent. Disabling default Python packages prevents asdf from installing extra, unlocked packages:

```sh
cd ~/.local/share/agents
mkdir -p .build/tmp/python-build/sources
PYTHON_BUILD_SKIP_HOMEBREW=1 PYTHON_BUILD_SKIP_MACPORTS=1 \
  LIBLZMA_CFLAGS="-I$(brew --prefix xz)/include" \
  LIBLZMA_LIBS="-L$(brew --prefix xz)/lib -llzma" \
  ASDF_PYTHON_DEFAULT_PACKAGES_FILE=/dev/null \
  TMPDIR="$PWD/.build/tmp/python-build" \
  PYTHON_BUILD_CACHE_PATH="$PWD/.build/tmp/python-build/sources" \
  asdf install python
```

Create the environment only when `.venv` does not exist. To replace an existing environment, preserve it as a recovery copy first; recreating a venv in place can retain old interpreter symlinks and packages.

```sh
asdf exec python3 -m venv .venv
.venv/bin/python -m pip --isolated install --force-reinstall --no-cache-dir \
  --index-url https://pypi.org/simple \
  --require-hashes --only-binary=:all: -r requirements-agent-tools.lock
.venv/bin/python -m pip config --site set global.require-hashes true
.venv/bin/python -m pip config --site set global.only-binary :all:
.venv/bin/python -m pip check
.venv/bin/python -c 'import sys, ssl, pyexpat, yaml; print(sys._base_executable); print(sys.version); print(ssl.OPENSSL_VERSION); print(pyexpat.EXPAT_VERSION); print(yaml.__version__)'
```

`--force-reinstall` makes pip verify and reinstall packages even if their versions already match. The environment's pip configuration enables hash checking and wheel-only installs by default. Hashes establish that downloaded artifacts match the reviewed lock; they do not prove the initial artifacts are trustworthy. The lock excludes source distributions and includes all non-yanked wheels for each pinned release. Review security advisories and artifact provenance when updating versions and hashes. Python and its native libraries need separate security checks and updates; the package lock does not cover them.

## Runtime Support

Claude Code and Codex are both supported.

- **Project guidance.** Each project's `AGENTS.md` comes from the `baseline:refresh` template. Codex reads it directly. Claude Code reads it when the project has no `CLAUDE.md`, `.claude/CLAUDE.md` or `CLAUDE.local.md`, so the refresh skill never creates one and warns when one exists. The template's `@~/.local/share/agents/COMMON.md` line makes Claude Code import `COMMON.md` at launch; Codex reads it as an instruction to open the file.
- **`COMMON.md` is opt-in per project.** It is never loaded globally; each project's `AGENTS.md` refers to it.
- **The voice is personal.** It lives only in the user-global files, never in `COMMON.md` or project files: `~/.claude/CLAUDE.md` imports a file from `voices/` with an `@` line, and `~/.codex/AGENTS.md` is a symlink to the same file.
- **Skills and plugins.** `agt skills link` links shared skills into `~/.claude/skills/` and `~/.codex/skills/`, and `agt refresh` installs the plugins in both runtimes. Bump a plugin's version in both its `.claude-plugin` and `.codex-plugin` manifests whenever its guidance changes, or installed copies keep the old text.

## Shared Rules

Shared reusable Codex approval rules live in `runtimes/codex/rules/`. Use `agt rules sync` to copy them into `~/.codex/rules/` as generated regular files. The runtime-only `default.rules` file is intentionally not stored in this repository.

## Shared Skills

Published shared skills live under `skills/` in this repository and are linked into `~/.codex/skills/` and `~/.claude/skills/` by `agt skills link`.
Published skills are git submodules. Skills we maintain directly live in the plugins instead.
Runtime names come from the discovered `name:` field in each skill's `SKILL.md`.

## Maintenance

- Use the `baseline:refresh` skill to update shared resources, sync and link published skill submodules, install or refresh the plugins, optionally research shared guidance improvements, and refresh a project's `AGENTS.md`.
