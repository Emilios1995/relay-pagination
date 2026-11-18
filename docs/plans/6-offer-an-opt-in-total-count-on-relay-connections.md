---
id: 6
slug: offer-an-opt-in-total-count-on-relay-connections
title: "Offer an opt-in total count on Relay connections"
kind: exec-plan
created_at: 2026-11-18T15:41:04Z
intention: "intention_01m7qmz011evp8hh9z2pxjewkw"
provenance:
  created_by:
    model: "claude-fable-5-2"
    harness: "claude-code"
    at: 2026-11-18T15:41:04Z
  revisions:
    - model: "gpt-6.2-sol"
      harness: "codex-cli"
      at: 2026-11-18T15:50:34Z
      mode: "implement"
      note: "Implemented and verified the opt-in total count across the pagination packages and example."
---

# Offer an opt-in total count on Relay connections

This ExecPlan is a living document. The sections Progress, Surprises & Discoveries,
Decision Log, and Outcomes & Retrospective must be kept up to date as work proceeds.
If durable project context changes, update or create ADRs in docs/adr/ in the same change.
Record friction met while implementing in the friction-log bundle as it occurs (see FRICTION.md).


## Purpose / Big Picture

This repository ships four Haskell packages that give REST services Relay-style cursor pagination. A paginated endpoint returns a "connection": a JSON object with `edges` (the rows of one page, each with a cursor) and `pageInfo` (whether more pages exist, and the first and last cursors). Version 1 deliberately left out `totalCount`, the size of the whole collection.

Services that sit behind a GraphQL gateway need that number. The gateway `mori://tan/api-gateway` adds a non-null `totalCount: Int!` field to every connection it builds, so a service such as `mori://tan/agent-reputation-service` must supply a count with every page. Today each service hand-writes a count query beside every pagination call, repeating the base query and its filters, or adds a second HTTP endpoint only for the count. This request is recorded as IR-1 in [docs/improvement-requests/offer-an-opt-in-total-count-on-relay-connections.md](../improvement-requests/offer-an-opt-in-total-count-on-relay-connections.md), and its six acceptance criteria (AC-1 to AC-6) are the acceptance of this plan.

After this change a service passes its base query once and gets back both the page and the number of rows the base query matches. The endpoint can declare itself "counted", and its OpenAPI schema then lists `totalCount` as a required non-negative integer. Counting stays opt-in: an endpoint that does not ask for a count runs the same SQL and returns byte-for-byte the same JSON as it does today.

To see it working after implementation, run `cabal test all` from the repository root, then start the example server with `just example` and request a counted page:

```bash
curl -s 'http://localhost:8080/members/counted?first=2'
```

The response is a connection with two edges and a trailing `"totalCount":N`, where `N` is the number of seeded members and is the same on every page. `curl -s 'http://localhost:8080/members?first=2'` still returns a connection with no `totalCount` key.


## Progress

- [x] (2026-11-18) M1 Core: `Connection` carries an optional count and `CountedConnection` guarantees one; the byte-exact JSON and decode tests pass, including absent and null counts. The baseline and M1 each passed all five suites, and both existing OpenAPI artifacts were byte-identical (AC-1).
- [x] (2026-11-18) M2 hasql: `paginateCounted` and `totalCountStatement` derive the count from the base query. All 43 hasql tests passed. Both count SQL goldens match the planned statements, and the six existing goldens are byte-identical. The transaction test observed 25 rows inside the snapshot and a count of 26 outside (AC-2, AC-3).
- [ ] M3 servant: `CountedConnection` has an OpenAPI schema with a required `totalCount`; the new counted toy golden passes and `toy-openapi.json` is byte-identical (AC-4).
- [ ] M4 Conformance: `checkTotalCount` passes for a correct counted endpoint and fails for the three broken count fixtures; the existing broken paginators still fail (AC-5).
- [ ] M5 Example, guides, ADR-8 and release preparation: the example serves `/members/counted`, the guides show it, ADR-8 lifts the v1 exclusion, all packages are at 0.2.0.0, and `cabal test all`, `just check-adr` and `cabal check` are clean (AC-6).


## Surprises & Discoveries

- The concurrent-insert test uses its own database fixture so the reader and writer can overlap without affecting the existing integration cases. It reads all 25 fixture rows with one page statement inside the snapshot, then confirms the count of 26 after committing.


## Decision Log

