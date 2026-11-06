# Refresh Drift

- Reviewed and merged Agents #43 after resolving a journal-index conflict with #42, then ran the global refresh. Runtime rules picked up the SwiftWorkflowBuilder rule; `default.rules` stays empty; skills are clean and linked; baseline went from 0.8.31 to 0.8.32 in Claude Code.
- The refresh found the Swift plugin's Codex manifest still at 0.11.2 after `806c375` moved the Claude manifest to 0.11.3. Aligned it at 0.11.3. The Codex cache already matched the source, so only the version label was wrong.
- This repository has kept a decision log since 5 November, but its `AGENTS.md` records bullet still named only the journal. It now uses the template wording for both.
- Updated the roadmap: the plugin and rules refresh is done; fresh Claude worktree acceptance remains the return point.
