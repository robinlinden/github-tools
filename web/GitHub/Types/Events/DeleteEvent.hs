{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
module GitHub.Types.Events.DeleteEvent where

import           Control.Applicative ((<$>), (<*>))
import           Data.Aeson          (FromJSON (..), ToJSON (..), object)
import           Data.Aeson.Types    (Value (..), (.:), (.=))
import           Data.Text           (Text)

import           GitHub.Types.Base


data DeleteEvent = DeleteEvent
    { deleteEventOrganization :: Organization
    , deleteEventRepository   :: Repository
    , deleteEventSender       :: User

    , deleteEventPusherType   :: Text
    , deleteEventRef          :: Text
    , deleteEventRefType      :: Text
    } deriving (Eq, Show, Read)

instance FromJSON DeleteEvent where
    parseJSON (Object x) = DeleteEvent
        <$> x .: "organization"
        <*> x .: "repository"
        <*> x .: "sender"

        <*> x .: "pusher_type"
        <*> x .: "ref"
        <*> x .: "ref_type"

    parseJSON _ = fail "DeleteEvent"

instance ToJSON DeleteEvent where
    toJSON DeleteEvent{..} = object
        [ "organization" .= deleteEventOrganization
        , "repository"   .= deleteEventRepository
        , "sender"       .= deleteEventSender

        , "pusher_type"  .= deleteEventPusherType
        , "ref"          .= deleteEventRef
        , "ref_type"     .= deleteEventRefType
        ]
