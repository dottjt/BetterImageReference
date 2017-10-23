module MainSearch exposing (..)

import Html exposing (..)
import Model exposing (..)
import Msg exposing (..)
import View exposing (..)
import Update exposing (..)
import Command exposing (..)

main : Program Never Model Msg
main =
    Html.program
        { init = initialModel
        , view = viewSearch
        , update = update
        , subscriptions = subscriptions
        }

initialModel : ( Model, Cmd Msg )
initialModel =
    { searchedCollections = []
    , selectedCollections = []
    , searchInput = ""
    , popularQueries = ["popular", "human figure", "face"]

    , applicationStatus = Stop
    , popupStatus = Resume
    , imageStatus = Normal

    , imageTime = 0
    , imagerTimerBarProgress = 0

    , radioIntervalType = Second
    , radioIntervalTiming = S30

    , radioIntervalCustomInput = 0    
    , radioUpsideDown = NoUpsideDown
    , radioDistraction = NoMinimalDistraction

    , loadedCollectionImagesList = []
    
    , error = "" 
    } ! [initialFetchQuery]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