- Decision: Add the count to the existing type as `totalCount :: Maybe Natural` on `Connection`, and add a second core type `CountedConnection` that wraps a `Connection` whose count is known to be present.
  Rationale: AC-1 asks that the core `Connection` type can carry an optional count, and the conformance suite's `FetchPage` callback returns a `Connection`, so the count must be readable from that type. A `Maybe` field alone cannot make an OpenAPI schema say "required", and it lets a counted handler forget the count. `CountedConnection` gives a counted endpoint a distinct response type, so the schema, the client decoder and the handler all agree that the count is there. `Natural` (a non-negative integer of any size, from `Numeric.Natural` in `base`) makes a negative count unrepresentable, and its JSON parser rejects negative and fractional numbers.
  Date: 2026-11-18

- Decision: Produce the count with a second SQL statement, `SELECT count(*) FROM (<base>) AS rp_base`, and return the page statement and the count statement together. Do not fold the count into the page statement.
  Rationale: A window function (`count(*) OVER ()`) or a join in the page statement returns no count when the page has no rows, which happens for a page size of 0 and for a cursor past the end, and AC-2 requires a count in both cases. A window function also forces PostgreSQL to produce every row of the collection, with all columns, before the keyset filter applies. Two statements keep the uncounted SQL unchanged, keep the count independent of cursor, direction and page size by construction, and follow ADR-3's rule that the engine's public surface is statements, which callers can run in a session, a pipeline or a transaction.
  Date: 2026-11-18

- Decision: State the consistency guarantee in terms of a snapshot, and document that "one transaction" must mean `REPEATABLE READ` (or `SERIALIZABLE`).
  Rationale: PostgreSQL's default isolation level, `READ COMMITTED`, gives each statement its own view of the data. Two statements in one `READ COMMITTED` transaction can still disagree if another session commits between them. Only `REPEATABLE READ` and above fix one view for the whole transaction. AC-3 asks that the documentation state what holds; an imprecise "run them in a transaction" would be wrong advice.
  Date: 2026-11-18

- Decision: Keep `toy-openapi.json` and its toy API untouched and add a second toy API, with its own golden file, that has one uncounted and one counted endpoint.
  Rationale: AC-4 requires both a golden for a counted-plus-uncounted API and that the existing goldens pass unchanged. Adding a route to the existing toy API would change its golden file. A separate golden lets `git diff --exit-code` prove the old one is byte-identical.
  Date: 2026-11-18

- Decision: Release this as 0.2.0.0 for all four published packages. Publishing to Hackage is not part of this plan.
  Rationale: Adding a field to `Connection` breaks every caller that builds one with record syntax, and adding a field to `ConformanceConfig` and a constructor to `InvariantName` does the same for the conformance package. Under the Haskell Package Versioning Policy (PVP) that is a major version change. The repository's root `CHANGELOG.md` states that all published packages share one version.
  Date: 2026-11-18


## Outcomes & Retrospective

(To be filled during and after implementation.)


## Context and Orientation

### The repository

The repository root holds a Cabal project (`cabal.project`) with five packages. All commands in this plan run from the repository root inside the Nix development shell (`nix develop`, or `direnv`), which provides GHC 9.12.4, `cabal`, `just`, `okf` and the PostgreSQL binaries the database tests start on their own.

`relay-pagination/` is the core package. `relay-pagination/src/Relay/Pagination/Connection.hs` defines `Edge`, `PageInfo` and `Connection`, each with hand-written JSON instances in a fixed field order so tests can compare exact bytes. `Connection` has exactly two strict fields, `edges` and `pageInfo`. The facade module `relay-pagination/src/Relay/Pagination.hs` re-exports everything. Tests are in `relay-pagination/test/Main.hs`; the group `connectionJsonTests` pins the exact JSON bytes of a connection.

`relay-pagination-hasql/` is the database engine. hasql is a PostgreSQL client library. A `Snippet` (from the `hasql-dynamic-statements` package) is a fragment of SQL text with typed parameters; a `Statement` is one runnable SQL statement with a result decoder; a `Session` is a sequence of statements on one connection. A "base query" is the caller's `SELECT <cols> FROM ... WHERE <filters>` with no `ORDER BY` and no `LIMIT`. `paginate` in `relay-pagination-hasql/src/Relay/Pagination/Hasql.hs` takes a sort specification, a validated page request, a base query and a row decoder, and returns `Either CursorError (Statement () (Connection row))`. The SQL comes from `paginateSnippet` in `relay-pagination-hasql/src/Relay/Pagination/Hasql/Sql.hs`, which wraps the base query as `SELECT * FROM (<base>) AS rp_base [WHERE <cursor predicate>] ORDER BY ... LIMIT <pageSize+1>`. `mkConnection` in `relay-pagination-hasql/src/Relay/Pagination/Hasql/Connection.hs` turns the fetched rows into a `Connection`. Nothing in the engine counts rows. Tests live under `relay-pagination-hasql/test/`: `Test/SqlGolden.hs` compares generated SQL with files in `test/golden/` (a "golden test" compares output with a checked-in file), and `Test/Integration.hs` runs the engine against a real throwaway PostgreSQL started by the `ephemeral-pg` library, over a 25-row `items` table.

