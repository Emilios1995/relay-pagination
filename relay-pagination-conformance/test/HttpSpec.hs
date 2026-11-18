{-# LANGUAGE BlockArguments #-}

-- | The three packages composed over real HTTP: a warp server exposing the
-- EP-3 engine through EP-2's 'RelayPage' combinator in a 'NamedRoutes'
-- record, walked by the same 'checkConformance' the direct-session tests
-- use — with 'FetchPage' wired through servant-client. This proves the
-- combinator's request parsing, the typed 'MultiVerb' result, and core's
-- JSON round-trip do not perturb the conformance guarantees.
module HttpSpec (tests) where

import Control.Exception (onException)
import Control.Monad.IO.Class (liftIO)
import Data.List (sortBy)
import Data.Proxy (Proxy (..))
import Data.SOP (I (..), NS (..))
import Data.Text qualified as Text
import Data.UUID.Types qualified as UUID
import DbFixture
import GHC.Generics (Generic)
import Hasql.Connection qualified as HasqlConn
import Network.HTTP.Client qualified as HttpClient
import Network.Wai.Handler.Warp (testWithApplication)
import Relay.Pagination
import Relay.Pagination.Conformance.Check
import Relay.Pagination.Conformance.Walk (FetchPage)
import Relay.Pagination.Hasql.KeyCodec (microsToUtcTime)
import Relay.Pagination.Servant
import Servant (Application, serve)
import Servant.API (JSON, NamedRoutes, StdMethod (GET), (:-), (:>))
import Servant.API.MultiVerb (AsUnion (..), MultiVerb, Respond)
import Servant.Client (BaseUrl (..), ClientEnv, ClientM, Scheme (Http), mkClientEnv, runClientM)
import Servant.Client.Generic (AsClientT, genericClient)
import Servant.Server.Generic (AsServerT)
import Servant.Server.Internal (Handler)
import Test.Tasty
import Test.Tasty.HUnit

type RowsPageResponses page =
  '[ Respond 200 "Page of rows" page,
     Respond 400 "Invalid pagination" RelayPageError
   ]

data RowsPageResult page
  = RowsPageOk !page
  | RowsPageBadRequest !RelayPageError
  deriving stock (Show)

-- | Hand-written, per ADR 1: status/constructor mapping breaks at compile
-- time if the response list changes.
instance AsUnion (RowsPageResponses page) (RowsPageResult page) where
  toUnion = \case
    RowsPageOk value -> Z (I value)
    RowsPageBadRequest err -> S (Z (I err))
  fromUnion = \case
    Z (I value) -> RowsPageOk value
    S (Z (I err)) -> RowsPageBadRequest err
    S (S impossible) -> case impossible of {}

type RowsEndpoint page =
  RelayPage 5 50 :> MultiVerb 'GET '[JSON] (RowsPageResponses page) (RowsPageResult page)

data RowsRoutes mode = RowsRoutes
  { rows :: mode :- "rows" :> RowsEndpoint (Connection TestRow),
    countedRows :: mode :- "counted-rows" :> RowsEndpoint (CountedConnection TestRow)
  }
  deriving stock (Generic)

-- | One proxy for both @serve@ and @genericClient@, so the served and
-- called route types cannot drift apart.
rowsApi :: Proxy (NamedRoutes RowsRoutes)
rowsApi = Proxy

rowsServer :: HasqlConn.Connection -> RowsRoutes (AsServerT Handler)
rowsServer conn =
  RowsRoutes
    { rows = liftIO . fmap RowsPageOk . fetchViaEngine conn,
      countedRows = liftIO . fmap RowsPageOk . fetchCountedViaEngine conn
    }

rowsApp :: HasqlConn.Connection -> Application
rowsApp conn = serve rowsApi (rowsServer conn)

rowsClient :: RowsRoutes (AsClientT ClientM)
rowsClient = genericClient

-- | Translate the walker's 'PageRequest' back into Relay query arguments:
-- Forward becomes @first@ + @after@, Backward becomes @last@ + @before@.
toClientPage :: PageRequest -> ClientPage
toClientPage PageRequest {pageSize = size, direction = dir, cursor = mCursor} =
  case dir of
    Forward -> forwardPage size mCursor
    Backward -> backwardPage size mCursor

tests :: TestTree
tests = withResource acquireAndSeed releaseDb \getDb ->
  testGroup
    "http (RelayPage over warp)"
    [ walkThroughClient getDb "conformance walk through servant-client" config (clientFetch id (rows rowsClient)),
      walkThroughClient
        getDb
        "counted conformance walk through servant-client"
        (config {checkTotalCount = True})
        (clientFetch toConnection (countedRows rowsClient))
    ]
  where
    config = defaultConformanceConfig 5
    acquireAndSeed = do
      resource@(_, conn) <- acquireDb
      insertRows conn fixtureRows `onException` releaseDb resource
      pure resource

walkThroughClient ::
  IO (db, HasqlConn.Connection) ->
  TestName ->
  ConformanceConfig ->
  (ClientEnv -> FetchPage TestRow) ->
  TestTree
walkThroughClient getDb name config fetch = testCase name do
  (_, conn) <- getDb
  testWithApplication (pure (rowsApp conn)) \port -> do
    manager <- HttpClient.newManager HttpClient.defaultManagerSettings
    let env = mkClientEnv manager (BaseUrl Http "127.0.0.1" port "")
    report <- checkConformance config rowId (fetch env) (sortBy canonicalOrder fixtureRows)
    assertBool (Text.unpack (renderConformanceReport report)) (conformancePassed report)

clientFetch ::
  (page -> Connection TestRow) ->
  (ClientPage -> ClientM (RowsPageResult page)) ->
  ClientEnv ->
  FetchPage TestRow
clientFetch unwrap request env req =
  runClientM (request (toClientPage req)) env >>= \case
    Right (RowsPageOk page) -> pure (unwrap page)
    Right (RowsPageBadRequest err) -> fail ("server rejected pagination: " <> show err)
    Left clientError -> fail ("transport failure: " <> show clientError)

-- | 25 deterministic rows in the EP-3 integration fixture's adversarial
-- shape: two ten-way timestamp ties, a microsecond-adjacent pair, three
-- distinct older stamps. 25 rows at page size 5 make the final page exactly
-- full.
fixtureRows :: [TestRow]
fixtureRows =
  [row n 1767323045123456 | n <- [1 .. 10]]
    <> [row n 1767323044123456 | n <- [11 .. 20]]
    <> [ row 21 1767323043000001,
         row 22 1767323043000002,
         row 23 1767323042000000,
         row 24 1767323041000000,
         row 25 1767323040000000
       ]
  where
    row n stamp =
      TestRow
        { rowId = UUID.fromWords 0 0 0 (fromIntegral (n :: Int)),
          updatedAt = microsToUtcTime stamp,
          payload = "row-" <> Text.pack (show n)
        }
