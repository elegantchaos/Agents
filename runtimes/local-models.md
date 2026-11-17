# Local Models For Coding

Use an existing coding harness with LM Studio's model server before building another harness. Codex CLI and Claude Code can both send requests to a local model server while retaining their own instruction loading, skills, plugins and tool execution. The model's ability to follow those instructions still needs testing.

## Serve The Models

The existing Bionic installation provides an LM Studio-compatible server controlled by `lms`. Start it on loopback:

```sh
lms server start --bind 127.0.0.1 --port 1234
lms ls
lms ps
```

Use `~/.lmstudio/bin/lms` if it is not on `PATH`. `lms ls` lists downloaded models; `lms ps` shows loaded instances and their identifiers. Keep the existing model storage on `/Volumes/Models`. The installed server has already indexed that storage; no model copies or downloads are needed for this setup.

`lms server status` checks the server; `lms server stop` stops its HTTP endpoint. Stopping the endpoint does not unload models or close Bionic.

For operation without a desktop app, [llmster](https://lmstudio.ai/docs/developer/core/headless) supplies the model-serving engine. Once installed, `lms daemon up` starts it, then `lms server start --bind 127.0.0.1 --port 1234` exposes the compatible HTTP API. It still needs access to the existing model directory and inference runtimes. That separate installation and storage configuration have not been performed here; the current server is provided by Bionic.

## Codex CLI

From a project directory:

```sh
codex --oss --local-provider lmstudio -m qwen3.6-35b-a3b
```

Select an identifier actually reported by the server. The installed server also reports `qwen3.5-9b` and `gpt-oss-20b`. An explicit model avoids Codex's default open-model selection and potential download. These flags apply to that invocation; they do not change the ordinary cloud-model default.

The server receives prompts and tool results through its OpenAI-compatible Responses endpoint. Codex reads project and user instructions, discovers skills and plugins, and executes model-requested tools under its own permissions. Server access does not turn a local model into an OpenAI model or grant tools that are unavailable in the chosen CLI session.

## Claude Code

LM Studio also provides an Anthropic-compatible Messages endpoint. Use invocation-local environment variables to keep ordinary Claude Code sessions unchanged:

```sh
ANTHROPIC_BASE_URL=http://127.0.0.1:1234 \
ANTHROPIC_AUTH_TOKEN=lmstudio \
CLAUDE_CODE_ATTRIBUTION_HEADER=0 \
claude --model qwen3.6-35b-a3b
```

`lmstudio` is the documented placeholder when the local server does not require authentication. If authentication is enabled, supply its actual token through the environment; keep credentials out of project files.

## Acceptance Before Coding

Start with a read-only session. Check that it reads `VOICE.md`, the applicable project `AGENTS.md` and `COMMON.md`, resolves a baseline and Swift skill to the expected canonical files, and makes a successful file-reading tool call. Then use an isolated worktree for a small code change with the project's normal tests. Instruction discovery alone does not establish reliable coding, permission handling or recovery from failed tools.

The installed Qwen instances advertise 262,144-token contexts. LM Studio recommends more than approximately 25,000 tokens for these coding integrations. Large advertised contexts still need practical evaluation: shared skills, tool definitions and repository instructions add substantial input before the coding task starts.

In the initial Codex CLI check, `qwen3.5-9b` connected and executed tools but timed out after repeated permission and skill-path mistakes. `qwen3.6-35b-a3b` completed the same file-reading and skill-discovery request in about 80 seconds, correctly reporting the first workflow rule. It still replied before reading the required voice file. Both runs emitted nonfatal model-load HTTP 500 and model metadata decoding warnings before inference succeeded. Treat this as verified local transport and discovery, with startup compliance and coding quality still under evaluation.

Claude Code 2.1.281 connected to the same 35B Qwen model with the baseline and Swift plugins enabled. In a read-only check with Read, Glob, Grep and Skill tools, it completed in approximately 39 seconds but made no tool calls, claimed a GitHub read despite having no web tool, and quoted an incorrect rule. This failed acceptance despite exit 0. The Codex check exposed shell tools while the Claude check exposed file-reading tools, so these observations are not a controlled performance benchmark.

A focused Claude retry explicitly requiring `Read` on the canonical `COMMON.md` succeeded: it made the tool call and quoted the correct rule in approximately 16 seconds. Claude's local transport and file tools therefore work, but the broader request exposed unreliable autonomous verification. Begin with small supervised tasks and inspect tool evidence rather than relying on a model's claims about completed work.

## Other Harnesses

[Bionic](bionic/README.md) remains an alternative with manual skill links and explicit session startup. It shares skill content but does not reproduce the full Codex or Claude plugin runtime.

[PiSwift](https://github.com/xibbon/PiSwift) provides reusable agent libraries and a higher-level coding-agent library. [PiSwiftTui](https://github.com/xibbon/PiSwiftTui) provides its terminal companion and `pi-coding-agent` executable, with sibling PiSwift and MiniTui dependencies. These are candidates if the existing coding harnesses reveal a concrete limitation. They have not been built or evaluated here; adopting them would need checks for instruction loading, local-provider compatibility, skills, tool approvals and plugin-specific capabilities before claiming equivalent support.

Official references: [Codex integration](https://lmstudio.ai/docs/integrations/codex), [Claude Code integration](https://lmstudio.ai/docs/integrations/claude-code), [LM Studio, llmster and lms](https://lmstudio.ai/docs/app/basics/lmstudio-vs-llmster-vs-lms).