`relay-pagination-servant/` is the HTTP surface. Servant describes an HTTP API as a Haskell type. `RelayPage` in `relay-pagination-servant/src/Relay/Pagination/Servant.hs` is a route component that parses the `first`, `after`, `last` and `before` query parameters. `relay-pagination-servant/src/Relay/Pagination/Servant/OpenApi.hs` holds the OpenAPI schema instances (`ToSchema`) for the core types. OpenAPI is a JSON description of an HTTP API that client generators and gateways read. The instance for `Connection a` is derived generically from the record's fields, so any new field would appear in the schema unless the instance is changed. A toy API in `relay-pagination-servant/demo/ToyApi.hs` and `demo/ToyOpenApi.hs` is shared by the tests in `relay-pagination-servant/test/Main.hs` and by the executable `relay-demo-openapi` (`demo/OpenApiMain.hs`), which is the only thing allowed to write the golden file `relay-pagination-servant/test/golden/toy-openapi.json`. Endpoints declare their responses with `MultiVerb`, a servant feature that lists each status code and body type, for example `Respond 200 "Page of items" (Connection Item)`.

`relay-pagination-conformance/` is a test library that services run against their own endpoints. It walks an endpoint page by page through a callback `FetchPage row = PageRequest -> IO (Connection row)` (`src/Relay/Pagination/Conformance/Walk.hs`) and checks six invariants in `checkConformance` (`src/Relay/Pagination/Conformance/Check.hs`), configured by the record `ConformanceConfig`. Its own tests keep a correct in-memory paginator (`test/Oracle.hs`) and deliberately broken ones (`test/Broken.hs`), exercised in `test/CheckSpec.hs`; `test/DbSpec.hs` and `test/HttpSpec.hs` run the checker against the hasql engine directly and through a servant server and client, using the fixture in `test/DbFixture.hs`.

`examples/members-server/` is an unreleased example service. Its source is the single source of truth for code quoted in the guides `docs/guides/implementing-pagination.md` and `docs/guides/agent-guide.md` and in `README.md`. `src/Example/Members/Api.hs` declares `GET /members`, `src/Example/Members/Handler.hs` runs `paginate`, `src/Example/Members/Query.hs` holds the sort specification and base query, `src/Example/Db.hs` runs sessions, and `src/Example/OpenApi.hs` renders the checked document `docs/api/openapi.json` (written only by `just openapi`). `test/Main.hs` runs the conformance suite through a typed HTTP client.

All four published packages are at version 0.1.1.2 and depend on each other with the bound `^>=0.1.1.2`. Each has its own `CHANGELOG.md`, and the root `CHANGELOG.md` summarizes each shared release.

### Decision records that constrain this work

