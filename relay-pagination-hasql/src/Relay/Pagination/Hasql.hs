-- | Keyset-pagination engine for Relay-style cursors over hasql.
--
-- Given a base query 'Snippet' (filters included, no @ORDER BY@, no
-- @LIMIT@), a 'SortSpec' (ordered sort columns ending in a unique
-- tie-breaker, each with a typed codec), and a row decoder, 'paginate'
-- produces a 'Statement' that fetches one validated page and assembles a
-- spec-correct 'Connection'. Cursor values always travel as typed SQL
-- parameters; malformed cursors surface as 'CursorError' before any SQL
-- runs.
--
-- Use 'paginateCounted' to also count every row that matches the base query,
-- independently of cursor, direction, and page size. Counting can be slow
-- on large collections, so it is opt-in. Run both statements in one
-- @REPEATABLE READ@ or @SERIALIZABLE@ transaction to read the same snapshot.
-- With separate statements or @READ COMMITTED@, a concurrent write can
-- make the page and count reflect different snapshots.
module Relay.Pagination.Hasql
  ( -- * Sort specifications
    SortDirection (..),
    KeyColumn (..),
    SortSpec (..),
    sortSpecFingerprint,

    -- * Codecs
    KeyCodec (..),
    int8Key,
    textKey,
    uuidKey,
    timestamptzKey,
    boolKey,

    -- * Engine
    paginate,
    paginateCounted,
    CountedPage (..),
    totalCountStatement,
    paginateSnippet,
    mkConnection,
    mintCursor,
  )
where

import Hasql.Decoders qualified as Decoders
import Hasql.DynamicStatements.Snippet (Snippet)
import Hasql.DynamicStatements.Snippet qualified as Snippet
import Hasql.Statement (Statement)
import Numeric.Natural (Natural)
import Relay.Pagination (Connection, CursorError, PageRequest)
import Relay.Pagination.Hasql.Connection (mintCursor, mkConnection)
import Relay.Pagination.Hasql.KeyCodec
  ( KeyCodec (..),
    boolKey,
    int8Key,
    textKey,
    timestamptzKey,
    uuidKey,
  )
import Relay.Pagination.Hasql.SortSpec
  ( KeyColumn (..),
    SortDirection (..),
    SortSpec (..),
    sortSpecFingerprint,
  )
import Relay.Pagination.Hasql.Sql (paginateSnippet, totalCountSnippet)

-- | The whole engine in one function: validate the request's cursor against
-- the sort specification, generate the keyset query, and post-process the
-- fetched rows into a 'Connection'.
--
-- 'Left' means the cursor failed to decode against this spec (wrong
-- fingerprint, key count, or key types) — surfaced before any SQL runs;
-- handlers map it to HTTP 400. The statement is unpreparable (dynamic SQL;
-- see hasql-dynamic-statements). Run it with e.g.
-- @Hasql.Session.statement () stmt@.
paginate ::
  SortSpec row ->
  PageRequest ->
  -- | Base query: @SELECT <cols> FROM ... WHERE <filters>@; no @ORDER BY@,
  -- no @LIMIT@.
  Snippet ->
  Decoders.Row row ->
  Either CursorError (Statement () (Connection row))
paginate spec req base rowDecoder = do
  snippet <- paginateSnippet spec req base
  Right (mkConnection spec req <$> Snippet.toStatement snippet (Decoders.rowList rowDecoder))

-- | The page statement and the count statement for its filtered collection.
-- Attach their results with 'Relay.Pagination.countedConnection'.
data CountedPage row = CountedPage
  { pageStatement :: !(Statement () (Connection row)),
    countStatement :: !(Statement () Natural)
  }

-- | Build an unprepared statement that counts the rows of the base query.
totalCountStatement :: Snippet -> Statement () Natural
totalCountStatement base =
  Snippet.toStatement (totalCountSnippet base) $
    fromIntegral <$> Decoders.singleRow (Decoders.column (Decoders.nonNullable Decoders.int8))

-- | Validate and build the page statement as in 'paginate', and derive a
-- count statement from the same base query.
paginateCounted ::
  SortSpec row ->
  PageRequest ->
  Snippet ->
  Decoders.Row row ->
  Either CursorError (CountedPage row)
paginateCounted spec req base rowDecoder = do
  page <- paginate spec req base rowDecoder
  pure CountedPage {pageStatement = page, countStatement = totalCountStatement base}
