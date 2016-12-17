{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
module GitHub.Types.Events.PullRequestEvent where

import           Control.Applicative ((<$>), (<*>))
import           Data.Aeson          (FromJSON (..), ToJSON (..), object)
import           Data.Aeson.Types    (Value (..), (.:), (.:?), (.=))
import           Data.Text           (Text)

import           GitHub.Types.Base


data PullRequestEvent = PullRequestEvent
    { pullRequestEventOrganization :: Organization
    , pullRequestEventRepository   :: Repository
    , pullRequestEventSender       :: User

    , pullRequestEventAction       :: Text
    , pullRequestEventAfter        :: Maybe Text
    , pullRequestEventAssignee     :: Maybe User
    , pullRequestEventBefore       :: Maybe Text
    , pullRequestEventChanges      :: Maybe Changes
    , pullRequestEventNumber       :: Int
    , pullRequestEventPullRequest  :: PullRequest
    } deriving (Eq, Show, Read)

instance FromJSON PullRequestEvent where
    parseJSON (Object x) = PullRequestEvent
        <$> x .: "organization"
        <*> x .: "repository"
        <*> x .: "sender"

        <*> x .: "action"
        <*> x .:? "after"
        <*> x .:? "assignee"
        <*> x .:? "before"
        <*> x .:? "changes"
        <*> x .: "number"
        <*> x .: "pull_request"

    parseJSON _ = fail "PullRequestEvent"

instance ToJSON PullRequestEvent where
    toJSON PullRequestEvent{..} = object $
        [ "organization" .= pullRequestEventOrganization
        , "repository"   .= pullRequestEventRepository
        , "sender"       .= pullRequestEventSender

        , "action"       .= pullRequestEventAction
        , "after"        .= pullRequestEventAfter
        , "assignee"     .= pullRequestEventAssignee
        , "before"       .= pullRequestEventBefore
        , "changes"      .= pullRequestEventChanges
        , "number"       .= pullRequestEventNumber
        , "pull_request" .= pullRequestEventPullRequest
        ]