Architecture Decision Records (ADRs) live in `docs/adr/`, a profile-governed OKF bundle (OKF is the repository's format for structured Markdown documents with validated frontmatter; `just check-adr` validates the bundle). The next free handle is ADR-8. No existing ADR covers `totalCount`. These records are relevant:

[docs/adr/2-cursor-wire-format.md](../adr/2-cursor-wire-format.md) pins the cursor format (version 1) with golden tests. This plan does not touch cursors; those tests must pass unchanged.

[docs/adr/3-hasql-keyset-engine.md](../adr/3-hasql-keyset-engine.md) fixes the engine's public surface as statements, not sessions, so that callers can run them in transactions and pipelines, and pins generated SQL with golden files. The count entry point follows the same rule.

[docs/adr/4-servant-pagination-surface.md](../adr/4-servant-pagination-surface.md) makes `Relay.Pagination.Servant.OpenApi` the only module allowed to define OpenAPI instances for core types, keeps the servant and hasql packages independent of each other (they share only core types), and requires OpenAPI documents to be written by a dedicated executable and compared read-only by tests.

[docs/adr/5-conformance-suite-boundary-and-walker-contract.md](../adr/5-conformance-suite-boundary-and-walker-contract.md) limits the conformance library to depending on core only, fixes `FetchPage` as the single handle on the system under test, lists six invariants, and requires that the repository keep broken paginators that make the suite fail.

[docs/adr/6-release-packaging-and-ordering.md](../adr/6-release-packaging-and-ordering.md) requires per-package changelogs, bounds on every dependency, and a clean `cabal check`.

[docs/adr/7-example-server-as-unreleased-ci-built-package.md](../adr/7-example-server-as-unreleased-ci-built-package.md) makes the example server the source of every guide snippet.

The completed MasterPlan [docs/masterplans/1-relay-compliant-cursor-pagination-library-for-servant-and-hasql.md](../masterplans/1-relay-compliant-cursor-pagination-library-for-servant-and-hasql.md) lists "`totalCount` computation (may be a later extension)" as excluded from v1 and says its Decision Log needs a new entry to add it.

### What "total count" means here

The count is the number of rows the base query matches: the size of the whole filtered collection. It does not depend on the cursor, the paging direction or the page size, and it is not "rows remaining after the cursor". This is how GraphQL connections conventionally use `totalCount`.


## Plan of Work

### Milestone 1: the core types carry a count

At the end of this milestone the core package can represent, encode and decode a counted connection, and the rest of the repository compiles and passes its existing tests with no behavior change.

In `relay-pagination/src/Relay/Pagination/Connection.hs`, add a third strict field `totalCount :: !(Maybe Natural)` to `Connection`, after `pageInfo`. Change the JSON instances so that `totalCount` is written last and only when the field is `Just`; when it is `Nothing` both `toJSON` and `toEncoding` must produce exactly what they produce today. Decoding reads the key with `.:?`, so an absent key and an explicit `null` both give `Nothing`.

In the same module add `CountedConnection`, a newtype over `Connection` whose constructor is not exported, with the invariant that the wrapped connection's `totalCount` is `Just`. Export the functions listed under Interfaces and Dependencies. Its `ToJSON` instance delegates to the wrapped connection, so the wire shape is a connection with `totalCount` always present. Its `FromJSON` instance decodes a `Connection` and fails with a message naming `totalCount` when the key is absent. Derive `Eq`, `Show`, `Functor`, `Foldable` and `Traversable`. Update the module haddock, which currently says the encoding has exactly two keys.

Adding a strict field makes every record construction of `Connection` a compile error until it sets the new field. Fix each site by adding `totalCount = Nothing`: `mkConnection` in `relay-pagination-hasql/src/Relay/Pagination/Hasql/Connection.hs`, `relay-pagination-servant/demo/ToyApi.hs`, `relay-pagination-servant/test/Main.hs`, `relay-pagination-conformance/test/Oracle.hs`, `test/Broken.hs` and `test/MutationSpec.hs`, and `relay-pagination/test/Main.hs`. `cabal build all` reports any site this list misses.

The generic `ToSchema (Connection a)` instance in `relay-pagination-servant/src/Relay/Pagination/Servant/OpenApi.hs` would now add an optional `totalCount` property to every connection schema and change the checked OpenAPI files. In this milestone, keep the generic derivation but remove the `totalCount` key from the resulting schema's properties, so the schema of an uncounted connection is exactly what it was. The existing servant test "checked artifact matches generator" proves this.

Add tests to `relay-pagination/test/Main.hs` in `connectionJsonTests`: exact bytes for a connection with `totalCount = Just 42` (the existing fixture followed by `,"totalCount":42` before the closing brace); the existing exact-bytes tests unchanged, now built with `totalCount = Nothing`; decoding JSON with the key gives `Just`, without it gives `Nothing`; `"totalCount":-1` and `"totalCount":1.5` are rejected; `CountedConnection` round-trips, and decoding it from JSON without the key fails.

Verify with `cabal build all` and `cabal test all`. All suites pass, and `git diff --exit-code relay-pagination-servant/test/golden/toy-openapi.json docs/api/openapi.json` reports no change.

### Milestone 2: the hasql engine yields the count

At the end of this milestone a caller hands the engine the same base query once and receives a page statement and a count statement.

In `relay-pagination-hasql/src/Relay/Pagination/Hasql/Sql.hs` add `totalCountSnippet`, which wraps a base query as `SELECT count(*) FROM (<base>) AS rp_base` in the module's one-line style, with no cursor predicate, no `ORDER BY` and no `LIMIT`. The base query's own parameters travel with it because it is spliced as a `Snippet`.

In `relay-pagination-hasql/src/Relay/Pagination/Hasql.hs` add `totalCountStatement`, which builds an unprepared statement from that snippet and decodes the single `bigint` result into a `Natural`; the record `CountedPage`; and `paginateCounted`, which validates the cursor exactly as `paginate` does and returns both statements. Export all of them and extend the module haddock with the count's meaning, its cost (`count(*)` reads every matching row, so it can be slow on large collections and is opt-in for that reason), and the consistency statement from the Decision Log. `paginate` and `paginateSnippet` stay as they are, and the six existing SQL golden files must not change.

In `relay-pagination-hasql/test/Test/SqlGolden.hs` add two golden tests for `totalCountSnippet`, `members-count` over the plain members base and `members-count-parameterized-base` over the parameterized base. The expected files are:

```sql
SELECT count(*) FROM (SELECT member_id, updated_at FROM members) AS rp_base
```

```sql
SELECT count(*) FROM (SELECT member_id, updated_at FROM members WHERE mls = $1) AS rp_base
```

In `relay-pagination-hasql/test/Test/Integration.hs` add a test group named `total count`. Using `paginateCounted` over the existing 25-row fixture and page size 5, assert the count is 25 for a first page, for a middle page reached with an `after` cursor, and for a backward page reached with a `before` cursor; assert it is 25 for a page size of 0, where the page has no edges; assert it is 0 for a base query that matches nothing (for example the items base with `WHERE false`); and assert it is 2 for the filtered base query the existing boundary test uses (`item_id IN ('i21', 'i22')`), which shows the count follows the base query's filters. In each case also compare the count with a directly written `SELECT count(*)` over the same table and filter.

Add the single-transaction test to the same group. Open a second connection to the same database with `Connection.acquire (Pg.connectionSettings db)`. On the first connection run `BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY` with `Session.script`, run the count statement, then on the second connection insert one new row into `items` and let it commit, then run the page statement on the first connection and `COMMIT`. Walk the remaining pages inside the same transaction if that is simpler than reasoning about one page; the assertion is that the count is 25 and the newly inserted row is in no page read inside the transaction. Then, outside any transaction, run the count statement again and assert 26, which shows the same two statements run separately do observe the concurrent write. Delete the inserted row at the end so the other tests in the shared fixture are unaffected, and place this test so it cannot interleave with them (the group already shares one connection; make it a `sequentialTestGroup` if the suite is linked with `-threaded`).

Verify with `cabal test relay-pagination-hasql:relay-pagination-hasql-tests`.

### Milestone 3: a servant endpoint declares that it is counted

At the end of this milestone an endpoint whose 200 response type is `CountedConnection a` documents `totalCount` as required, and uncounted endpoints document exactly what they did before.

In `relay-pagination-servant/src/Relay/Pagination/Servant/OpenApi.hs` add `instance (ToSchema a) => ToSchema (CountedConnection a)`. Build it from the same generic `Connection a` schema: keep the `totalCount` property (the generic derivation gives it `type: integer` and `minimum: 0`, the schema `openapi-hs` defines for `Natural`), add `totalCount` to the `required` list, and name the schema by prefixing the connection's name with `Counted`, giving for example `CountedConnection_Item`. The module haddock lists the types whose orphan instances live there; add `CountedConnection`. No change is needed to the `RelayPage` combinator: "counted" is a property of the response type, not of the query parameters.

Add `relay-pagination-servant/demo/CountedToyApi.hs`: a second toy API with two routes, the existing uncounted `ToyItemsEndpoint` and a new `counted-items` route that uses `RelayPage 10 100` and a `MultiVerb` whose 200 response is `CountedConnection Item`, with a hand-written `AsUnion` instance like the one in `ToyApi.hs`. Its handler echoes the request as the uncounted one does and reports a fixed count. Extend `demo/ToyOpenApi.hs` with a renderer for this API that sets distinct operation ids (`getItems`, `getCountedItems`), and extend `demo/OpenApiMain.hs` to write a second file, `relay-pagination-servant/test/golden/toy-counted-openapi.json`. Add the new module to `other-modules` of the test suite and of `relay-demo-openapi` in `relay-pagination-servant/relay-pagination-servant.cabal`.

Add tests to `relay-pagination-servant/test/Main.hs`: the new checked file matches its renderer; in the counted document the `CountedConnection_Item` schema lists `totalCount` in `required` with type integer and minimum 0; the `Connection_Item` schema in the counted document is equal to the one in the original toy document and has no `totalCount` property; the `/items` path item is equal in both documents; a representative `CountedConnection Item` passes `validateToJSON`; and a raw HTTP request to `/counted-items` returns a body containing `totalCount` that decodes as `CountedConnection Item`, while the typed client decodes the same route.

Verify with `cabal run relay-pagination-servant:relay-demo-openapi`, then `cabal test relay-pagination-servant:relay-pagination-servant-test`, then `git diff --exit-code relay-pagination-servant/test/golden/toy-openapi.json`.

### Milestone 4: the conformance suite checks the count

At the end of this milestone a service can ask the suite to check its counted endpoint, and the suite demonstrably fails for wrong counts.

In `relay-pagination-conformance/src/Relay/Pagination/Conformance/Check.hs` add the field `checkTotalCount :: !Bool` to `ConformanceConfig`, off in `defaultConformanceConfig`, and the constructor `TotalCountConsistency` to `InvariantName`. When the flag is on, `checkConformance` examines every page of the forward walk, and of the backward walk when that is enabled, and reports a `TotalCountConsistency` violation, with the page index, for each page whose `totalCount` is `Nothing`, and for each page whose count differs from the number of distinct keys the forward walk collected (distinct under `keyOf`). A count that changes from page to page therefore produces a violation on every page that disagrees. Describe the invariant in the module haddock beside the other six, including that it presumes a dataset that does not change during the walk. The library must still depend only on core.

In the test suite, give the oracle a counted form (for example a wrapper that sets `totalCount` to the length of the full row list) and add three broken fixtures to `relay-pagination-conformance/test/Broken.hs`: one that reports the number of rows remaining from the cursor onward, which is the page-dependent misreading of `totalCount`; one that reports a constant that is one too high; and the plain uncounted oracle checked with the flag on. In `test/CheckSpec.hs`, assert that the counted oracle passes with `checkTotalCount` on for 0, 1 and 7 rows, that each broken fixture fails with `TotalCountConsistency` as its only violated invariant, and that the remaining-rows fixture's violations name the pages after the first. The existing "teeth" tests must stay as they are and stay failing in the same way; the two `ConformanceConfig` record constructions in that file need the new field.

Add a counted fetch to `test/DbFixture.hs` that runs both statements from `paginateCounted` and sets the count on the page, and use it in `test/DbSpec.hs` with `checkTotalCount` on. In `test/HttpSpec.hs`, add a counted route whose response is `CountedConnection TestRow` and walk it through the servant client, converting each response to a `Connection` for `FetchPage`. This is the end-to-end check that the engine's count survives the JSON encoding, the HTTP layer and the typed client.

Verify with `cabal test relay-pagination-conformance:relay-pagination-conformance-test`.

### Milestone 5: example, guides, decision record and release preparation

At the end of this milestone the feature is documented from compiled example code, the decision is recorded, and the packages are ready to release as 0.2.0.0.

In the example server, add a counted route `GET /members/counted` to `MemberRoutes` in `examples/members-server/src/Example/Members/Api.hs`, with its own response list, result type and `AsUnion` instance, returning `CountedConnection Member`. In `src/Example/Members/Handler.hs` add its handler, which calls `paginateCounted` with the same `memberSort`, `baseQuery` and `memberRowDecoder` as the uncounted handler. In `src/Example/Db.hs` add a runner that wraps a session in `BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY` and `COMMIT`, and issues `ROLLBACK` before reporting an error if the session fails, and use it for the counted handler so the example shows the consistent form. Give the new operation the id `listMembersCounted` in `src/Example/OpenApi.hs`, regenerate `docs/api/openapi.json` with `just openapi`, and confirm with `git diff docs/api/openapi.json` that the diff only adds the new path and the `CountedConnection_Member` schema. In `examples/members-server/test/Main.hs` add a conformance walk of the counted route with `checkTotalCount` on, and an assertion that the uncounted route's raw JSON has no `totalCount` key.

In `docs/guides/implementing-pagination.md` add a section on counted endpoints after "Wiring the engine", quoting the example's route and handler. It must state what the count means, that it is opt-in and why (cost, and endpoints that should not reveal collection size), and the consistency statement: run in one `REPEATABLE READ` read-only transaction, the count and the page describe the same snapshot; run as separate statements or in a `READ COMMITTED` transaction, a concurrent insert or delete can make the count differ from what a full walk returns, which is acceptable for display counts and not for logic that needs them equal. Extend the conformance section with `checkTotalCount`. Update `docs/guides/agent-guide.md` and the `README.md` quickstart and package list where they describe the connection shape or the available entry points.

Create ADR-8 in `docs/adr/` following the bundle's profile. Allocate the handle with `okf id next docs/adr --profile docs/adr/profile.dhall ADR` (it returned `ADR-8` when this plan was written), name the file `8-opt-in-total-count.md`, and copy the frontmatter fields from an existing record such as `docs/adr/7-example-server-as-unreleased-ci-built-package.md`. It records that the v1 exclusion of `totalCount` is lifted; the count's meaning; that it is opt-in at every layer and absent from uncounted responses; the two-statement design and the alternatives rejected in this plan's Decision Log; the snapshot statement; and that the cursor format of ADR-2 is unchanged. Cite IR-1 by its repository-relative path. Add the record to `docs/adr/index.md` and add a `docs/adr/log.md` entry with `okf log add`. Amend ADR-3 (new statement-level entry points and golden files), ADR-4 (the `CountedConnection` instance and the fact that `Connection`'s schema is no longer purely generic) and ADR-5 (a seventh, opt-in invariant and its broken fixtures), advancing each record's `timestamp` and logging the change. Append a Decision Log entry to the MasterPlan that points to ADR-8, since the MasterPlan requires one for this extension.

