# 0004 AgentTools Owns Supporting Commands

Status: Accepted

Date: 2026-11-05

Revised: 2026-11-20

## Decision

Operational tooling that supports Agents belongs in AgentTools as `agt` commands. Shared guidance and configuration in this repository invoke those commands instead of adding standalone maintenance scripts.

AgentTools itself is installed with Mint: by hand when a machine is set up, and by agents at the start of each session. Nothing in this repository installs it.
