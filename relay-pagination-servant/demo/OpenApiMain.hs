-- | Writes the checked OpenAPI 3.1 artifact. This executable is the __only__
-- thing allowed to write the toy OpenAPI goldens. The test suite compares
-- the checked bytes read-only.
--
-- Run from the repository root:
--
-- > cabal run relay-pagination-servant:relay-demo-openapi
module Main (main) where

import Data.ByteString.Lazy qualified as LBS
import ToyOpenApi (renderCountedToyOpenApi, renderToyOpenApi)

main :: IO ()
main = do
  writeGolden "toy-openapi.json" renderToyOpenApi
  writeGolden "toy-counted-openapi.json" renderCountedToyOpenApi
  where
    writeGolden file bytes = do
      let artifactPath = "relay-pagination-servant/test/golden/" <> file
      LBS.writeFile artifactPath bytes
      putStrLn ("wrote " <> artifactPath)
