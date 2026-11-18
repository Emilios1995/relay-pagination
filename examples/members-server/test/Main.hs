{-# LANGUAGE BlockArguments #-}

-- | The example's conformance test: walk the running server through its
-- typed servant client with 'checkConformance' — the same suite consuming
-- services run against their own endpoints — and prove the typed client
-- distinguishes the success and 'RelayPageError' arms.
--
-- The database-backed cases share one seeded cluster, so they run under
-- 'sequentialTestGroup' (per docs/adr/5-conformance-suite-boundary-and-walker-contract.md:
-- the @-threaded@ RTS warp needs makes tasty run tests concurrently).
module Main (main) where

import Control.Exception (bracketOnError, try)
import Data.Aeson (Object, eitherDecode)
import Data.Aeson.KeyMap qualified as KeyMap
import Data.List (sortBy)
import Data.Text qualified as Text
import EphemeralPg qualified as Pg
import Example.Db (Db, closeDb, openDb, runDb, runRepeatableRead)
import Example.Members.Api (AppRoutes (..), CountedMemberPageResult (..), MemberPageResult (..), MemberRoutes (..))
import Example.Members.Domain (Member (..), canonicalOrder)
import Example.Members.Handler (membersApp)
import Example.Members.Seed (createMembersSchema, insertMembers, seedMembers)
import Hasql.Session qualified as Session
import Network.HTTP.Client qualified as HttpClient
import Network.HTTP.Types (status200)
import Network.Wai.Handler.Warp (testWithApplication)
import Relay.Pagination
import Relay.Pagination.Conformance
import Relay.Pagination.Servant
  ( ClientPage (..),
    RelayPageError (..),
    backwardPage,
    forwardPage,
  )
import Relay.Pagination.Test.Postgres (ephemeralPgConfig)
import Servant.Client (ClientEnv, ClientM, mkClientEnv, parseBaseUrl, runClientM)
import Servant.Client.Generic (AsClientT, genericClient)
import Test.Tasty
import Test.Tasty.HUnit

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests = withResource acquireExample releaseExample \getExample ->
  sequentialTestGroup
    "members-server"
    AllFinish
    [ testCase "conformance walk through the typed client (page size 3)" do
        (_, conn) <- getExample
        withClientEnv conn \env ->
          assertConformance (defaultConformanceConfig 3) (fetchPage env),
      testCase "conformance walk straddling the created_at tie (page size 4)" do
        (_, conn) <- getExample
        withClientEnv conn \env ->
          assertConformance (defaultConformanceConfig 4) (fetchPage env),
      testCase "counted conformance walk through the typed client" do
        (_, db) <- getExample
        withClientEnv db \env ->
          assertConformance ((defaultConformanceConfig 3) {checkTotalCount = True}) (fetchCountedPage env),
      testCase "uncounted route omits totalCount from raw JSON" do
        (_, db) <- getExample
        testWithApplication (pure (membersApp db)) \port -> do
          manager <- HttpClient.newManager HttpClient.defaultManagerSettings
          request <- HttpClient.parseRequest ("http://127.0.0.1:" <> show port <> "/members?first=2")
          response <- HttpClient.httpLbs request manager
          HttpClient.responseStatus response @?= status200
          body <- either assertFailure pure (eitherDecode @Object (HttpClient.responseBody response))
          assertBool "totalCount is absent" (not (KeyMap.member "totalCount" body)),
      testCase "failed counted transaction rolls back before the connection is reused" do
        (_, db) <- getExample
        failure <- try @IOError (runRepeatableRead db (Session.script "SELECT 1 / 0"))
        case failure of
          Left _ -> runDb db (Session.script "SELECT 1")
          Right () -> assertFailure "expected a transaction error",
      testCase "first+last is a typed 400: mixed_pagination_directions" do
        (_, conn) <- getExample
        withClientEnv conn \env -> do
          result <-
            listPage
              env
              ClientPage {first = Just 3, after = Nothing, last = Just 3, before = Nothing}
          assertErrorCode "mixed_pagination_directions" result,
      testCase "foreign-fingerprint cursor is a typed 400: invalid_cursor" do
        (_, conn) <- getExample
        withClientEnv conn \env -> do
          -- Well-formed base64url, so the combinator admits it; the engine
          -- then rejects it against the members sort specification.
          let foreign' =
                encodeCursor
                  CursorPayload {version = cursorVersion, fingerprint = 0, keys = []}
          result <- listPage env (forwardPage 3 (Just foreign'))
          assertErrorCode "invalid_cursor" result
    ]

-- * The system under test: the real app over warp, called via the typed client

appClient :: AppRoutes (AsClientT ClientM)
appClient = genericClient

listPage :: ClientEnv -> ClientPage -> IO MemberPageResult
listPage env page =
  either (fail . ("transport failure: " <>) . show) pure
    =<< runClientM (listMembers (members appClient) page) env

-- | The conformance walker's 'PageRequest' translated back into Relay query
-- arguments: Forward becomes @first@ + @after@, Backward @last@ + @before@.
fetchPage :: ClientEnv -> FetchPage Member
fetchPage env req =
  listPage env (toClientPage req) >>= \case
    MemberPageOk page -> pure page
    MemberPageBadRequest err -> fail ("server rejected pagination: " <> show err)

fetchCountedPage :: ClientEnv -> FetchPage Member
fetchCountedPage env req =
  runClientM (listMembersCounted (members appClient) (toClientPage req)) env >>= \case
    Right (CountedMemberPageOk page) -> pure (toConnection page)
    Right (CountedMemberPageBadRequest err) -> fail ("server rejected pagination: " <> show err)
    Left clientError -> fail ("transport failure: " <> show clientError)

toClientPage :: PageRequest -> ClientPage
toClientPage PageRequest {pageSize = size, direction = dir, cursor = mCursor} =
  case dir of
    Forward -> forwardPage size mCursor
    Backward -> backwardPage size mCursor

withClientEnv :: Db -> (ClientEnv -> IO a) -> IO a
withClientEnv conn use =
  testWithApplication (pure (membersApp conn)) \port -> do
    manager <- HttpClient.newManager HttpClient.defaultManagerSettings
    baseUrl <- parseBaseUrl ("http://127.0.0.1:" <> show port)
    use (mkClientEnv manager baseUrl)

assertConformance :: ConformanceConfig -> FetchPage Member -> IO ()
assertConformance config fetch = do
  report <-
    checkConformance
      config
      (\Member {id = memberId} -> memberId)
      fetch
      (sortBy canonicalOrder seedMembers)
  assertBool (Text.unpack (renderConformanceReport report)) (conformancePassed report)

assertErrorCode :: Text.Text -> MemberPageResult -> IO ()
assertErrorCode expected = \case
  MemberPageBadRequest RelayPageError {code = actual} -> actual @?= expected
  MemberPageOk _ -> assertFailure "expected a 400, got a 200 page"

-- * Fixture

acquireExample :: IO (Pg.Database, Db)
acquireExample = do
  config <- ephemeralPgConfig
  let start = either (fail . Text.unpack . Pg.renderStartError) pure =<< Pg.startCached config Pg.defaultCacheConfig
  bracketOnError start Pg.stop \pg ->
    bracketOnError (openDb (Pg.connectionSettings pg)) closeDb \db -> do
      createMembersSchema db
      insertMembers db seedMembers
      pure (pg, db)

releaseExample :: (Pg.Database, Db) -> IO ()
releaseExample (pg, db) = closeDb db *> Pg.stop pg
