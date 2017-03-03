module Silences.Decoders exposing (..)

import Json.Decode as Json exposing (field)
import Utils.Api exposing (iso8601Time, duration)
import Silences.Types exposing (Silence)
import Utils.Types exposing (Matcher, Time)


show : Json.Decoder Silence
show =
    Json.at [ "data" ] silence


list : Json.Decoder (List Silence)
list =
    Json.at [ "data" ] (Json.list silence)


create : Json.Decoder String
create =
    Json.at [ "data", "silenceId" ] Json.string



-- This should just be the ID


destroy : Json.Decoder String
destroy =
    Json.at [ "status" ] Json.string


silence : Json.Decoder Silence
silence =
    Json.map8 Silence
        (field "id" Json.string)
        (field "createdBy" Json.string)
        (field "comment" Json.string)
        (field "startsAt" iso8601Time)
        (field "endsAt" iso8601Time)
        (duration "startsAt" "endsAt")
        (field "updatedAt" iso8601Time)
        (field "matchers" (Json.list matcher))


matcher : Json.Decoder Matcher
matcher =
    Json.map3 Matcher
        (field "name" Json.string)
        (field "value" Json.string)
        (field "isRegex" Json.bool)
