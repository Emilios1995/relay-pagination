-- | A second toy API for testing counted and uncounted routes together.
module CountedToyApi
  ( CountedToyRoutes (..),
    CountedToyResult (..),
    countedToyApi,
    countedToyApp,
  )
where

import Data.Proxy (Proxy (..))
import Data.SOP (I (..), NS (..))
import GHC.Generics (Generic)
import Network.Wai (Application)
import Relay.Pagination (CountedConnection, countedConnection)
import Relay.Pagination.Servant (RelayPage, RelayPageError)
import Servant (serve)
import Servant.API (JSON, NamedRoutes, StdMethod (GET), (:-), (:>))
import Servant.API.MultiVerb (AsUnion (..), MultiVerb, Respond)
import ToyApi (Item, ToyItemsEndpoint, ToyRoutes (..), echoPage, toyServer)

type CountedToyResponses =
  '[ Respond 200 "Counted page of items" (CountedConnection Item),
     Respond 400 "Invalid pagination" RelayPageError
   ]

data CountedToyResult
  = CountedToyOk !(CountedConnection Item)
  | CountedToyBadRequest !RelayPageError
  deriving stock (Eq, Show)

instance AsUnion CountedToyResponses CountedToyResult where
  toUnion = \case
    CountedToyOk page -> Z (I page)
    CountedToyBadRequest err -> S (Z (I err))
  fromUnion = \case
    Z (I page) -> CountedToyOk page
    S (Z (I err)) -> CountedToyBadRequest err
    S (S impossible) -> case impossible of {}

data CountedToyRoutes mode = CountedToyRoutes
  { uncountedItems :: mode :- ToyItemsEndpoint,
    countedItems ::
      mode
        :- "counted-items"
          :> RelayPage 10 100
          :> MultiVerb 'GET '[JSON] CountedToyResponses CountedToyResult
  }
  deriving stock (Generic)

countedToyApi :: Proxy (NamedRoutes CountedToyRoutes)
countedToyApi = Proxy

countedToyApp :: Application
countedToyApp =
  serve countedToyApi $
    CountedToyRoutes
      { uncountedItems = items toyServer,
        countedItems = pure . CountedToyOk . countedConnection 42 . echoPage
      }
