# Bionic

Bionic can use the shared project guidance and Agent Skills. This experimental setup requires manual skill installation and one explicit session bootstrap; native UI discovery and model behavior still need acceptance checks. `agt refresh` continues to manage Claude Code and Codex; it does not install or check Bionic resources.

For coding, start by evaluating [Codex CLI or Claude Code with the local model server](../local-models.md), which keeps the existing harness configuration. The Bionic skill setup below is available when using Bionic's own agent interface.

## Install

Keep this repository at `~/.local/share/agents`, with its skill submodules initialized. Bionic's user skills directory is `~/.lmstudio/skills`. Link the session skill, each standalone skill directory and the skills inside the baseline and Swift plugins into that directory. Link whole directories so relative references, scripts and assets remain available.

For the current shared skill set, run this in zsh only after confirming every destination path is absent, including dangling symlinks. Do not rerun this block over an existing installation: `ln` can follow an existing directory destination.

```zsh
mkdir -p ~/.lmstudio/skills
ln -s ~/.local/share/agents/runtimes/bionic/skills/bionic-session ~/.lmstudio/skills/bionic-session
for plugin in baseline swift; do
  for source in ~/.local/share/agents/plugins/$plugin/skills/*; do
    ln -s "$source" ~/.lmstudio/skills/$plugin-${source:t}
  done
done
for skill in javascript python ruby; do
  ln -s ~/.local/share/agents/skills/$skill-skill ~/.lmstudio/skills/$skill
done
```

On subsequent updates, matching links already follow their canonical sources. Inspect each existing link with `readlink` before repairing it; preserve unrelated files and directories. Repeat installation for newly added skills, and remove only links to shared skills that have been retired. Automatic installation and status checks belong in AgentTools under [decision 0004](../../extras/decisions/0004-agenttools-supporting-commands.md).

In Bionic, check **Settings → Skills** and enable the linked skills if needed. Bionic also offers **Use skills found in other apps**, but avoid enabling duplicate copies of the same shared skills. The native links include the skills inside our plugins without depending on another app's plugin cache.

## Start A Session

Select the project's actual working directory. In each new chat, type `@` and select **bionic-session** with your first request. Repeat when changing projects. If the skill has not appeared, paste this instruction with the request:

```text
Before replying, read ~/.local/share/agents/runtimes/bionic/skills/bionic-session/SKILL.md in full and follow it for this conversation.
```

The session skill reads the personal `VOICE.md`, then the project's applicable `AGENTS.md` and its shared baseline requirements. Existing project files need no Bionic-specific changes. Bionic reads repository `AGENTS.md` instructions, but there is no verified user-global startup instruction hook in the inspected version. An automatically selected skill is not a guarantee that startup instructions ran: explicitly invoke the session skill.

Shared references keep their plugin-qualified names, such as `baseline:standards` and `swift:language`. Bionic may display the unqualified frontmatter names, such as `standards` and `language`. The session skill resolves qualified references directly to the canonical files.

## Capabilities And Limits

- The standalone skills and all thirteen baseline and Swift skills are shared by directory links. Their references, scripts and assets remain at the source.
- This exposes plugin **skills**, not a Claude or Codex plugin runtime. Marketplace installation, hooks, commands, approvals and app connector tools do not transfer to Bionic. Configure Bionic integrations separately when needed.
- Codex approval rules and Claude sandbox settings stay runtime-specific. Bionic's **Custom instructions for Auto Review** field controls shell review; it is not a general chat instruction field.
- Models, runtimes and caches on `/Volumes/Models` are independent of skill installation. Keep their existing locations. A local model must still be able to read files and use the tools required by a task; successful discovery does not establish instruction compliance.

## Verification

The installation was inspected against Bionic **1.2.1+10**. Its installed skill preferences initially had no other-app directories enabled. Its repository context loader reads `AGENTS.md` files from the working directory up to the nearest repository root; its settings separate skill preferences from shell-review instructions.

After installation, start a fresh chat with `@bionic-session` and ask it to report the working directory, the instruction files it actually read, and the canonical paths for `baseline:standards` and `swift:language`. Then exercise one task with the chosen local model. Until that succeeds, file installation is verified but model behavior remains unverified.

Official references: [Bionic skills](https://lmstudio.ai/docs/bionic/agent/skills) describes `SKILL.md`, automatic selection, explicit `@` invocation and other-app discovery; [Bionic coding](https://lmstudio.ai/docs/bionic/agent/code-project) describes project file and shell access.
