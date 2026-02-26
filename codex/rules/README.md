# Rules Symlink Setup

This folder is the canonical source for shared Codex rule files.

To use these rules on another machine, symlink each `*.rules` file here into `~/.codex/rules`.

## Prerequisites

- Clone this repository to `~/.local/share/agents` (recommended path).
- Ensure `~/.codex/rules` exists.

## Create Symlinks

From the repository root (`~/.local/share/agents`):

```bash
mkdir -p ~/.codex/rules
for f in codex/rules/*.rules; do
  ln -sfn "$PWD/$f" "$HOME/.codex/rules/$(basename "$f")"
done
```

## Verify

```bash
ls -l ~/.codex/rules/*.rules
```

Each entry should point to a file under `~/.local/share/agents/codex/rules/`.

## Notes

- `ln -sfn` safely replaces existing links with updated targets.
- If your clone path differs, run the same commands from your local repo root so `$PWD` resolves correctly.
