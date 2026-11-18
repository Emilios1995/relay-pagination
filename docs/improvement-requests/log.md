# Bundle Update Log

## 2026-11-18

* **Completion**: IR-1 meets AC-1 through AC-6. ExecPlan 6 records the passing suite, OpenAPI, and live HTTP evidence.

* **Addition**: IR-1 filed from mori://tan/agent-reputation-service: an opt-in `totalCount` on Relay connections, produced by the hasql engine from the same base query as the page and described as required in a counted endpoint's OpenAPI schema, for consumers behind a GraphQL gateway that requires a non-null count on every connection.
* **Adoption**: Adopt the `cross-repository-improvement-requests` profile (`coordination.improvementRequests`) from https://raw.githubusercontent.com/shinzui/okf-profiles/v0.25.0/package.dhall.
