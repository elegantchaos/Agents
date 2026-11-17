# CC1: Claude Code Allow Rules

- **Status:** Proposed
- **Depends on:** nothing
- **Sources:** [29 September journal](../journal/2026-09-29.md), [Decision 0003](../decisions/0003-runtime-installation.md)

## Finish Condition

The shared rules also produce Claude Code permission allow rules, installed by `agt refresh`. The guidance and decision 0003 cover both runtimes.

## Notes

Sam runs both runtimes with auto-approval and keeps the rules, which settles the question parked on 29 September: allow rules still apply in auto mode. Decide the source format and how Claude settings are written before implementation. The installer belongs in AgentTools under decision 0004. Matching commands skip review in both runtimes, so keep the rules narrow.
