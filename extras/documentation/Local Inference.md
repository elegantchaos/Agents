# Local Inference

## Working Configuration

The verified local coding path is Claude Code CLI → Ollama on loopback → a local model. Claude Code owns instruction loading, skills, plugins, file edits and tool permissions. Ollama owns model loading and inference. Restricting Ollama's account does not restrict the harness's independently granted project access: file contents and tool results requested by the model are sent to the inference server by the harness.

The machine configuration verified on 18 November 2026 uses an Apple M1 Max, Ollama 0.40.16 and a hidden `_ollama` service account (UID/GID 503) with login shell `/usr/bin/false`. A system LaunchDaemon runs the CLI bundled in `/Applications/Ollama.app`; the Ollama GUI is not required or running for this setup. The API binds only to `127.0.0.1:11434`, with cloud models disabled. This account boundary is not an outbound-network firewall or a complete application sandbox; other local processes can reach the API.

The selected packaged model is `qwen3.6:35b-a3b-q4_K_M`, manifest digest `07d35212591fc27746f0a317c975a6d68754fb38e9053d82e25f06057af28522`. It uses GGUF Q4_K_M weights, approximately 24 GB of model data, the llama.cpp runner and Metal. The configured default context is 262,144 tokens (256k), with one loaded model and one parallel inference request. A short inference request using the server default passed at that allocation. Retain 256k unless measured operation proves unusable. Models unload after five idle minutes by default; the small API server remains available.

The installed DMG was inspected before execution on 17 November: its SHA-256 was `b48d74a2d8c6a0592c816a4f85643d8d8608ad592abafbe95c04128a73c398c6`, matching the official release asset. App/disk-image signatures, stapled notarization tickets and Gatekeeper checks passed; 34 Mach-O items validated under Infra Technologies, Inc., team `3MU9H2V9Y9`. No build attestation was established. Those checks concern that downloaded version, not all future updates or proof that its source/build system is uncompromised. Recheck provenance and signatures when updating.

## Storage And Permissions

The external APFS volume is mounted at `/Volumes/Models`, with filesystem ownership enabled. The service user's account home is `/Volumes/Models/services/ollama/home`, and its `HOME` environment variable agrees with that account record.

| Purpose | Location |
| --- | --- |
| Ollama model store | `/Volumes/Models/services/ollama/home/models` |
| Cache, including Hugging Face cache | `/Volumes/Models/services/ollama/home/cache` |
| Temporary files | `/Volumes/Models/services/ollama/home/tmp` |
| Standard output and error | `/Volumes/Models/services/ollama/home/logs/stdout.log`, `stderr.log` |
| Ollama key/configuration directory | `/Volumes/Models/services/ollama/home/.ollama` |
| Shared MLX weights | `/Volumes/Models/mlx/mlx-community/` |
| Installed executable | `/Applications/Ollama.app/Contents/Resources/ollama` |
| Installed launchd definition | `/Library/LaunchDaemons/com.elegantchaos.ollama.plist` |

The machine-specific paths above document the installed service, not portable installation defaults. The executable, OS account record and launchd definition remain on the startup disk; runtime models, cache, temporary files and logs are on Models. Shared MLX weights remain outside the private service home. Keeping weights outside it has not been established as suitable for unattended daemon inference, even when ordinary account reads succeed.

The private home, models, cache, temporary and log directories are owned by `_ollama`, with mode 0700. Named ACLs let the normal user browse the home and log directory, read `stdout.log` and `stderr.log`, and read subsequently created log files. They do not grant writes or recursively expose private model/cache/key directories. `_ollama` cannot traverse the normal user's home or read its SSH directory, and cannot write the shared MLX directory or model configuration. These targeted checks are evidence about those paths, not an audit of every file on the machine.

No Full Disk Access grant or scoped launcher was added for the successful service tests. The model/cache/temp/log layout inside the external home passed startup, model listing and real inference. Earlier sibling directories outside that home produced removable-volume privacy denials under launchd. This is a verified layout on this machine, not a claim that changing `HOME` bypasses TCC generally.

