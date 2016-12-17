{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
module GitHub.Types.Events.IssuesEvent where

import           Control.Applicative ((<$>), (<*>))
import           Data.Aeson          (FromJSON (..), ToJSON (..), object)
import           Data.Aeson.Types    (Value (..), (.:), (.:?), (.=))
import           Data.Text           (Text)

import           GitHub.Types.Base


data IssuesEvent = IssuesEvent
    { issuesEventOrganization :: Organization
    , issuesEventRepository   :: Repository
    , issuesEventSender       :: User

    , issuesEventAction       :: Text
    , issuesEventAssignee     :: Maybe User
    , issuesEventIssue        :: Issue
    } deriving (Eq, Show, Read)

instance FromJSON IssuesEvent where
    parseJSON (Object x) = IssuesEvent
        <$> x .: "organization"
        <*> x .: "repository"
        <*> x .: "sender"

        <*> x .: "action"
        <*> x .:? "assignee"
        <*> x .: "issue"

    parseJSON _ = fail "IssuesEvent"

instance ToJSON IssuesEvent where
    toJSON IssuesEvent{..} = object
        [ "organization" .= issuesEventOrganization
        , "repository"   .= issuesEventRepository
        , "sender"       .= issuesEventSender

        , "action"       .= issuesEventAction
        , "assignee"     .= issuesEventAssignee
        , "issue"        .= issuesEventIssue
        ]
