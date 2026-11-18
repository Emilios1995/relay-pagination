-- | Deterministic rendering of the toy API's OpenAPI 3.1 document, shared by
-- the @relay-demo-openapi@ generator (which writes the checked artifact) and
-- the test suite (which compares the checked bytes against this exact
-- rendering, read-only).
module ToyOpenApi
  ( toyOpenApi,
    renderToyOpenApi,
    countedToyOpenApi,
    renderCountedToyOpenApi,
  )
where

import Control.Lens (ix, (&), (?~), _Just)
import CountedToyApi (countedToyApi)
import Data.Aeson.Encode.Pretty (Config (..), defConfig, encodePretty')
import Data.ByteString.Lazy (ByteString)
import Data.OpenApi (OpenApi, allOperations, get, operationId, paths)
import Relay.Pagination.Servant.OpenApi ()
import Servant.OpenApi (toOpenApi)
import ToyApi (toyApi)

-- | Derived from the exact proxy passed to @serve@, then enriched with the
-- one thing the route types cannot carry: a stable operation id.
toyOpenApi :: OpenApi
toyOpenApi = toOpenApi toyApi & allOperations . operationId ?~ "getItems"

-- | Byte-stable output for the checked artifact and the drift test: sorted
-- keys, one trailing newline.
renderToyOpenApi :: ByteString
renderToyOpenApi = render toyOpenApi

countedToyOpenApi :: OpenApi
countedToyOpenApi =
  toOpenApi countedToyApi
    & paths . ix "/items" . get . _Just . operationId ?~ "getItems"
    & paths . ix "/counted-items" . get . _Just . operationId ?~ "getCountedItems"

renderCountedToyOpenApi :: ByteString
renderCountedToyOpenApi = render countedToyOpenApi

render :: OpenApi -> ByteString
render doc = encodePretty' defConfig {confCompare = compare} doc <> "\n"