Volume ownership initially exposed old stored UID 99 entries, which can behave as caller-relative ownership. Those entries were repaired in the shared data trees. Do not disable volume ownership or recursively loosen permissions to troubleshoot a later denial.

## Service Definition

The installed label is `com.elegantchaos.ollama`. It runs `ollama serve` directly as `_ollama`, group `_ollama`, with working directory `/`, `RunAtLoad=false` and `KeepAlive=false`. It is loaded and started manually; it does not yet start after reboot or restart automatically after a crash. Terminal closure does not stop it.

Its explicit environment includes:

| Variable | Value |
| --- | --- |
| `HOME` | `/Volumes/Models/services/ollama/home` |
| `USER`, `LOGNAME` | `_ollama` |
| `OLLAMA_HOST` | `127.0.0.1:11434` |
| `OLLAMA_MODELS` | `/Volumes/Models/services/ollama/home/models` |
| `XDG_CACHE_HOME` | `/Volumes/Models/services/ollama/home/cache` |
| `HF_HOME` | `/Volumes/Models/services/ollama/home/cache/huggingface` |
| `TMPDIR` | `/Volumes/Models/services/ollama/home/tmp` |
| `HF_HUB_OFFLINE`, `TRANSFORMERS_OFFLINE` | `1` |
| `OLLAMA_NO_CLOUD`, `OLLAMA_NOPRUNE` | `1` |
| `OLLAMA_CONTEXT_LENGTH` | `262144` |
| `OLLAMA_MAX_LOADED_MODELS`, `OLLAMA_NUM_PARALLEL` | `1` |
| `PATH` | `/usr/bin:/bin:/usr/sbin:/sbin` |

`OLLAMA_NO_CLOUD` disables Ollama cloud features, not all network activity. The Hugging Face offline settings do not prohibit Ollama registry downloads. Downloads initiated through the API are written by the restricted server into its private store. The service does not run the GUI updater.

The root-owned setup marker is `/Volumes/Models/services/ollama/.ollama-setup`. Historical one-off scripts retain their original experiment names and must not be used to manage the renamed service.

## Operate The Installed Service

These commands work in fish, zsh and sh, and assume the installed service definition above. They do not install or repair the service. Use administrator commands manually; the current setup is not yet an `agt inference` feature.

Inspect launchd and check the API:

```sh
sudo launchctl print system/com.elegantchaos.ollama
curl --fail --max-time 3 http://127.0.0.1:11434/api/version
curl --fail --max-time 3 http://127.0.0.1:11434/api/tags
curl --fail --max-time 3 http://127.0.0.1:11434/api/ps
```

If the job is loaded but stopped:

```sh
sudo launchctl kickstart system/com.elegantchaos.ollama
```

If it is not loaded, first mount and unlock Models, then:

```sh
sudo launchctl bootstrap system /Library/LaunchDaemons/com.elegantchaos.ollama.plist
sudo launchctl kickstart system/com.elegantchaos.ollama
```

To stop and unload it, preventing another kickstart until bootstrap:

```sh
sudo launchctl bootout system/com.elegantchaos.ollama
```

Read the logs as the normal user:

```sh
tail -n 50 /Volumes/Models/services/ollama/home/logs/stderr.log
```

Log rotation and size limits are not configured. Check growth before leaving the service unattended long term. The one-off setup/probe scripts under the Agents checkout's ignored `.build/tmp/ollama-review/` are experimental history, not supported installation or recovery tools; several describe superseded layouts. Do not rerun them as general maintenance. A fresh installation procedure and durable management commands belong in AgentTools.

## Launch Claude Code With The Local Model

From the coding project's worktree, use invocation-local environment settings. The following syntax works in fish as well as zsh/sh:

```sh
env -u ANTHROPIC_API_KEY -u CLAUDE_CODE_OAUTH_TOKEN \
  ANTHROPIC_BASE_URL=http://127.0.0.1:11434 \
  ANTHROPIC_AUTH_TOKEN=ollama \
  ANTHROPIC_API_KEY= \
  CLAUDE_CODE_ATTRIBUTION_HEADER=0 \
  CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1 \
  claude --model qwen3.6:35b-a3b-q4_K_M
```