Set `version: 0.2.0.0` in the four published `.cabal` files and change every intra-repository bound from `^>=0.1.1.2` to `^>=0.2.0.0`. Add a `0.2.0.0` section to each package's `CHANGELOG.md` and to the root `CHANGELOG.md`, marking as breaking the new `Connection` field, the new `ConformanceConfig` field and the new `InvariantName` constructor, and showing the one-line migration (`totalCount = Nothing`). Run `nix fmt`.

When all acceptance checks pass, set IR-1's `status` to the value its profile (`docs/improvement-requests/profile.dhall`) defines for implemented work, add a log entry to `docs/improvement-requests/log.md`, and validate that bundle. If the profile reserves that transition for the requester, leave the status and record in Outcomes & Retrospective which criteria were met.


## Concrete Steps

Work from the repository root in the development shell.

```bash
nix develop
cabal build all
cabal test all
```

Before any change, `cabal test all` passes for five suites: `relay-pagination-test`, `relay-pagination-hasql-tests`, `relay-pagination-servant-test`, `relay-pagination-conformance-test` and `members-server-test`. Run it once first to confirm the baseline. The database suites start their own PostgreSQL through `ephemeral-pg`; no server needs to be running.

During a milestone, run one suite and filter by test name with tasty's pattern option:

```bash
cabal test relay-pagination:relay-pagination-test --test-options='-p "/Connection JSON/"'
cabal test relay-pagination-hasql:relay-pagination-hasql-tests --test-options='-p "/total count/"'
```

