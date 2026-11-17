# BH2: Bionic Refresh Integration

- **Status:** Proposed
- **Depends on:** AgentTools support for Bionic skill installation and status
- **Sources:** [BH1](Done/BH1%20Bionic%20Skills%20And%20Session%20Guidance.md), [runtime setup](../../runtimes/bionic/README.md), [supporting-command ownership](../decisions/0004-agenttools-supporting-commands.md)

## Finish Condition

`agt refresh` installs and reports Bionic's standalone, plugin and session skills without overwriting unrelated skills. Runtime status checks identify missing or divergent shared links. The shared refresh skill and runtime documentation describe the released behavior.

## Notes

Manual Bionic installation is available. Implement operational tooling in AgentTools, including tests for existing destination conflicts and missing Bionic installations. Keep plugin skill exposure distinct from native marketplace support, and retain explicit session invocation unless Bionic gains a verified user-global instruction hook. Sam has not separately prioritized automation.
