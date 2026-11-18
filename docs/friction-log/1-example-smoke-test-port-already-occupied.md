---
type: Friction Entry
title: "Example smoke test port already occupied"
description: "A running container held port 8080, so the example smoke test needed a free port."
generated:
  by: "codex-cli/gpt-6.2-sol"
  at: "2026-11-18T16:00:20Z"
frictionId: FRIC-1
status: "accepted"
impact: detour
kind: environment
origin: "mori://shinzui/relay-pagination"
affects: "mori://shinzui/relay-pagination"
plan: "docs/plans/6-offer-an-opt-in-total-count-on-relay-connections.md"
workaround: "Run the example startup function on an unused port and run the same curl assertions there."
resolution: "The example keeps port 8080 as its default. The smoke test ran the same startup function through Cabal REPL on free port 48193."
amended:
  - by: "codex-cli/gpt-6.2-sol"
    at: "2026-11-18T16:03:30Z"
    change: "Accepted the local port conflict and verified all four HTTP responses on port 48193."
---
# Example smoke test port already occupied

## Attempted

Checked port 8080 with lsof before running just example and its curl acceptance checks.

## Encountered

Port 8080 was already in use by a container process outside this task.

```text
container ... TCP 127.0.0.1:8080 (LISTEN)
```

## Workaround

Run the example startup function on an unused port and run the same curl assertions there.
