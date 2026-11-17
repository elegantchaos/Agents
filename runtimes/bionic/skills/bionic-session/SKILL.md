---
name: bionic-session
description: Start a Bionic project session using Sam's shared voice, project instructions and canonical skills. Invoke at the beginning of a new Bionic chat, or when changing its working directory.
---

# Bionic Session

Before your first conversational response, read `~/.local/share/agents/VOICE.md` in full and follow it for the rest of this conversation. If unavailable, report that briefly. This is Sam's personal configuration; do not copy it into project instructions.

Read the working directory's applicable `AGENTS.md` instructions, including ancestor instructions within its repository and more specific instructions before working in a subdirectory. Follow their requirement to read `~/.local/share/agents/COMMON.md`. If the working directory is unclear, establish it before changing project files. For a project that has not adopted the shared guidance, ask before adopting its policies or creating project instructions.

Resolve shared skills at their canonical sources. A plugin-qualified name such as `baseline:standards` means `~/.local/share/agents/plugins/baseline/skills/standards/SKILL.md`; `swift:language` means `~/.local/share/agents/plugins/swift/skills/language/SKILL.md`. Standalone skills live under `~/.local/share/agents/skills/`; find the matching frontmatter name there. Read the selected skill and every reference it marks as required before doing the relevant work. Keep relative references and scripts resolved against that skill's source directory.

Use Bionic's available tools and approval process. Codex rules, Claude permissions, connector tools and plugin-specific commands are not capabilities granted by reading a skill. Report a missing capability when the task needs it, and use an available equivalent where appropriate.
