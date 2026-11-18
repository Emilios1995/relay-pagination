---
okf_version: "0.2"
---

# Files

- [profile.dhall](profile.dhall)

# Architecture Decision Record

- [Haskell language and API conventions](1-haskell-language-and-api-conventions.md) - Pin the GHC2024/GHC 9.12 baseline, Cabal common-stanza extensions, Servant NamedRoutes/MultiVerb conventions, and same-proxy OpenAPI generation for every package.
- [Cursor wire format v1](2-cursor-wire-format.md) - Pin the opaque pagination cursor as unpadded base64url over compact, tagged, integer-exact JSON so cursors decode stably across releases.
- [Hasql keyset engine — predicate form, fingerprint, and v1 restrictions](3-hasql-keyset-engine.md) - Fix the expanded-lexicographic keyset predicate, the sort-spec fingerprint algorithm, and the NOT NULL/unique-tiebreaker v1 restrictions for the hasql pagination engine.
- [Servant pagination surface — RelayPage, the 400 envelope, and OpenAPI policy](4-servant-pagination-surface.md) - Define the type-level RelayPage combinator, its public 400 RelayPageError envelope, the servant/hasql validation split, and the canonical OpenAPI orphan-instance module.
- [Conformance suite — package boundary, walker contract, and invariants](5-conformance-suite-boundary-and-walker-contract.md) - Define the conformance package's core-only boundary, plain-IO FetchPage contract, and seven invariants including opt-in total count consistency.
- [Release packaging — per-package changelogs, version bounds, and release order](6-release-packaging-and-ordering.md) - Require per-package CHANGELOG.md files, version bounds on every build-depends entry, and a fixed release order across the four published packages.
- [The example server is an unreleased, CI-built package and the guides' single source of truth](7-example-server-as-unreleased-ci-built-package.md) - Make examples/members-server a fifth, unreleased, CI-built package whose source is machine-checked as the single source of truth for every guide code snippet.
- [Opt-in total count on Relay connections](8-opt-in-total-count.md) - Count the whole filtered collection on demand with a separate statement and declare the required count through CountedConnection.
