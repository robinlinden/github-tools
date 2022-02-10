{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import qualified Data.ByteString.Char8   as BS8
import           Data.String             (fromString)
import qualified Data.Text               as Text
import qualified GitHub
import           System.Environment      (getArgs, lookupEnv)

import           GitHub.Tools.Changelogs


main :: IO ()
main = do
  (ownerName, repoName) <- getArgs >>= repoLocation

  -- Get auth token from the $GITHUB_TOKEN environment variable.
  auth <- fmap (GitHub.OAuth . BS8.pack) <$> lookupEnv "GITHUB_TOKEN"

  fetchChangeLog True ownerName repoName auth >>= putStr . Text.unpack . formatChangeLog True

  where
    repoLocation [] =
      return ("TokTok", "c-toxcore")
    repoLocation [ownerName, repoName] =
      return (fromString ownerName, fromString repoName)
    repoLocation _ =
      fail "Usage: hub-roadmap <owner> <repo>"
