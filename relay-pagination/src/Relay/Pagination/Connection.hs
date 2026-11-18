{-# LANGUAGE BlockArguments #-}

-- | The Relay connection response envelope. JSON encoding follows the Relay
-- convention exactly: {"edges":[{"node":...,"cursor":"..."}],"pageInfo":
-- {"hasNextPage":...,"hasPreviousPage":...,"startCursor":...,"endCursor":...}}
-- with null cursors on empty pages. When present, the optional count is
-- encoded last as @totalCount@. Encodings use a fixed field order.
module Relay.Pagination.Connection
  ( Connection (..),
    CountedConnection,
    countedConnection,
    fromConnection,
    toConnection,
    countedTotal,
    Edge (..),
    PageInfo (..),
  )
where

import Data.Aeson ((.:), (.:?), (.=))
import Data.Aeson qualified as Aeson
import GHC.Generics (Generic)
import Numeric.Natural (Natural)
import Relay.Pagination.Cursor (Cursor)

-- | One returned row ('node') plus the cursor that addresses its position.
data Edge a = Edge
  { node :: !a,
    cursor :: !Cursor
  }
  deriving stock (Eq, Show, Functor, Foldable, Traversable, Generic)

instance (Aeson.ToJSON a) => Aeson.ToJSON (Edge a) where
  toJSON e = Aeson.object ["node" .= node e, "cursor" .= cursor e]
  toEncoding e = Aeson.pairs ("node" .= node e <> "cursor" .= cursor e)

instance (Aeson.FromJSON a) => Aeson.FromJSON (Edge a) where
  parseJSON = Aeson.withObject "Edge" \o -> Edge <$> o .: "node" <*> o .: "cursor"

-- | Relay pageInfo. 'startCursor' / 'endCursor' are the first/last edge's
-- cursors, or Nothing (JSON null) when the page is empty.
data PageInfo = PageInfo
  { hasNextPage :: !Bool,
    hasPreviousPage :: !Bool,
    startCursor :: !(Maybe Cursor),
    endCursor :: !(Maybe Cursor)
  }
  deriving stock (Eq, Show, Generic)

instance Aeson.ToJSON PageInfo where
  toJSON p =
    Aeson.object
      [ "hasNextPage" .= hasNextPage p,
        "hasPreviousPage" .= hasPreviousPage p,
        "startCursor" .= startCursor p,
        "endCursor" .= endCursor p
      ]
  toEncoding p =
    Aeson.pairs
      ( "hasNextPage" .= hasNextPage p
          <> "hasPreviousPage" .= hasPreviousPage p
          <> "startCursor" .= startCursor p
          <> "endCursor" .= endCursor p
      )

instance Aeson.FromJSON PageInfo where
  parseJSON = Aeson.withObject "PageInfo" \o ->
    PageInfo
      <$> o .: "hasNextPage"
      <*> o .: "hasPreviousPage"
      <*> o .:? "startCursor"
      <*> o .:? "endCursor"

-- | A page of results in Relay connection shape. Edges are always in the
-- endpoint's canonical sort order regardless of paging direction.
data Connection a = Connection
  { edges :: ![Edge a],
    pageInfo :: !PageInfo,
    -- | The size of the whole filtered collection, when requested.
    totalCount :: !(Maybe Natural)
  }
  deriving stock (Eq, Show, Functor, Foldable, Traversable, Generic)

instance (Aeson.ToJSON a) => Aeson.ToJSON (Connection a) where
  toJSON c =
    Aeson.object $
      ["edges" .= edges c, "pageInfo" .= pageInfo c]
        <> maybe [] (pure . ("totalCount" .=)) (totalCount c)
  toEncoding c =
    Aeson.pairs
      ( "edges" .= edges c
          <> "pageInfo" .= pageInfo c
          <> foldMap ("totalCount" .=) (totalCount c)
      )

instance (Aeson.FromJSON a) => Aeson.FromJSON (Connection a) where
  parseJSON = Aeson.withObject "Connection" \o ->
    Connection <$> o .: "edges" <*> o .: "pageInfo" <*> o .:? "totalCount"

-- | A connection with a required total count.
newtype CountedConnection a = CountedConnection (Connection a)
  deriving stock (Eq, Show, Functor, Foldable, Traversable)

-- | Attach a count, replacing any existing count.
countedConnection :: Natural -> Connection a -> CountedConnection a
countedConnection n c = CountedConnection (c {totalCount = Just n})

-- | Require a count on an existing connection.
fromConnection :: Connection a -> Maybe (CountedConnection a)
fromConnection c = CountedConnection c <$ totalCount c

-- | Recover the connection, whose 'totalCount' is always 'Just'.
toConnection :: CountedConnection a -> Connection a
toConnection (CountedConnection c) = c

-- | The size of the whole filtered collection.
countedTotal :: CountedConnection a -> Natural
countedTotal (CountedConnection Connection {totalCount = Just n}) = n
countedTotal _ = error "CountedConnection invariant violated: missing totalCount"

instance (Aeson.ToJSON a) => Aeson.ToJSON (CountedConnection a) where
  toJSON = Aeson.toJSON . toConnection
  toEncoding = Aeson.toEncoding . toConnection

instance (Aeson.FromJSON a) => Aeson.FromJSON (CountedConnection a) where
  parseJSON value = do
    c <- Aeson.parseJSON value
    maybe (fail "CountedConnection requires totalCount") pure (fromConnection c)