New SQL golden files are created by `tasty-golden` on the first run when the file is missing; review the created file against the expected text in Milestone 2 before committing it. The OpenAPI golden files are different: tests only read them, and only the generator executables write them.

```bash
cabal run relay-pagination-servant:relay-demo-openapi
just openapi
git diff --exit-code relay-pagination-servant/test/golden/toy-openapi.json
```

The last command must print nothing and exit 0 at every point in this plan.

For the decision record and the release checks in Milestone 5:

```bash
okf id next docs/adr --profile docs/adr/profile.dhall ADR
okf validate docs/adr --strict --profile docs/adr/profile.dhall --profile-enforce --log-enforce
just check-adr
nix fmt
for p in relay-pagination relay-pagination-hasql relay-pagination-servant relay-pagination-conformance; do (cd "$p" && cabal check); done
```

`cabal check` must report no errors and no warnings for each package.

Commit at the end of each milestone with a Conventional Commits message and both trailers, for example:

```text
feat(core): carry an optional totalCount on Connection

Add Connection.totalCount and the CountedConnection wrapper. A connection
without a count encodes exactly as before.

ExecPlan: docs/plans/6-offer-an-opt-in-total-count-on-relay-connections.md
Intention: intention_01m7qmz011evp8hh9z2pxjewkw
```

