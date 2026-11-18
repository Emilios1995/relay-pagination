# Changelog

All published packages in this repository share a single version and are
released together. Per-package details live in each package's own
`CHANGELOG.md`.

## 0.2.0.0 — 2026-11-18

### Added

- Count the full filtered collection with `paginateCounted` or `totalCountStatement`.
- Declare a required count on a Servant endpoint with `CountedConnection` and verify it with `checkTotalCount`.

### Breaking changes

- Set `totalCount = Nothing` when constructing an uncounted `Connection`.
- Set `checkTotalCount = False` when constructing `ConformanceConfig` manually to keep the previous behavior.
- Handle `TotalCountConsistency` in exhaustive matches on `InvariantName`.

Uncounted JSON, SQL, and OpenAPI retain their previous shapes. The v1 cursors remain compatible.

## 0.1.1.2 — 2026-10-06

### Fixed

- Replace the old ephemeral-pg source pin with the released >=0.3.1 && <0.4 range and share one stable effective-uid temporary root across PostgreSQL suites and the example service, preserving startup stale-instance sweeping.

## 0.1.1.1 — 2026-10-05

### Other Changes

- Admit http-api-data 0.7 in the core and Servant packages; keep 0.6 support.
- Align internal dependency bounds with this compatibility release.

## 0.1.1.0 — 2026-07-24

### Other Changes

- Updated `relay-pagination-servant` for `openapi-hs-5.0` and
  `servant-openapi-hs-5.1`.
- Updated repository dependency and release metadata.

## 0.1.0.0 — 2026-07-16

Initial release of the relay-pagination package family:

- **relay-pagination** — Relay-style cursor pagination wire types
  (`Connection`, `Edge`, `PageInfo`), an opaque versioned cursor codec, and
  validated pagination requests.
- **relay-pagination-hasql** — keyset-pagination engine producing Relay
  connections from hasql/PostgreSQL queries, with multi-column sort
  specifications, key codecs, and keyset SQL generation.
- **relay-pagination-servant** — `RelayPage` servant combinator for cursor
  pagination query parameters, with OpenAPI documentation support.
- **relay-pagination-conformance** — conformance suite services run against
  their own paginated endpoints to prove no-skip/no-duplicate behavior, with
  a bidirectional page walker and tasty integration.
