---
okf_version: "0.2"
---

# Files

- [profile.dhall](profile.dhall)

# Improvement Request

- [Offer an opt-in total count on Relay connections](offer-an-opt-in-total-count-on-relay-connections.md) - A Connection carries only edges and pageInfo, and v1 explicitly leaves totalCount out. Consumers that sit behind a GraphQL gateway must report a non-null totalCount on every connection, so each service hand-writes a count query beside every paginate call, duplicating its base query.
