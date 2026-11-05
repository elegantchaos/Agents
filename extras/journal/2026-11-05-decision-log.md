# Decision Log

Sam requested a local decision log and retrospective candidates. Added `extras/decisions/` to the project rules. The directory will be created when the first decision is confirmed and recorded.

The initial candidates concerned rules Agents publishes for other projects. Sam clarified that retrospective decisions should concern Agents itself, so those candidates are withdrawn.

Revised candidates awaiting Sam's selection: canonical ownership and distribution of shared guidance and skills; separation of personal voice from project guidance; delegation of shared-resource maintenance to AgentTools; and the Agents roadmap's scope and ongoing character. The [README](../../README.md), [AgentTools migration](2026-09-29.md), and [roadmap scope record](2026-11-05-agents-roadmap-scope.md) provide starting evidence. These are candidates, not new or amended decisions; check whether each adds useful rationale beyond existing documentation before proposing a record.

Sam clarified that `COMMON.md` is required through a project's `AGENTS.md` once the project adopts shared guidance. Add the mandatory baseline and its separation from task-specific skills to the decision candidates; updated the README to make that distinction clear. The roadmap now carries proposed migration of the standalone language skills to plugins and of the SwiftUI trace-analysis script to AgentTools. Existing skill links remain in use; `ensure-agt.sh` is a necessary bootstrap exception because it obtains AgentTools itself.

Five retrospective records were initially written: [shared guidance ownership](../decisions/0001-shared-guidance-ownership.md), [skills and plugins](../decisions/0002-language-skills-and-plugins.md), [runtime installation](../decisions/0003-runtime-installation.md), [AgentTools supporting commands](../decisions/0004-agenttools-supporting-commands.md), and shared scripting environments. The existing SwiftUI trace script is carried for migration in the roadmap; the bootstrap exception remains in Decision 0004.

Sam clarified that the fifth record was meant to cover the [shared baseline through project instructions](../decisions/0005-shared-baseline.md), not shared scripting environments. Replaced the uncommitted scripting-environments record with that decision. The personal-voice candidate remains unconfirmed.