Commit directly to the current branch; do not create a feature branch.


## Validation and Acceptance

The plan is accepted when all six criteria of IR-1 hold, each shown by the following.

AC-1 holds when `cabal test relay-pagination:relay-pagination-test` passes, including the unchanged exact-bytes tests for a connection without a count, the new exact-bytes test with `,"totalCount":42` at the end, and the decode tests for both shapes.

AC-2 holds when the `total count` group in the hasql suite passes: the count equals the base query's row count for a first page, a middle page, a backward page, a page size of 0 and an empty collection.

AC-3 holds when the single-transaction test passes, showing a count of 25 and no sight of the concurrently inserted row inside the `REPEATABLE READ` transaction and a count of 26 outside it, and when the guide and the `Relay.Pagination.Hasql` haddock contain the consistency statement.

AC-4 holds when the servant suite passes with the new counted golden, the counted schema lists `totalCount` as a required integer with minimum 0, and `git diff --exit-code relay-pagination-servant/test/golden/toy-openapi.json` shows the existing golden is byte-identical. In `docs/api/openapi.json` the `/members` path and the `Connection_Member` schema are unchanged.

AC-5 holds when the conformance suite passes: the counted oracle and the counted engine pass with `checkTotalCount` on, and the wrong-count, page-dependent-count and missing-count fixtures each fail with `TotalCountConsistency`. The earlier broken paginators still fail as before.

