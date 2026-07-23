# Shared Rules

This folder is the canonical source for reusable Codex rule files.

Use the installed `agt` command from the repository root to inspect and synchronize runtime copies:

```bash
agt rules status
agt rules sync
```

`rules status` reports missing, divergent, symlinked, and runtime-only files without making changes. Run it before synchronization when reviewing manually added runtime rules.

`rules sync` writes each shared file into `~/.codex/rules/` as a regular file. Runtime copies include a generated-file warning and are always overwritten from this canonical directory.

`~/.codex/rules/default.rules` is intentionally runtime-only. During refresh, classify its entries, promote reusable rules into the appropriate shared family file, remove redundant or one-off entries, and then synchronize.
