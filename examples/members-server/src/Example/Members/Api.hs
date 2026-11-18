-- | The example's route types. One 'appApi' proxy is shared by @serve@, the
-- typed client, and OpenAPI derivation, so what is served, called, and
-- documented cannot drift apart.
--
-- Routes live in domain-owned 'Servant.API.NamedRoutes' records and terminal
-- operations are 'MultiVerb's whose response lists carry both the success and
-- the pagination-error body, per docs/adr/1-haskell-language-and-api-conventions.md
-- and docs/adr/4-servant-pagination-surface.md.
module Example.Members.Api
  ( MemberPageResponses,
    MemberPageResult (..),
    ListMembersEndpoint,
    CountedMemberPageResponses,
    CountedMemberPageResult (..),
    ListMembersCountedEndpoint,
    MemberRoutes (..),
    AppRoutes (..),
    appApi,
  )
where

import Data.OpenApi (OpenApi)
import Data.Proxy (Proxy (..))
import Data.SOP (I (..), NS (..))
import Example.Members.Domain (Member)
import GHC.Generics (Generic)
import Relay.Pagination (Connection, CountedConnection)
import Relay.Pagination.Servant (RelayPage, RelayPageError)
import Servant.API (JSON, NamedRoutes, StdMethod (GET), (:-), (:>))
import Servant.API.MultiVerb (AsUnion (..), MultiVerb, MultiVerb1, Respond)

-- | The two responses @GET /members@ can produce. Declaring the 400 here is
-- what makes the generated client decode the error body the 'RelayPage'
-- combinator actually emits, and what documents it in OpenAPI.
type MemberPageResponses =
  '[ Respond 200 "Page of members" (Connection Member),
     Respond 400 "Invalid pagination" RelayPageError
   ]

-- | The handler-facing sum mirroring 'MemberPageResponses'.
data MemberPageResult
  = MemberPageOk !(Connection Member)
  | MemberPageBadRequest !RelayPageError
  deriving stock (Eq, Show)

-- | Hand-written on purpose: the mapping between a result constructor and
-- its HTTP status is load-bearing, so adding or reordering a response
-- alternative must stop compiling rather than silently renumber.
instance AsUnion MemberPageResponses MemberPageResult where
  toUnion = \case
    MemberPageOk page -> Z (I page)
    MemberPageBadRequest err -> S (Z (I err))
  fromUnion = \case
    Z (I page) -> MemberPageOk page
    S (Z (I err)) -> MemberPageBadRequest err
    S (S impossible) -> case impossible of {}

-- | @GET /members?first=&after=&last=&before=@ with a default page size of 3
-- (so a bare @GET /members@ shows a partial page) and a maximum of 50.
type ListMembersEndpoint =
  "members"
    :> RelayPage 3 50
    :> MultiVerb 'GET '[JSON] MemberPageResponses MemberPageResult

type CountedMemberPageResponses =
  '[ Respond 200 "Counted page of members" (CountedConnection Member),
     Respond 400 "Invalid pagination" RelayPageError
   ]

data CountedMemberPageResult
  = CountedMemberPageOk !(CountedConnection Member)
  | CountedMemberPageBadRequest !RelayPageError
  deriving stock (Eq, Show)

instance AsUnion CountedMemberPageResponses CountedMemberPageResult where
  toUnion = \case
    CountedMemberPageOk page -> Z (I page)
    CountedMemberPageBadRequest err -> S (Z (I err))
  fromUnion = \case
    Z (I page) -> CountedMemberPageOk page
    S (Z (I err)) -> CountedMemberPageBadRequest err
    S (S impossible) -> case impossible of {}

-- | @GET /members/counted@ uses the same pagination arguments and includes
-- the total number of members matched by the query.
type ListMembersCountedEndpoint =
  "members"
    :> "counted"
    :> RelayPage 3 50
    :> MultiVerb 'GET '[JSON] CountedMemberPageResponses CountedMemberPageResult

-- | The members domain's routes.
data MemberRoutes mode = MemberRoutes
  { listMembers :: mode :- ListMembersEndpoint,
    listMembersCounted :: mode :- ListMembersCountedEndpoint
  }
  deriving stock (Generic)

-- | The whole app: the members routes plus the served OpenAPI document.
data AppRoutes mode = AppRoutes
  { members :: mode :- NamedRoutes MemberRoutes,
    openapi ::
      mode
        :- "openapi.json"
          :> MultiVerb1 'GET '[JSON] (Respond 200 "OpenAPI 3.1 document" OpenApi)
  }
  deriving stock (Generic)

-- | The single proxy shared by @serve@, @genericClient@, and @toOpenApi@.
appApi :: Proxy (NamedRoutes AppRoutes)
appApi = Proxy
