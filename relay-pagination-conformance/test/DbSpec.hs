{-# LANGUAGE BlockArguments #-}

-- | The conformance suite pointed at the real EP-3 keyset engine over
-- ephemeral-pg, fed by the adversarial generators. Every property inserts a
-- generated dataset, computes the expected canonical order in Haskell, and
-- requires a clean 'ConformanceReport'; failures print the rendered report
-- as the QuickCheck counterexample.
module DbSpec (tests) where

import Data.List (sortBy)
import Data.Text qualified as Text
import DbFixture
import Generators
import Hasql.Connection qualified as HasqlConn
import Relay.Pagination (toConnection)
import Relay.Pagination.Conformance.Check
import Relay.Pagination.Conformance.Walk (FetchPage)
import Test.Tasty
import Test.Tasty.QuickCheck

tests :: TestTree
tests = withResource acquireDb releaseDb \getDb ->
  -- Database-backed properties cost real time; 20 cases each is plenty
  -- given how adversarial the generators are. The group is sequential:
  -- its tests share one connection and one table, and the -threaded RTS
  -- (needed for warp in HttpSpec) lets tasty run tests concurrently.
  let uncounted = conformanceProperty getDb defaultConformanceConfig fetchViaEngine
      countedConfig size = (defaultConformanceConfig size) {checkTotalCount = True}
      countedFetch conn = fmap toConnection . fetchCountedViaEngine conn
   in localOption (QuickCheckTests 20) $
        sequentialTestGroup
          "db (EP-3 engine over ephemeral-pg)"
          AllFinish
          [ uncounted "heavy ties: boundaries inside tie runs" genHeavyTies,
            uncounted "adjacent microseconds" genAdjacentMicros,
            uncounted "exact page-boundary sizes" genExactBoundaries,
            uncounted "extreme page sizes (1 and 100)" genExtremeSizes,
            conformanceProperty getDb countedConfig countedFetch "counted engine agrees with the full walk" genExactBoundaries
          ]

conformanceProperty ::
  IO (db, HasqlConn.Connection) ->
  (Int -> ConformanceConfig) ->
  (HasqlConn.Connection -> FetchPage TestRow) ->
  TestName ->
  Gen (Int, [TestRow]) ->
  TestTree
conformanceProperty getDb configFor fetch name gen =
  testProperty name $
    forAll gen \(size, rows) -> ioProperty do
      (_, conn) <- getDb
      resetRows conn
      insertRows conn rows
      let expected = sortBy canonicalOrder rows
      report <-
        checkConformance (configFor size) rowId (fetch conn) expected
      pure $
        counterexample
          (Text.unpack (renderConformanceReport report))
          (conformancePassed report)
