---
type: Architecture Decision Record
title: Hasql keyset engine — predicate form, fingerprint, and v1 restrictions
description: Fix the expanded-lexicographic keyset predicate, the sort-spec fingerprint algorithm, and the NOT NULL/unique-tiebreaker v1 restrictions for the hasql pagination engine.
timestamp: 2026-11-18T16:02:00Z
docId: ADR-3
status: Accepted
date: 2026-07-16
generated:
  by: human:nadeem
  at: 2026-07-16T00:00:00Z
---

# Hasql keyset engine — predicate form, fingerprint, and v1 restrictions

## Context

`relay-pagination-hasql` turns a declarative sort specification (`SortSpec`:
ordered columns ending in a unique tie-breaker, each with a typed `KeyCodec`)
plus a base hasql `Snippet` into a keyset-paginated statement returning a
Relay `Connection`. Several design choices made while implementing it are
durable contracts that outlive the plan: they shape the SQL every consumer
runs, the meaning of every outstanding cursor, and what column types are
usable as sort keys.

## Decision

**Expanded lexicographic predicate, not row-value comparison.** The keyset
`WHERE` is generated as
`(c1 cmp1 $v1) OR (c1 = $v1 AND c2 cmp2 $v2) OR …` rather than PostgreSQL's
`(c1, c2) < ($1, $2)`. Row-value comparison can only express uniform sort
directions; mixed specs such as `updated_at DESC, member_id ASC` need the
expanded form. Paging backward flips every comparator and every `ASC`/`DESC`
(walking the same total order from the other end), then reverses rows in
memory so edges always come out in canonical order. Every occurrence of a
cursor value is a fresh typed parameter (a k-column cursor produces
k·(k+1)/2 placeholders); the `Snippet` API has no parameter reuse and
re-encoding scalars is negligible. A row-value fast path for uniform-direction
specs may be added later as a pure optimization with its own Decision Log
entry.

**The sort-spec fingerprint is 32-bit FNV-1a over a fixed byte
serialization**: one salt byte `0x01` (cursor format version), then per
column the UTF-8 bytes of `columnExpr`, `0x00`, one direction byte (`0x00`
Asc, `0x01` Desc), `0x00`, the UTF-8 bytes of `codecTag`, `0x00`. The `0x00`
separators prevent field-concatenation ambiguity; the version salt ties
fingerprints to the cursor wire format (ADR 2) so a format bump invalidates
outstanding cursors at decode time. Golden tests pin four exact values (e.g.
the members-like spec hashes to `3101933007`); changing the serialization
invalidates every outstanding cursor and requires an ADR update.

**Sort-key columns must be `NOT NULL`, and the last column must be unique per
row (v1).** `KvNull` exists in the core wire type but is reserved: built-in
codecs never produce it and reject it on decode. Nullable keys require a
chosen null ordering and `IS NULL` predicate arms — deferrable complexity; a
subtly wrong null ordering is a silent-skip bug. Tie-breaker uniqueness is
what makes the sort order total, hence skip/duplicate-free; the library
cannot verify it, the haddocks state it, and the conformance suite (EP-4) is
how consumers prove it.

**Statement-level, unprepared public surface.** `paginate` returns
`Either CursorError (Statement () (Connection row))` — no `Session`
convenience wrapper (callers wire `Connection.use conn (Session.statement ()
stmt)` themselves, keeping the engine usable in transactions and pipelines),
and statements are built with `Snippet.toStatement` (unpreparable), following
hasql-dynamic-statements 0.5's stance that dynamically assembled SQL should
not be prepared. The `Either` surfaces cursor validation (fingerprint, key
arity, key types) before any SQL runs, so garbage cursors become HTTP 400s,
never SQL runtime errors.

**Counts use the same statement-level surface.** `paginateCounted` returns
the page statement and an independent count statement from one base query.
`totalCountStatement` exposes the count alone. Callers choose how to run
both statements and how to compose the results. The count SQL and snapshot
contract are recorded in [ADR-8](8-opt-in-total-count.md).

**Cursors are minted in Haskell from the decoded row, never in SQL.**
`mintCursor` extracts each key value from the very values the row decoder
produced, and `timestamptzKey` converts `UTCTime` to exact integer
microseconds (PostgreSQL `timestamptz` resolution; hasql 1.10 uses the binary
integer-microseconds wire format), so the DB → Haskell → cursor → parameter
loop is exact by construction — the reference implementation's
`extract(epoch …)::text` / `::float` boundary-skip bug is unrepresentable.

**`columnExpr` is trusted SQL text.** It is spliced verbatim into generated
SQL and must never contain user input; all values travel as typed parameters.
This is a documented contract on `KeyColumn`, not something the library can
enforce.

## Consequences

Generated SQL is pinned by golden files rendered with `Snippet.toSql`
(`relay-pagination-hasql/test/golden/`); a diff there is either a deliberate
generator change (re-accept and review) or a bug. The PageInfo semantics
table (probe row drives the walking-direction flag; cursor presence drives
the behind-me flag) is implemented once in `mkConnection` and enforced by
pure regression tests plus ephemeral-pg integration walks over adversarial
data (ten-way timestamp ties, a microsecond-adjacent pair, an exactly-full
final page). EP-4's conformance suite treats `paginate` as its system under
test; EP-5's guides quote this API.

The count SQL goldens pin the subquery wrapper for plain and parameterized
base queries in `members-count.sql` and
`members-count-parameterized-base.sql` under the same directory.
