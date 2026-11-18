---
type: Architecture Decision Record
title: Opt-in total count on Relay connections
description: Count the whole filtered collection on demand with a separate statement and declare the required count through CountedConnection.
timestamp: 2026-11-18T16:02:00Z
docId: ADR-8
status: Accepted
date: 2026-11-18
generated:
  by: codex-cli/gpt-6.2-sol
  at: 2026-11-18T16:02:00Z
---

# Opt-in total count on Relay connections

## Context

The v1 scope excluded collection counts. Some gateways require the size of
the whole filtered collection for every page, as recorded in
[IR-1](../improvement-requests/offer-an-opt-in-total-count-on-relay-connections.md).
Calling services had to repeat their filter SQL or offer a second endpoint.

## Decision

Lift the v1 exclusion in 0.2.0.0. The count is the number of rows matched by
the base query before pagination. It is independent of cursor, direction,
and page size, and available even for empty pages.

Counting is opt-in at each layer. Core's `Connection` carries an optional
`Natural` count and omits the key in uncounted JSON. The
`CountedConnection` wrapper requires a count, and Servant documents it as
a required non-negative integer. Conformance checks counts when the caller
enables `checkTotalCount` over a stable dataset.

The engine returns two statements from one base query. The count statement
runs `SELECT count(*) FROM (<base>) AS rp_base` with the base query's
parameters. A window count or a count joined onto page rows would leave
no row to carry the count when the page is empty. To compute the whole
count with a window, PostgreSQL would also need to process every matching
row before applying the keyset filter. Two statements preserve the
uncounted query and let callers control isolation and execution.

Run both statements in a single `REPEATABLE READ` or `SERIALIZABLE`
transaction to read one snapshot. Separate statements and statements at
`READ COMMITTED` can observe concurrent writes between reads.

The members example holds its shared connection through rollback when a
statement fails. That keeps another request from entering the failed
transaction between the session error and cleanup.

## Consequences

A counted request pays for counting every matching row. Endpoints can
omit that cost and keep the collection size private by staying uncounted.
The v1 [cursor wire format](2-cursor-wire-format.md) and sort fingerprints
are unchanged.
