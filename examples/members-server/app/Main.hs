-- | Boot the example members-server: start an ephemeral PostgreSQL cluster,
-- create and seed the members schema, and serve the API on port 8080.
--
-- Run from the repository root:
--
-- > just example
--
-- (or @cabal run members-server@). No external database or docker is
-- required. The cluster is stopped when the example server exits.
module Main (main) where

import Control.Exception (bracket)
import Data.Text qualified as Text
import EphemeralPg qualified as Pg
import Example.Db (closeDb, openDb)
import Example.Members.Handler (membersApp)
import Example.Members.Seed (createMembersSchema, insertMembers, seedMembers)
import Network.Wai.Handler.Warp (run)
import Relay.Pagination.Test.Postgres (ephemeralPgConfig)

main :: IO ()
main = serveMembers 8080

serveMembers :: Int -> IO ()
serveMembers port = do
  config <- ephemeralPgConfig
  -- startCached caches initdb output, so repeat boots are fast.
  let start = either (fail . Text.unpack . Pg.renderStartError) pure =<< Pg.startCached config Pg.defaultCacheConfig
  bracket start Pg.stop $ \pg ->
    bracket (openDb (Pg.connectionSettings pg)) closeDb $ \db -> do
      createMembersSchema db
      insertMembers db seedMembers
      putStrLn ("members-server listening on http://localhost:" <> show port)
      run port (membersApp db)