AC-6 holds when ADR-8 exists and `just check-adr` passes, the guides show the counted endpoint from the example's source, and the cursor golden tests in `relay-pagination-test` (the `cursor codec` group) and the fingerprint tests in the hasql suite pass with no change to their expected values.

The end-to-end check is the example server. Start it and compare the two routes:

```bash
just example
```

In a second terminal:

```bash
curl -s 'http://localhost:8080/members?first=2'
curl -s 'http://localhost:8080/members/counted?first=2'
curl -s 'http://localhost:8080/members/counted?first=0'
```

The first response has the keys `edges` and `pageInfo` only. The second has the same two keys followed by `totalCount` with the number of seeded members. The third has an empty `edges` array and the same `totalCount`. Following `pageInfo.endCursor` with `&after=<cursor>` on the counted route returns the same `totalCount` on every page. Stop the server with Ctrl-C in its terminal.

Finally `cabal test all` passes for all five suites.


## Idempotence and Recovery

Every step is an additive source edit and can be repeated. The generator commands (`cabal run relay-pagination-servant:relay-demo-openapi`, `just openapi`) overwrite their output files deterministically, so running them again gives the same bytes. If a golden file is wrong, fix the code and regenerate; do not edit a golden file by hand. If `toy-openapi.json` shows a diff, the uncounted schema has changed: restore the file with `git checkout -- relay-pagination-servant/test/golden/toy-openapi.json` and fix the `ToSchema (Connection a)` instance.

Milestone 1 leaves the repository uncompilable between adding the field and fixing the construction sites. Do both in one commit.

The single-transaction test inserts a row through a second connection. It must delete that row and release the second connection even when an assertion fails (use `finally` or tasty's `withResource`), because the rest of the group shares the fixture and expects 25 rows. Each test run starts a fresh database, so a failed run leaves nothing behind for the next one.

If `okf id next` returns a handle other than `ADR-8` because another record was added in the meantime, use the handle it returns and name the file accordingly. Never reuse or guess a handle.

Do not publish any package or create a release tag as part of this plan.


## Interfaces and Dependencies

No new library dependency is needed. `Natural` comes from `Numeric.Natural` in `base`; `aeson` already has JSON instances for it, and `openapi-hs` already has a schema for it. The repository pins `hasql >=1.10 && <1.11`; the test code in this repository already uses `Session.script` and `Session.statement` from that version. The copy of hasql in the local `mori` registry (`hasql/hasql`) is at 2.1.0.0, so check any other hasql function against the 1.10 documentation on Hackage, not against that copy.

At the end of the plan these must exist.

In `Relay.Pagination.Connection`, re-exported by `Relay.Pagination`:

```haskell
data Connection a = Connection
  { edges :: ![Edge a],
    pageInfo :: !PageInfo,
    totalCount :: !(Maybe Natural)
  }

-- A connection whose totalCount is present. The constructor is not exported.
newtype CountedConnection a

-- Attach a count, replacing any count already on the connection.
countedConnection :: Natural -> Connection a -> CountedConnection a

-- Nothing when the connection carries no count.
fromConnection :: Connection a -> Maybe (CountedConnection a)

-- The wrapped connection; its totalCount is always Just.
toConnection :: CountedConnection a -> Connection a

countedTotal :: CountedConnection a -> Natural
```

In `Relay.Pagination.Hasql.Sql`:

```haskell
totalCountSnippet :: Snippet -> Snippet
```

In `Relay.Pagination.Hasql`:

```haskell
totalCountStatement :: Snippet -> Statement () Natural

data CountedPage row = CountedPage
  { pageStatement :: !(Statement () (Connection row)),
    countStatement :: !(Statement () Natural)
  }

paginateCounted ::
  SortSpec row ->
  PageRequest ->
  Snippet ->
  Decoders.Row row ->
  Either CursorError (CountedPage row)
```

A caller combines the two results with `countedConnection <$> Session.statement () (countStatement p) <*> Session.statement () (pageStatement p)`. The page statement returned by `paginateCounted` is the one `paginate` returns, so its connection has `totalCount = Nothing` until the caller attaches the count.

In `Relay.Pagination.Servant.OpenApi`, an instance `(ToSchema a) => ToSchema (CountedConnection a)` whose schema is the connection schema with `totalCount` required, and a `ToSchema (Connection a)` instance whose schema has no `totalCount` property.

In `Relay.Pagination.Conformance.Check`, the field `checkTotalCount :: !Bool` on `ConformanceConfig` (off by default) and the constructor `TotalCountConsistency` on `InvariantName`.

The servant package must not depend on the hasql package, and the conformance library must depend only on core, as ADR-4 and ADR-5 require. `CountedConnection` lives in core for that reason: both the engine's callers and the servant schema need it.