The placeholder credential is for the local endpoint. Check `/status` and the requested model; settings-file overrides or a different launch environment can change routing. This command does not change ordinary hosted defaults. Local inference requests do not consume Anthropic inference usage, while hosted sessions remain subject to their normal account billing or limits. Plugins and other configured tools can still contact their own services; local inference does not make every tool offline.

Claude retains its normal user-global voice import, project guidance, installed skills and plugins. The model still has to follow them correctly; use the [evaluation](Coding%20Harness%20Evaluation.md) before entrusting larger changes to it. Instruction discovery alone is not evidence of coding quality.

## Verified Behavior And Gaps

| Check | Observed result |
| --- | --- |
| Packaged Qwen basic inference | Returned `LOCAL_OK`; foreground and launchd runs passed |
| Launchd with all private runtime state inside external home | Real inference passed; initial load about 50 seconds |
| Launchd with 256k default context | Returned `LOCAL_OK` without a request-level context override; `/api/ps` confirmed 262,144; cold load about 56 seconds and Ollama-reported GPU allocation about 26.8 GiB on a 64 GiB Mac |
| Launchd stdout/stderr inside external home | Separate probe and working-service restart passed |
| Claude Code CLI with packaged Qwen | Real instruction-file reads and baseline/Swift skill discovery passed, about 33 seconds |
| Codex CLI with packaged Qwen | Read voice/baseline, but incorrectly reported both skills missing; about 185 seconds; exit 0 was not acceptance |
| Hosted Claude Code and Codex controls | Both passed the earlier instruction-reading and discovery request |
| Actual coding benchmark | Fixture supplied separately; no model coding score established by the above checks |
| Claude.app Code tab with restricted server | Not tested; its settings and running work have not been changed |

The 256k check used a 17-token prompt with thinking disabled. It establishes successful loading and short inference, not speed, memory demand or answer quality near a full 256k window.

The CLI instruction checks ran before the storage move; launchd inference was verified separately. Those checks do not establish complete plugin/hook/MCP parity or every approval path. The timings used different harness contexts and are observations, not controlled speed comparisons.

The imported MLX alias `local-qwen36:35b` remains stored but failed inference with a `quantized_matmul` shape mismatch. Use the packaged GGUF alias above. Successful import, advertised capabilities and successful model listing do not establish usable inference.

Claude Desktop requires its own third-party inference configuration; CLI environment settings do not redirect an ordinary signed-in desktop session. Ollama's documented Desktop integration uses an additional local gateway from its GUI app, which also starts a server under the normal user. Compatibility with the restricted daemon is unresolved. Do not launch or reconfigure either GUI during other in-flight work merely to test it.

Automatic boot startup must handle Models being absent, locked or mounted late, and refuse fallback storage on the startup disk. That behavior, crash recovery, service management through `agt`, and stable signing of Mint-installed `agt` are agreed directions or pending work, not installed features. Ollama in this version creates its own TCP listener; native launchd socket activation has not been implemented.

## References And Archived Experiment

- [Ollama Claude Code integration](https://docs.ollama.com/integrations/claude-code)
- [Ollama configuration and idle model unloading](https://docs.ollama.com/faq)
- [Ollama Claude Desktop integration](https://docs.ollama.com/integrations/claude-desktop)
- [Claude Desktop environment settings](https://code.claude.com/docs/en/desktop#environment-variables-desktop-sets-itself)
- [Ollama MLX import issue 18789](https://github.com/ollama/ollama/issues/18789)

Separate Bionic harness support is shelved. [PR 50](https://github.com/elegantchaos/Agents/pull/50) is closed; its exact head is retained in the published [archive tag](https://github.com/elegantchaos/Agents/tree/archive/bionic-harness-2026-11-18). Its branch/worktree and experimental skill links are retained, including the session link into that worktree. The tag preserves source, not an installed environment or model weights. Do not remove the worktree without accounting for those links. Its useful local-provider and evidence-checking guidance is incorporated here and in the evaluation guide; its LM Studio commands are not the current service instructions.
