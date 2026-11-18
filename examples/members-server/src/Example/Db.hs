-- | Minimal session runner for the example. A real service would map
-- database errors onto its own error envelope; here any failure is fatal
-- (warp answers 500), which keeps the pagination wiring in focus.
module Example.Db (Db, openDb, closeDb, runDb, runRepeatableRead) where

import Control.Concurrent.MVar (MVar, newMVar, withMVar)
import Control.Exception (mask, onException)
import Control.Monad (void)
import Hasql.Connection qualified as HasqlConn
import Hasql.Connection.Settings (Settings)
import Hasql.Session qualified as Session

-- | The example shares one connection. Hold this lock through transaction
-- cleanup so another request cannot run on a failed transaction.
newtype Db = Db (MVar HasqlConn.Connection)

openDb :: Settings -> IO Db
openDb settings = do
  conn <- either (ioError . userError . show) pure =<< HasqlConn.acquire settings
  Db <$> newMVar conn

closeDb :: Db -> IO ()
closeDb (Db lock) = withMVar lock HasqlConn.release

-- | Run a session, turning any session error into a fatal 'IOError'.
runDb :: Db -> Session.Session a -> IO a
runDb (Db lock) session =
  withMVar lock $ \conn ->
    either (ioError . userError . show) pure =<< HasqlConn.use conn session

-- | Run all statements against one read-only PostgreSQL snapshot.
runRepeatableRead :: Db -> Session.Session a -> IO a
runRepeatableRead (Db lock) session =
  withMVar lock $ \conn -> mask $ \restore -> do
    let transaction =
          Session.script "BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY"
            *> session
            <* Session.script "COMMIT"
        rollback = void (HasqlConn.use conn (Session.script "ROLLBACK"))
    result <- restore (HasqlConn.use conn transaction) `onException` rollback
    case result of
      Left err -> rollback *> ioError (userError (show err))
      Right value -> pure value
