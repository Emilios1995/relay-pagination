---
type: Improvement Request
title: "Offer an opt-in total count on Relay connections"
description: "A Connection carries only edges and pageInfo, and v1 explicitly leaves totalCount out. Consumers that sit behind a GraphQL gateway must report a non-null totalCount on every connection, so each service hand-writes a count query beside every paginate call, duplicating its base query."
generated:
  by: claude-code/claude-opus-5-5
  at: "2026-11-18T14:58:31Z"
requestId: IR-1
status: proposed
origin: mori://tan/agent-reputation-service
acceptanceCriteria:
  - id: AC-1
    statement: "The core Connection type can carry an optional non-negative total count, encoded as `totalCount` only when present. A connection without a count encodes byte-for-byte as it does today, and decoding accepts JSON with or without the field."
    verification: "Golden JSON tests for a connection with and without a count, plus decode tests for both shapes."
  - id: AC-2
    statement: "relay-pagination-hasql offers an entry point that, from the same base query `paginate` takes, also yields the number of rows the base query matches. The count is the size of the whole filtered collection, independent of the cursor, the direction and the page size."
    verification: "PostgreSQL integration tests compare the count with the base query's row count for a first page, a middle page (after), a backward page (before), an empty collection and a page size of 0."
  - id: AC-3
    statement: "A caller can run the count and the page in one transaction, and the documentation states what holds when they run separately under concurrent writes."
    verification: "A test runs both in a single transaction; the guide is reviewed for the consistency statement."
  - id: AC-4
    statement: "A servant endpoint can declare that it is counted. Its OpenAPI schema lists `totalCount` as a required integer with minimum 0, and the schemas of uncounted endpoints are unchanged."
    verification: "OpenAPI golden tests for a toy API with one counted and one uncounted endpoint, and the existing goldens pass unchanged."
  - id: AC-5
    statement: "For a counted endpoint, the conformance suite checks that totalCount is identical on every page of a walk over a stable dataset and equals the number of distinct nodes the walk collected."
    verification: "Conformance tests pass for a correct counted endpoint and fail for a fixture that reports a wrong or page-dependent count."
  - id: AC-6
    statement: "A decision record lifts the v1 exclusion and states the count's semantics and its opt-in nature. The guides show a counted endpoint. The v1 cursor format is unchanged."
    verification: "Documentation review against the implementation; the cursor golden tests pass unchanged."
reviews:
  - kind: model
    reviewer: claude-code
    reviewed_at: "2026-11-18T14:58:31Z"
    document_timestamp: "2026-11-18T14:58:31Z"
    scope: technical-accuracy
    outcome: commented
    provider: anthropic
    model: claude-opus-5-5
    effort: unspecified
    context: >-
      Author's source assessment while reconciling agent-reputation-service
      collections with a GraphQL gateway contract, not an independent approval
      or implementation test result. The Connection type, the hasql paginate
      entry point and the masterplan exclusion were checked against the
      release v0.1.1.2 (4f8cfba); library sources are unchanged through 65f1eda; the acceptance tests are
      proposed verification procedures.
---

# Offer an opt-in total count on Relay connections

## Context

At release v0.1.1.2 (source commit `4f8cfbaf0bc82394482df9e30233a5eafca1ddf7`; the library sources are unchanged through `65f1eda`), `Relay.Pagination.Connection` defines `Connection` with exactly two fields, `edges` and `pageInfo`, and its JSON instances read and write only those keys. The masterplan, [docs/masterplans/1-relay-compliant-cursor-pagination-library-for-servant-and-hasql.md](../masterplans/1-relay-compliant-cursor-pagination-library-for-servant-and-hasql.md), lists "`totalCount` computation (may be a later extension)" as out of scope. Its post-completion pointers name `totalCount` as a candidate extension that needs a new Decision Log entry.

`Relay.Pagination.Hasql.paginate` takes a base query (`SELECT <cols> FROM ... WHERE <filters>`, with no `ORDER BY` and no `LIMIT`) and returns one statement that yields the page. Nothing in the engine can count the rows that base query matches.

Services that adopt this library under `mori://tan/tan-platform/docs/adr-0024-standardize-relay-pagination-for-service-collections` are read through `mori://tan/api-gateway`. That gateway adds a non-null `totalCount: Int!` field to every GraphQL connection it builds: project-relative `lib/presentation/V2/builder.ts`, a `globalConnectionField`; the artifact-level URI is pending. Every connection a service returns must therefore come with a count.

`mori://tan/agent-reputation-service` already serves three paginated collections through `paginate`. These are project-relative `agent-reputation-service-core/src/AgentReputation/Invitation/History.hs`, `…/Endorsement/Profile.hs` and `…/Endorsement/Notes.hs`; the artifact-level URI is pending. More collections are planned. None can supply the count the gateway needs.

## Request

Let a connection optionally carry a total count, and let each layer produce and describe it.

- **Core:** add an optional non-negative count to `Connection`, serialized as `totalCount` only when present, so uncounted endpoints keep their exact wire shape.
- **hasql:** add an entry point that derives the count from the same base query `paginate` receives, for example `SELECT count(*) FROM (<base>) AS page_base`, with no cursor predicate, no order and no limit. The count means the size of the whole filtered collection, as the GraphQL connection convention uses `totalCount`. It does not mean the rows remaining after the cursor. Let callers run the count and the page statement in one transaction.
- **servant:** let an endpoint declare that it is counted. Its OpenAPI schema then marks `totalCount` as required, so generated clients and gateways can rely on it.
- **Conformance:** for counted endpoints, check that the count is stable across a walk and agrees with the nodes the walk collected.

Keep counting opt-in. `count(*)` can be expensive on large collections, and some endpoints deliberately don't expose a collection's size.

## Scope and adoption

Consumers work around the gap today in two ways:

- **A separate count endpoint**, which agent-reputation-service has for one collection. It costs a second HTTP call per page.
- **A hand-written count query beside each `paginate` call.** This repeats the base query and its filters, and can drift from the page it is meant to describe.

Both are repeated in every service.

Once this lands, a service passes the same base query once and returns a counted connection. A gateway can then map it onto its connection type without any extra request. The cursor format (ADR 2) and the PageInfo semantics are unaffected.
